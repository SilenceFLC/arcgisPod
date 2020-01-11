//
//  DDButtonView.h
//  diandian
//
//  Created by gisdev on 8/30/17.
//  Copyright © 2017 gis. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDButtonView;
@protocol DDButtonViewDelegate <NSObject>
@required
-(void) buttonViewClick:(DDButtonView*)view;
@end

@interface DDButtonView : UIView
-(id)initWithFrame:(CGRect)frame iconSize:(CGSize)size;
@property(nonatomic,strong)id<DDButtonViewDelegate>delegate;
@property(nonatomic,strong)UIImage* buttonImage;
@property(nonatomic,strong)UIImage* backImage;
@property(nonatomic,assign)BOOL isShowBorder;
@property(nonatomic,assign)BOOL isSelected;
@end
