//
//  YNBToolsVIew.h
//  YueNongBao
//
//  Created by gis on 2019/7/16.
//  Copyright © 2019 gis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YNBMapToolsView;
@protocol YYNBMapToolsViewDelegate <NSObject>

-(void)toolsView:(YNBMapToolsView*)view clickedIndex:(NSInteger)clickedIndex;

@end
@interface YNBMapToolsView : UIView
-(id)initWithFrame:(CGRect)frame tools:(NSArray*)tools;
@property(nonatomic,assign)id<YYNBMapToolsViewDelegate> delegate;
-(void)setEnabled:(BOOL)enabled forIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
