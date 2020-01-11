//
//  TianDiTuLayerInfo.m
//  MapViewDemo-ObjC
//
//  Created by maklMac on 1/6/17.
//  Copyright © 2017 Esri. All rights reserved.
//

#import "TianDiTuLayerInfo.h"
#import <ArcGIS/ArcGIS.h>


 #define kGDURLGetTile @"http://services.tianditugd.com/%@/wmts?service=wmts&request=GetTile&version=1.0.0&LAYER=%@&TileMatrixSet=%@&style=DOM_GF_GK2_2014&format=image/png";

#define kURLGetTile @"http://t%ld.tianditu.gov.cn/%@/wmts?service=wmts&&request=GetTile&version=1.0.0&layer=%@&tilematrixset=%@&style=default&format=tiles&tk=996bf15339d77d2a520225a4a6aea4b8"

#define tiandituURL @"http://t0.tianditu.com/%@/wmts"

#define X_MIN_MERCATOR -20037508.3427892
#define Y_MIN_MERCATOR -20037508.3427892
#define X_MAX_MERCATOR 20037508.3427892
#define Y_MAX_MERCATOR 20037508.3427892

#define X_MIN_2000 -180.0
#define Y_MIN_2000 -90.0
#define X_MAX_2000 180.0
#define Y_MAX_2000 90.0

#define _minZoomLevel 0
#define _maxZoomLevel 16
#define _tileWidth 256
#define _tileHeight 256
#define _dpi 96

#define _WebMercator 3857
#define _GCS2000 4490

#define kTILE_MATRIX_SET_MERCATOR @"w"
#define kTILE_MATRIX_SET_2000 @"c"



@implementation TianDiTuLayerInfo

@synthesize fullExtent;

-(instancetype)initwithlayerType:(TianDiTuLayerType)layerType SpatialReferenceWKID:(TianDiTuSpatialReferenceType)sptype{
    
    self.layername = @"";
    self.url =kURLGetTile;
   
    switch (layerType) {
        case 0:
            self.layername = @"vec";
            break;
        case 1:
            self.layername = @"img";
            break;
        case 2:
            self.layername = @"ter";
            break;
        case 3:
            self.layername = @"cia";
            break;
        case 4:
            self.layername = @"cva";
            break;
        case 5:
            
            self.url=kGDURLGetTile;
            break;
        default:
            break;
    }
    
     [self setSpatialReference:sptype];
    self.tileInfo = [self getTianDiTuLayerInfo];

    return self;
    
}

-(instancetype)initwithlayerType:(TianDiTuLayerType)layerType LanguageType:(TianDiTuLanguageType)lan SpatialReferenceWKID:(TianDiTuSpatialReferenceType)sptype{
    self.layername = @"";
    
    
    switch (layerType) {
        case 0:
            switch (lan) {
                case 0:
                    self.layername = @"cva";
                    break;
                case 1:
                    self.layername = @"eva";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (lan) {
                case 0:
                    self.layername = @"cia";
                    break;
                case 1:
                    self.layername = @"eia";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            self.layername = @"cta";
            break;
        default:
            break;
    }
    
    [self setSpatialReference:sptype];
    self.tileInfo = [self getTianDiTuLayerInfo];
    return self;

}

-(void)setSpatialReference: (TianDiTuSpatialReferenceType)sptype{

    self.sp = [AGSSpatialReference spatialReferenceWithWKID:102100];
    
    self.lods = [[NSMutableArray alloc] init];
    
    double _baseScale = 2.958293554545656E8;
    
    double _baseRelu = 78271.51696402048;
    
    switch (sptype) {
        
        case 0:
            self.sp = [AGSSpatialReference spatialReferenceWithWKID:_WebMercator];
            self.servicename = [[self.layername stringByAppendingString:@"_"] stringByAppendingString:kTILE_MATRIX_SET_MERCATOR];
            
            self.tilematrixset = kTILE_MATRIX_SET_MERCATOR;
            self.origin = [AGSPoint pointWithX:X_MIN_MERCATOR y:Y_MAX_MERCATOR spatialReference:self.sp];
            
            self.fullExtent = [AGSEnvelope envelopeWithXMin:X_MIN_MERCATOR yMin:Y_MIN_MERCATOR xMax:X_MAX_MERCATOR yMax:Y_MAX_MERCATOR spatialReference:self.sp];
            _baseRelu = 78271.51696402048;

            break;
        case 1:
            self.sp = [AGSSpatialReference spatialReferenceWithWKID:_GCS2000];
            self.servicename = [[self.layername stringByAppendingString:@"_"] stringByAppendingString:kTILE_MATRIX_SET_2000];
            self.tilematrixset = kTILE_MATRIX_SET_2000;
            self.origin = [AGSPoint pointWithX:X_MIN_2000 y:Y_MAX_2000 spatialReference:self.sp];
            
            self.fullExtent = [AGSEnvelope envelopeWithXMin:X_MIN_2000 yMin:Y_MIN_2000 xMax:X_MAX_2000 yMax:Y_MAX_2000 spatialReference:self.sp];
            
            _baseRelu = 0.7031249999891485;

            break;
        case 2:
            self.sp = [AGSSpatialReference spatialReferenceWithWKID:_GCS2000];
            self.origin = [AGSPoint pointWithX:X_MIN_2000 y:Y_MAX_2000 spatialReference:self.sp];
            
            self.fullExtent = [AGSEnvelope envelopeWithXMin:X_MIN_2000 yMin:Y_MIN_2000 xMax:X_MAX_2000 yMax:Y_MAX_2000 spatialReference:self.sp];
            self.layername = @"DOM_GF_GK2_2014";
            self.servicename =@"DOM_GF_GK2_2014";
            self.tilematrixset=@"Matrix_0";
            _baseRelu = 0.7031249999891485;
            break;
        default:
            break;
            
    }
    
    //build lods for loop from 0 to 18 level
    for(int i= 0; i<=17 ;i++){
        AGSLevelOfDetail *level = [AGSLevelOfDetail levelOfDetailWithLevel:i resolution:_baseRelu scale:_baseScale];
        [self.lods addObject:level];
        
        _baseRelu = _baseRelu / 2;
        _baseScale = _baseScale /2;
        
       
        
    }
    
    
}


-(AGSTileInfo*)getTianDiTuLayerInfo{
    
    
    AGSTileInfo *tileInfo = [AGSTileInfo tileInfoWithDPI:_dpi format:AGSTileImageFormatPNG32 levelsOfDetail:self.lods origin:self.origin spatialReference:self.sp tileHeight:_tileHeight tileWidth:_tileWidth];
    
    return tileInfo;

}

-(NSString *)getTianDiTuServiceURL:(AGSTileKey *)tileKey{
    
    int domain = (tileKey.column *tileKey.row)%4;
    NSString *wmtsURL=@"";
    if ([self.url containsString:@"tianditugd"]) {
         wmtsURL = [NSString stringWithFormat:self.url, self.servicename,self.layername,self.tilematrixset];
    }
    else
    {
         wmtsURL = [NSString stringWithFormat:self.url,domain, self.servicename,self.layername,self.tilematrixset];
    }
   
    
    return wmtsURL;
}


@end
