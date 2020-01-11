//
//  YNBLayerModel.m
//  YueNongBao
//
//  Created by gis on 2019/6/16.
//  Copyright © 2019 gis. All rights reserved.
//

#import "YNBLayerModel.h"

@implementation YNBLayerModel
-(id)initWithName:(NSString*)name image:(NSString*)image visible:(BOOL)visible
{
    if (self = [super init]) {
        _name = name;
        _image = image;
        _visible = visible;
    }
    return self;
}
@end
