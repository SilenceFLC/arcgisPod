//
//  YGNStandardTaskViewController.m
//  SunShineRN
//
//  Created by 冯立昌 on 2019/12/26.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "YGNStandardTaskViewController.h"
#import "YGNStandardTaskViewController+SetupSubviews.h"
#import "YGNStandardTaskViewController+setUpEditorStyle.h"
#import "YGNStandardTaskViewController+drawAction.h"
#import "Colours.h"
@interface YGNStandardTaskViewController ()<AGSGeoViewTouchDelegate>

@end

@implementation YGNStandardTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _currentTool=0;
     [self createMapSubViews];
     [self addServicesToMap];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
          self.navigationController.interactivePopGestureRecognizer.enabled = NO;
     }
}
/// 创建mapVIew的子Views
-(void)createMapSubViews
{
    self.mapView =[[AGSMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mapView];
//    self.mapView.map = [[AGSMap alloc] initWithBasemapType:AGSBasemapTypeImageryWithLabels latitude: 34.056295  longitude: -117.195800 levelOfDetail: 16];

   
    self.mapView.interactionOptions.rotateEnabled=NO;/// 是否允许旋转
    self.mapView.interactionOptions.magnifierEnabled=NO; /// 是否显示放大镜
    self.mapView.interactionOptions.allowMagnifierToPan=NO;/// /// 是否自动缩放
    self.mapView.attributionTextVisible=NO;
    
    self.mapView.locationDisplay.useCourseSymbolOnMovement=YES;/// 是否显示导航前进方向
    self.mapView.locationDisplay.showAccuracy=NO;/// 是否显示精度
    self.mapView.locationDisplay.showPingAnimationSymbol=NO;
    self.mapView.locationDisplay.defaultSymbol =[AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:[UIImage imageNamed:@"icon_mylocation"]];
    self.mapView.locationDisplay.courseSymbol = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:[UIImage imageNamed:@"icon_mylocation"]];
    
    self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeRecenter;
    
    self.mapView.touchDelegate =  self;
  
    ///  设置面积填充属性
    AGSSimpleLineSymbol * slSymbol = [[AGSSimpleLineSymbol alloc] initWithStyle:(AGSSimpleLineSymbolStyleSolid) color:[UIColor colorFromHexString:@"f0ebeb"] width:1];
     AGSSimpleFillSymbol * polygonSymbol = [AGSSimpleFillSymbol simpleFillSymbolWithStyle:(AGSSimpleFillSymbolStyleSolid) color: [UIColor colorWithRGBAHexString:@"66f0ebeb"] outline:slSymbol];
     self.selectedSymbol =polygonSymbol;
  /// 默认选中高清地图
     _selectedMapIndex=0;
    [self setupTools];
    [self setupPopover];
    [self setupSketchEditor];
  

}

