//
//  YNBLayerModel.h
//  YueNongBao
//
//  Created by gis on 2019/6/16.
//  Copyright © 2019 gis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNBLayerModel : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * image;
@property(nonatomic,assign)BOOL visible;
-(id)initWithName:(NSString*)name image:(NSString*)image visible:(BOOL)visible;
@end

NS_ASSUME_NONNULL_END
