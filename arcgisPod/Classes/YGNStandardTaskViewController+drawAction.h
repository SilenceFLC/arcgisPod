//
//  YGNStandardTaskViewController+drawAction.h
//  SunShineRN
//
//  Created by 冯立昌 on 2019/12/27.
//  Copyright © 2019 Facebook. All rights reserved.
//




#import "YGNStandardTaskViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YGNStandardTaskViewController (drawAction)<AGSGeoViewTouchDelegate>
///开始画地形
-(void) startDraw:(UIView*)view;
/// 撤销
-(void)undo;
 ///   完成
-(void)finish:(id)sender;
@end

NS_ASSUME_NONNULL_END
