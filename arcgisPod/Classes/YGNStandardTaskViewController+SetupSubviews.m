//
//  YGNStandardTaskViewController+SetupSubviews.m
//  SunShineRN
//
//  Created by 冯立昌 on 2019/12/27.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "YGNStandardTaskViewController+SetupSubviews.h"



@implementation YGNStandardTaskViewController (SetupSubviews)
/// 配置工具图层
-(void)setupTools
{
    /// 定位
    DDButtonView *myLocationButton = [[DDButtonView alloc] initWithFrame:CGRectMake(DEVICEWIDTH-60,DEVICEHIGHT-124,44,44) iconSize:CGSizeMake(40, 40)];
  
    [self.view addSubview:myLocationButton];
    myLocationButton.backgroundColor =[UIColor whiteColor];
    myLocationButton.delegate = self;
    myLocationButton.tag=1001;
    myLocationButton.buttonImage =[UIImage imageNamed:@"icon_location"];
    myLocationButton.isShowBorder = YES;
    /// layer（定位上方按钮）
    DDButtonView *layerButton = [[DDButtonView alloc] initWithFrame:CGRectMake(DEVICEWIDTH-60, DEVICEHIGHT-174,44,44) iconSize:CGSizeMake(40, 40)];
    [self.view addSubview:layerButton];
    layerButton.backgroundColor =[UIColor whiteColor];
    layerButton.delegate = self;
    layerButton.tag=1002;
    layerButton.buttonImage =[UIImage imageNamed:@"icon_layer"];
    layerButton.isShowBorder = YES;
    /// 图例视图（水田）旱田 林地、验标正常、验标异常、未验标
    YNBStandardTaskLengendView * lengendView = [[YNBStandardTaskLengendView alloc] initWithFrame:CGRectMake(10, DEVICEHIGHT-284-73, 100, 146/2)];
    [self.view addSubview:lengendView];
    /// 返回按钮
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backButton setImage:[UIImage imageNamed:@"mapBack"] forState:(UIControlStateNormal)];
    [backButton setFrame:CGRectMake(0, 30, 44, 44)];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(mapBack:) forControlEvents:(UIControlEventTouchDown)];
    
    /// 画面积和轨迹追踪
    NSArray * images=@[[UIImage imageNamed:@"icon_draw"],[UIImage imageNamed:@"icon_draw_run"]];
    YNBMapToolsView *tool1View = [[YNBMapToolsView alloc] initWithFrame:(CGRectMake(DEVICEWIDTH- 60, DEVICEHIGHT-384, 44, 88)) tools:images];
    tool1View.backgroundColor=[UIColor whiteColor];
    tool1View.tag = 2001;
    [self.view addSubview:tool1View];
    tool1View.delegate = self;
    self.tool1View = tool1View;
    
    /// 测量长度和面积
    NSArray * images2=@[[UIImage imageNamed:@"icon_mesure_len"],[UIImage imageNamed:@"icon_mesure_area"]];
    YNBMapToolsView *tool2View = [[YNBMapToolsView alloc] initWithFrame:(CGRectMake(DEVICEWIDTH- 60, DEVICEHIGHT-278, 44, 88)) tools:images2];
    tool2View.backgroundColor=[UIColor whiteColor];
    tool2View.tag = 2002;
    tool2View.delegate = self;
    [self.view addSubview:tool2View];
    self.toolsView = tool2View;
    
    /// 删除和撤销
    NSArray * images3=@[[UIImage imageNamed:@"icon_map_del"],[UIImage imageNamed:@"icon_undo"]];
    YNBMapToolsView *tool3View = [[YNBMapToolsView alloc] initWithFrame:(CGRectMake(DEVICEWIDTH- 60, DEVICEHIGHT-278, 44, 88)) tools:images3];
    tool3View.backgroundColor=[UIColor whiteColor];
    tool3View.hidden=YES;
    tool3View.tag = 2003;
    tool3View.delegate = self;
    [self.view addSubview:tool3View];
    self.editToolsView = tool3View;
    // 底部展示的View（完成验标、下一步）
    self.standardToolView = [[YNBStandardToolView alloc] initWithFrame:CGRectMake(20, DEVICEHIGHT-70, DEVICEWIDTH-40, 60)];
    self.standardToolView.delegate = self;
    [self.view addSubview:self.standardToolView];
    self.standardToolView.hidden=YES;
    self.finishButton =[UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.finishButton setTitle:@"完成图形" forState:(UIControlStateNormal)];
    [self.view addSubview:self.finishButton];
    self.finishButton.hidden=YES;
    [self.finishButton setFrame:CGRectMake((DEVICEWIDTH-120)/2, DEVICEHIGHT-80, 120, 40)];
    [self.finishButton addTarget:self action:@selector(finish:) forControlEvents:(UIControlEventTouchDown)];
    [self.finishButton setBackgroundColor:[UIColor whiteColor]];
    self.finishButton.layer.cornerRadius=20;
    self.finishButton.clipsToBounds=YES;
    [self.finishButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
/// 定位和弹窗按钮点击
-(void) buttonViewClick:(DDButtonView*)view
{
    switch (view.tag-1000) {
        case 1:
        {
             [self myLocation:view];
        }
            break;
        case 2:
        {
            [self showLayers:view];
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}
-(void)myLocation:(UIView*)view
{
    self.mapView.locationDisplay.autoPanMode=AGSLocationDisplayAutoPanModeRecenter;
    if (!self.mapView.locationDisplay.started) {
        [self.mapView.locationDisplay startWithCompletion:^(NSError * _Nullable error) {
            
        }];
    }
    else
    {
        [self.mapView setViewpointCenter:self.mapView.locationDisplay.mapLocation  scale:2000 completion:nil];
    }
}
#pragma mark layers
-(void)showLayers:(UIView*)sender
{
    [self updateTableViewFrame];
    
    CGPoint startPoint =CGPointMake(CGRectGetMidX(sender.frame) , CGRectGetMinY(sender.frame) );
    [self.popover showAtPoint:startPoint
               popoverPostion:DXPopoverPositionUp
              withContentView:self.layersTableView
                       inView:self.view];
    
    __weak typeof(self) weakSelf = self;
    self.popover.didDismissHandler = ^{
        
    };
}
- (void)updateTableViewFrame {
    CGRect tableViewFrame = self.layersTableView.frame;
    tableViewFrame.size.width = self.popoverWidth;
    self.layersTableView.frame = tableViewFrame;
    self.popover.contentInset = UIEdgeInsetsZero;
    self.popover.backgroundColor = [UIColor whiteColor];
}

/// 返回
-(void)mapBack:(id)sender
{
    [self dismissViewController];
}
/// 返回（区分是不是从add进来的）
-(void)dismissViewController
{
    if (self.fromAdd) {
        NSArray *vcs=self.navigationController.viewControllers;
        [self.navigationController popToViewController:[vcs objectAtIndex:[vcs count]-3] animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:true];
    }
}
///  配置弹窗
-(void) setupPopover{
    self.popover = [DXPopover new];
    self.popoverWidth = 200.0;
    self.layersTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.popoverWidth, 438) style:(UITableViewStylePlain)];
    self.layersTableView.tag =1001;
    self.layersTableView.dataSource = self;
    self.layersTableView.delegate = self;
    self.layersTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.layersTableView.tableHeaderView = self.tableHeaderView;
    //self.layersTableView.backgroundColor=[UIColor colorFromHexString:@"f7f7f7"];
     self.layersTableView.backgroundColor=[UIColor  whiteColor];
//    [self.layersTableView registerClass:[YNBStandardMapLayerCell class] forCellReuseIdentifier:@"YNBStandardMapLayerCell"];
    
    [self setupLayers];
  
}
-(void)setupLayers
{
    self.layers = [NSMutableArray new];
  
    [self.layers addObject:[[YNBLayerModel alloc] initWithName:@"路网" image:@"icon_road" visible:NO]];
  
  
    [self.layers addObject:[[YNBLayerModel alloc] initWithName:@"行政边界" image:@"icon_province" visible:NO]];
    [self.layers addObject:[[YNBLayerModel alloc] initWithName:@"验标覆盖" image:@"icon_standard_overlay" visible:YES]];
    [self.layers addObject:[[YNBLayerModel alloc] initWithName:@"承保区域" image:@"icon_policy_area" visible:NO]];
    
}


@end