///  添加服务到map
-(void)addServicesToMap
{
    /// 地理坐标 4490 GCS_China_Geodetic_Coordinate_System_2000
    self.map = [[AGSMap alloc] initWithSpatialReference: [AGSSpatialReference spatialReferenceWithWKID:4490]];
    self.map.maxScale = 1128;
    /// 天地图影像服务
    TianDiTuLayerInfo *tdtInfo = [[TianDiTuLayerInfo alloc] initwithlayerType:TDT_IMAGE SpatialReferenceWKID:TDT_2000];
   TianDiTuLayer *ltl1 = [[TianDiTuLayer alloc] initWithTianDiTuLayerInfo:tdtInfo];
    /// 天地图矢量图服务
    TianDiTuLayerInfo *tdtInfo2 = [[TianDiTuLayerInfo alloc] initwithlayerType:TDT_VECTOR SpatialReferenceWKID:TDT_2000];
      TianDiTuLayer *ltl2 = [[TianDiTuLayer alloc] initWithTianDiTuLayerInfo:tdtInfo2];
      ltl2.visible= NO;
    /// 天地图影像标注服务(路网)
    TianDiTuLayerInfo *tdtInfo3 = [[TianDiTuLayerInfo alloc] initwithlayerType:TDT_VECTOR_ANNO SpatialReferenceWKID:TDT_2000];
    self.roadLayer =[[TianDiTuLayer alloc] initWithTianDiTuLayerInfo:tdtInfo3];
   ///  广东省天地图地址
    TianDiTuLayerInfo *tdtInfo4 = [[TianDiTuLayerInfo alloc] initwithlayerType:TDT_IMAGE_GD SpatialReferenceWKID:TDT_2000_CUSTOM];
    TianDiTuLayer *ltl4 = [[TianDiTuLayer alloc] initWithTianDiTuLayerInfo:tdtInfo4];
    ltl4.minScale = 18055;
//    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
//    self.ltl4.visible = delegate.showLevel16;
    
    self.roadLayer.visible = YES;
    
//    [self.map.basemap.baseLayers addObjectsFromArray:@[ltl1,ltl2,ltl4,self.roadLayer]];
  [self.map.basemap.baseLayers addObject:ltl1];
  [self.map.basemap.baseLayers addObject:ltl2];
  [self.map.basemap.baseLayers addObject:self.roadLayer];
//  [self.map.basemap.baseLayers addObject:ltl4];
    
    self.mapView.map = self.map;
    self.mapView.touchDelegate = self;
    /// 初始化视图点
    AGSViewpoint *vp=[AGSViewpoint viewpointWithCenter:[AGSPoint pointWithX:113.2643446427 y:23.1290765766 spatialReference:[AGSSpatialReference spatialReferenceWithWKID:4490]] scale:18489297.737236];
    self.map.initialViewpoint =vp;
    [self.mapView.locationDisplay startWithCompletion:nil];
    ///  显示文字的图层（xx.xx亩或者xx.xx米）
    AGSGraphicsOverlay* overlay = [[AGSGraphicsOverlay alloc] init];
    [self.mapView.graphicsOverlays addObject:overlay];
    self.overlay = overlay;

    AGSGraphicsOverlay* blockOverlay = [[AGSGraphicsOverlay alloc] init];
    [self.mapView.graphicsOverlays addObject:blockOverlay];
    self.blockOverlay = blockOverlay;

    AGSGraphicsOverlay* ldOverlay = [[AGSGraphicsOverlay alloc] init];
    [self.mapView.graphicsOverlays addObject:ldOverlay];
    self.ldOverlay = ldOverlay;

    AGSGraphicsOverlay* blockLabelOverlay = [[AGSGraphicsOverlay alloc] init];
    [self.mapView.graphicsOverlays addObject:blockLabelOverlay];
    self.blockLabelOverlay = blockLabelOverlay;
    //self.blockLabelOverlay.minScale=40000;
    AGSGraphicsOverlay* ldLabelOverlay = [[AGSGraphicsOverlay alloc] init];
    [self.mapView.graphicsOverlays addObject:ldLabelOverlay];
    self.ldLabelOverlay = ldLabelOverlay;
    //self.ldLabelOverlay.minScale=40000;

    AGSGraphicsOverlay* drawAreaOVerlay = [[AGSGraphicsOverlay alloc] init];
    [self.mapView.graphicsOverlays addObject:drawAreaOVerlay];
    self.drawAreaOVerlay = drawAreaOVerlay;

    AGSGraphicsOverlay* plotAreaOverlay = [[AGSGraphicsOverlay alloc] init];
    [self.mapView.graphicsOverlays addObject:plotAreaOverlay];
    self.plotAreaOverlay = plotAreaOverlay;
//
//
//
//    AGSGraphicsOverlay* ybOverlay = [[AGSGraphicsOverlay alloc] init];
//    [self.mapView.graphicsOverlays addObject:ybOverlay];
//    self.ybOverlay = ybOverlay;
}

