//
//  YNBMapItemVIew.m
//  YueNongBao
//
//  Created by gis on 2019/6/15.
//  Copyright © 2019 gis. All rights reserved.
//

#import "YNBMapItemView.h"
#import "Colours.h"
@interface YNBMapItemView()
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * imageView;
//@property(nonatomic,strong)UIView * selected
@end
@implementation YNBMapItemView
-(id)initWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image
{
    if (self = [super initWithFrame:frame]) {
        _title = title;
        _image = image;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 68, 44)];
        self.imageView.image = image;
        self.imageView.userInteractionEnabled=YES;
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageSelected:)];
        [recognizer setNumberOfTapsRequired:1];
        [recognizer setNumberOfTouchesRequired:1];
        [self addGestureRecognizer:recognizer];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 68, 14)];
        self.titleLabel.text = title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor=[UIColor colorFromHexString:@"212121"];
        self.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}
-(void)imageSelected:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(itemClicked:)]) {
        [self.delegate itemClicked:self];
    }
}
-(void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        if (_selected) {
            self.titleLabel.textColor=[UIColor colorFromHexString:@"db3c27"];
            self.imageView.layer.borderColor =[[UIColor colorFromHexString:@"db3c27"] CGColor];
            self.imageView.layer.borderWidth=1;
        }
        else
        {
            self.titleLabel.textColor=[UIColor colorFromHexString:@"212121"];
            self.imageView.layer.borderColor =[[UIColor colorFromHexString:@"db3c27"] CGColor];
            self.imageView.layer.borderWidth=0;
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
