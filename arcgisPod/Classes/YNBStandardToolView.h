//
//  YNBStandardToolView.h
//  YueNongBao
//
//  Created by gis on 2019/7/26.
//  Copyright © 2019 gis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YNBStandardToolView;
@protocol YNBStandardToolViewDelegate <NSObject>
-(void)standardToolViewNext:(YNBStandardToolView*)view;
@end
@interface YNBStandardToolView : UIView
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger badgeNumber;
@property(nonatomic,assign)id<YNBStandardToolViewDelegate>delegate;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)BOOL hasNewSamplePoint;
@end

NS_ASSUME_NONNULL_END
