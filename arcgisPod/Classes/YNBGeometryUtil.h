//
//  YNBGeometryUtil.h
//  YueNongBao
//
//  Created by gis on 2019/7/30.
//  Copyright © 2019 gis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
NS_ASSUME_NONNULL_BEGIN

@interface YNBGeometryUtil : NSObject
+(double)areaOfPolygon:(AGSPolygon*)polygon;
+(double) lengthOfPolyline:(AGSPolyline*)polyline;
@end

NS_ASSUME_NONNULL_END
