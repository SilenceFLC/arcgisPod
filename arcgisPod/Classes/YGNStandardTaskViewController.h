//
//  YGNStandardTaskViewController.h
//  SunShineRN
//
//  Created by 冯立昌 on 2019/12/26.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
//#import "YGNStandardTaskViewController+SetupSubviews.h"

#import "TianDiTuLayerInfo.h"
#import "TianDiTuLayer.h"
#import "DXPopover.h"
#import "YNBLayerModel.h"
#import "YNBMapItemView.h"
#import "YNBMapToolsView.h"
#import "YNBStandardToolView.h"
#import "DDButtonView.h"
#import "YNBStandardTaskLengendView.h"
#import "YNBGeometryUtil.h"
#import "CRToastManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YGNStandardTaskViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DDButtonViewDelegate,YYNBMapToolsViewDelegate,YNBStandardToolViewDelegate>
@property(nonatomic,assign)BOOL fromAdd;
@property(nonatomic,assign)NSInteger taskId;
@property(nonatomic,strong)NSString * currentCode;
@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)AGSEnvelope * extent;
/// arcgis 地图view
@property(nonatomic,strong)AGSMapView *mapView;
/// arcgis 地图view的底图 map
@property(nonatomic,strong)AGSMap *map;

/// 选中的地图类型 0：高清地图  1：电子地图
@property(nonatomic,assign)NSInteger selectedMapIndex;
/// 路网layer
@property(nonatomic,strong)TianDiTuLayer * roadLayer;
/// 弹窗选择视图View（选择地图：高清/电子  是否显示路网、行政区域、验标、承保险）
@property(nonatomic,strong)DXPopover *popover;
/// 弹窗选择视图View的子tableView
@property(nonatomic,strong)UITableView * layersTableView;
/// 弹窗选择视图View宽度
@property(nonatomic,assign)CGFloat popoverWidth;
///弹窗选择视图 路网、行政区域、验标、承保险 数组array
@property(nonatomic,strong)NSMutableArray *layers;
///  弹窗选择视图View的子tableView的headerView
@property(nonatomic,strong)UIView * tableHeaderView;
///  高清地图选项View
@property(nonatomic,strong)YNBMapItemView * item1;
///  电子地图选项View
@property(nonatomic,strong)YNBMapItemView * item2;

///  显示文字的图层（xx.xx亩或者xx.xx米）
@property(nonatomic,strong)AGSGraphicsOverlay* overlay;
/// 绘制的面积图层
@property(nonatomic,strong)AGSGraphicsOverlay* plotAreaOverlay;
/// 绘制的验标图层
@property(nonatomic,strong)AGSGraphicsOverlay* ybOverlay;
/// 绘制的
@property(nonatomic,strong)AGSGraphicsOverlay* blockOverlay;

@property(nonatomic,strong)AGSGraphicsOverlay* ldOverlay;
@property(nonatomic,strong)AGSGraphicsOverlay* blockLabelOverlay;
@property(nonatomic,strong)AGSGraphicsOverlay* ldLabelOverlay;
@property(nonatomic,strong)AGSGraphicsOverlay* drawAreaOVerlay;
@property(nonatomic,strong) YNBMapToolsView *tool1View ;
@property(nonatomic,strong)UIButton * cropButton;
@property(nonatomic,strong)UIButton * finishButton;
@property(nonatomic,strong)YNBMapToolsView * toolsView;
@property(nonatomic,strong)YNBMapToolsView * editToolsView;

/// 当前选中了哪一个
@property(nonatomic,assign)NSInteger currentTool;
/// 底部展示的View（完成验标、下一步）
@property(nonatomic,strong)YNBStandardToolView *standardToolView;
@property(nonatomic,strong)AGSGraphic * tempGraphic;
@property(nonatomic,strong)NSArray * plots;
//@property(nonatomic,strong)YNBStandardTask * task;
@property(nonatomic,strong)UIButton *infoButton;
//@property(nonatomic,strong)YNBArcGISAccount * account;
@property(nonatomic,strong)AGSCredential * credential;
@property(nonatomic,strong)AGSServiceFeatureTable* flTable;
@property(nonatomic,strong)AGSRenderer *renderer;
@property(nonatomic,strong)AGSSimpleFillSymbol *selectedSymbol;
@property(nonatomic,strong)AGSFeatureLayer * featureLayer;
@property(nonatomic,strong)AGSFeatureCollectionLayer *collectionnLayer;
//@property(nonatomic,strong)YNBUploadManager * uploadManager;

@property(nonatomic,strong)AGSServiceFeatureTable* flTableAdmin;
@property(nonatomic,strong)AGSRenderer *renderer1;
@property(nonatomic,strong)AGSFeatureLayer * featureLayerAdmin;
@property(nonatomic,strong)AGSFeatureCollectionLayer *collectionnLayerAdmin;

@property(nonatomic,strong)AGSLayer * adminLayer;
@property(nonatomic,strong)AGSLayer * cbLayer;
@property(nonatomic,strong)AGSServiceFeatureTable* flTableLand;
@property(nonatomic,strong)AGSServiceFeatureTable* flTableLD;
@property(nonatomic,strong)NSString *landUrl;
@property(nonatomic,strong)NSString *ldUrl;

@property(nonatomic,assign)NSInteger selectedTypes;
/// 是否显示验标
@property(nonatomic,assign)BOOL showYB;
///  是否显示行政
@property(nonatomic,assign)BOOL showAdmin;
///  是否显示承保
@property(nonatomic,assign)BOOL showCB;
///  天地图layer
//@property(nonatomic,strong)TianDiTuLayer *ltl4;
///  高清地图layer
@property(nonatomic,strong)AGSLayer* highResLayer;

@end

NS_ASSUME_NONNULL_END
