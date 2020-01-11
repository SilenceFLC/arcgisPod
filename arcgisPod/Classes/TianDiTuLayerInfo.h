//
//  TianDiTuLayerInfo.h
//  MapViewDemo-ObjC
//
//  Created by maklMac on 1/6/17.
//  Copyright © 2017 Esri. All rights reserved.
//

#import <ArcGIS/ArcGIS.h>

typedef enum{
    TDT_VECTOR = 0, ///<天地图矢量服务>
    TDT_IMAGE=1, ///<天地图影像务>
    TDT_TERRAIN=2, ///<天地图地形服务>
    TDT_VECTOR_ANNO=3,
    TDT_IMAGE_ANNO=4,
    TDT_IMAGE_GD=5
}TianDiTuLayerType;

typedef enum{
    TDT_CN = 0, ///<天地图中文标注服务>
    TDT_EN, ///<天地图英文标注服务>
    
}TianDiTuLanguageType;

typedef enum{
    TDT_MERCATOR = 0, ///<天地图墨卡托服务>
    TDT_2000, ///<天地图2000服务>
    TDT_2000_CUSTOM
    
}TianDiTuSpatialReferenceType;



@interface TianDiTuLayerInfo : NSObject


@property(nonatomic,retain)NSString *layername;
@property(nonatomic,retain)NSString *servicename;
@property(nonatomic,retain)NSString *tilematrixset;
@property(nonatomic,retain)AGSSpatialReference *sp;
@property(nonatomic,retain,readwrite)AGSEnvelope *fullExtent;
@property(nonatomic,retain)AGSPoint *origin;
@property(nonatomic,retain)NSMutableArray *lods;
@property(nonatomic,retain)AGSTileInfo *tileInfo;
@property(nonatomic,retain)NSString *url;

-(instancetype)initwithlayerType:(TianDiTuLayerType)layerType SpatialReferenceWKID:(TianDiTuSpatialReferenceType)sptype;

-(instancetype)initwithlayerType:(TianDiTuLayerType)layerType LanguageType:(TianDiTuLanguageType)lan SpatialReferenceWKID:(TianDiTuSpatialReferenceType)sptype;

-(NSString *)getTianDiTuServiceURL:(AGSTileKey *)tileKey;

@end