#pragma mark-----弹框tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=nil;
    if (indexPath.section == 0) {
        static NSString *cellId = @"cellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellId];
        }
        YNBLayerModel *layer =  [self.layers objectAtIndex:indexPath.row];
        cell.textLabel.text = layer.name;
        
        cell.textLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
        cell.textLabel.textColor=[UIColor colorFromHexString:@"212121"];
        cell.imageView.image = [UIImage imageNamed:layer.image];
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchView setBackgroundColor:[UIColor colorFromHexString:@"b3b1b1"]];
        [switchView setOnTintColor:[UIColor colorFromHexString:@"db3c27"]];
        [switchView setTintColor:[UIColor colorFromHexString:@"b3b1b1"]];
        [switchView setThumbTintColor:[UIColor whiteColor]];
        switchView.layer.cornerRadius = 15.5f;
        switchView.layer.masksToBounds = YES;
        if (cell.accessoryView) {
            [cell.accessoryView removeFromSuperview];
        }
        cell.accessoryView = switchView;
        switchView.tag = 2000+indexPath.row;
        if(layer.visible)
        {
            [switchView setOn:YES animated:NO];
        }
        else{
            [switchView setOn:NO animated:NO];
        }
        
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
      UITableViewCell *cell=[UITableViewCell new];
      return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}
-(UIView*)tableHeaderView
{
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 90)];
        YNBMapItemView * item1 = [[YNBMapItemView alloc] initWithFrame:CGRectMake(10, 10, 80, 70) title:@"高清地图" image:[UIImage imageNamed:@"icon_rs"]];
        self.item1 =item1;
        item1.delegate = self;
        item1.tag =3001;
        YNBMapItemView * item2 = [[YNBMapItemView alloc] initWithFrame:CGRectMake(90, 10, 90, 70) title:@"电子地图" image:[UIImage imageNamed:@"icon_streetmap"]];
        self.item2 =item2;
        item2.delegate = self;
        item2.tag =3002;
        [_tableHeaderView addSubview:item1];
        [_tableHeaderView addSubview:item2];
        _tableHeaderView.backgroundColor=[UIColor whiteColor];
    }
    if (_selectedMapIndex ==0) {
        self.item1.selected=YES;
        self.item2.selected=NO;
    }
    else
    {
        self.item1.selected=NO;
        self.item2.selected=YES;
    }
    return _tableHeaderView;
}
-(void) itemClicked:(YNBMapItemView*)view
{
    if (view.tag == 3001) {
        self.item1.selected=YES;
        self.item2.selected=NO;
        [self.map.basemap.baseLayers objectAtIndex:0].visible = YES;
        [self.map.basemap.baseLayers objectAtIndex:1].visible = NO;
    }
    if (view.tag == 3002) {
        self.item1.selected=NO;
        self.item2.selected=YES;
        [self.map.basemap.baseLayers objectAtIndex:0].visible = NO;
        [self.map.basemap.baseLayers objectAtIndex:1].visible = YES;
    }
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * rtn =@"";
    if (section == 0) {
        rtn=@"业务数据";
    }
    else
    {
         rtn=@"地类";
    }
    return rtn;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return [_layers count];
    }
    else
    {
        return 0;
    }
}
// 弹窗视图 控制业务数据（路网、行政、验标、承保）显示与否
-(void)switchChanged:(id)sender
{
    UISwitch *sw = (UISwitch*)sender;
    if (sw.tag == 2000) {
        if (sw.on) {
            self.roadLayer.visible=YES;
        }
        else
        {
            self.roadLayer.visible=NO;
        }
    }
//    if (sw.tag == 2001) {
//        if (sw.on) {
//            _showAdmin=YES;
//            self.adminLayer.visible=YES;
//        }
//        else
//        {
//            _showAdmin=NO;
//            self.adminLayer.visible=NO;
//        }
//    }
//    if (sw.tag == 2002) {
//        if (sw.on) {
//            _showYB=YES;
//            [self fetchYB];
//        }
//        else
//        {
//            _showYB=NO;
//            self.ybOverlay.visible=NO;
//        }
//    }
//    if (sw.tag == 2003) {
//        if (sw.on) {
//            _showCB=YES;
//            self.cbLayer.visible=YES;
//        }
//        else
//        {
//            _showCB=NO;
//            self.cbLayer.visible=NO;
//        }
//    }
}
@end
