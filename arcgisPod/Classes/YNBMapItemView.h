//
//  YNBMapItemVIew.h
//  YueNongBao
//
//  Created by gis on 2019/6/15.
//  Copyright © 2019 gis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YNBMapItemView;
@protocol YNBMapItemViewDelegate <NSObject>

-(void) itemClicked:(YNBMapItemView*)view;

@end
@interface YNBMapItemView : UIView
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,assign)BOOL selected;
-(id)initWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image;
@property(nonatomic,assign)id<YNBMapItemViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
