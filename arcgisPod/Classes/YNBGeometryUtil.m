//
//  YNBGeometryUtil.m
//  YueNongBao
//
//  Created by gis on 2019/7/30.
//  Copyright © 2019 gis. All rights reserved.
//

#import "YNBGeometryUtil.h"

@implementation YNBGeometryUtil
+(double)areaOfPolygon:(AGSPolygon*)polygon
{
    return [AGSGeometryEngine geodeticAreaOfGeometry:polygon areaUnit: [AGSAreaUnit squareMeters] curveType:(AGSGeodeticCurveTypeGeodesic)];
}
+(double) lengthOfPolyline:(AGSPolyline*)polyline
{
    return [AGSGeometryEngine geodeticLengthOfGeometry:polyline lengthUnit:[AGSLinearUnit  meters] curveType:AGSGeodeticCurveTypeGeodesic];
}
@end
