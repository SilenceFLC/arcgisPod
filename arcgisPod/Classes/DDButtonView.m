//
//  DDButtonView.m
//  diandian
//
//  Created by gisdev on 8/30/17.
//  Copyright © 2017 gis. All rights reserved.
//

#import "DDButtonView.h"

@interface DDButtonView()
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIImageView * backImageView;
@end
@implementation DDButtonView

-(id)initWithFrame:(CGRect)frame iconSize:(CGSize)size
{
    
    if ([super initWithFrame:frame]) {
        
        self.layer.masksToBounds=YES;
        self.clipsToBounds=YES;
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.backImageView];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-size.width)/2, (frame.size.height-size.height)/2, size.width, size.height)];
        [self addSubview:self.imageView];
        
        _isShowBorder = NO;
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerTap];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.layer.cornerRadius = 2;
    }
    return self;
}
-(void)setButtonImage:(UIImage *)buttonImage
{
    _buttonImage = buttonImage;
    self.imageView.image = buttonImage;
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(buttonViewClick:)]) {
        [self.delegate buttonViewClick:self];
    }
}
-(void)setIsShowBorder:(BOOL)isShowBorder
{
    
    _isShowBorder = isShowBorder;
    if (_isShowBorder) {
        self.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] CGColor];
        self.layer.cornerRadius=6;
        self.layer.borderWidth=1;
    }
    else
    {
        self.layer.borderWidth=0;
        
    }
}
-(void)setBackImage:(UIImage *)backImage
{
    _backImage = backImage;
    self.backImageView.image = backImage;
    self.layer.borderWidth=0;
    self.layer.cornerRadius = 0;
}

@end
