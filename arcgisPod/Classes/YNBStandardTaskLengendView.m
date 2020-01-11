//
//  YNBStandardTaskLengendView.m
//  YueNongBao
//
//  Created by gis on 2019/7/16.
//  Copyright © 2019 gis. All rights reserved.
//

#import "YNBStandardTaskLengendView.h"

@implementation YNBStandardTaskLengendView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.backgroundColor =[[UIColor colorWithRGBAHexString:@"80121f1a"] CGColor];
        self.layer.cornerRadius=6;
        self.layer.borderWidth=0;
//        UIView * circleV1 = [[UIView alloc] initWithFrame:CGRectMake(10, 11, 10, 10)];
//        circleV1.clipsToBounds=YES;
//        circleV1.layer.borderWidth=0;
//        circleV1.layer.backgroundColor =[[UIColor colorFromHexString:@"ade03f"] CGColor];
//        circleV1.layer.cornerRadius=4;
//        [self addSubview:circleV1];
//        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(28, 10, 48, 12)];
//        label1.text=@"水田";
//        label1.textColor=[UIColor colorWithRGBAHexString:@"f3ffffff"];
//        label1.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
//        [self addSubview:label1];
        
//        UIView * circleV2 = [[UIView alloc] initWithFrame:CGRectMake(10, 33, 10, 10)];
//        circleV2.clipsToBounds=YES;
//        circleV2.layer.borderWidth=0;
//        circleV2.layer.backgroundColor =[[UIColor colorFromHexString:@"8de3eb"] CGColor];
//        circleV2.layer.cornerRadius=4;
//        [self addSubview:circleV2];
//        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(28, 32, 48, 12)];
//        label2.text=@"旱田";
//        label2.textColor=[UIColor colorWithRGBAHexString:@"f3ffffff"];
//        label2.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
//        [self addSubview:label2];
        
//        UIView * circleV3 = [[UIView alloc] initWithFrame:CGRectMake(10, 55, 10, 10)];
//        circleV3.clipsToBounds=YES;
//        circleV3.layer.borderWidth=0;
//        circleV3.layer.backgroundColor =[[UIColor colorFromHexString:@"00c2a8"] CGColor];
//        circleV3.layer.cornerRadius=4;
//        [self addSubview:circleV3];
//        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(28, 54, 48, 12)];
//        label3.text=@"林地";
//        label3.textColor=[UIColor colorWithRGBAHexString:@"f3ffffff"];
//        label3.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
//        [self addSubview:label3];
        
        UIView * circleV4 = [[UIView alloc] initWithFrame:CGRectMake(10, 11, 10, 10)];
        circleV4.clipsToBounds=YES;
        circleV4.layer.borderWidth=0;
        circleV4.layer.backgroundColor =[[UIColor colorFromHexString:@"0298a6"] CGColor];
        circleV4.layer.cornerRadius=4;
        [self addSubview:circleV4];
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(28, 10, 48, 12)];
        label4.text=@"验标正常";
        label4.textColor=[UIColor colorWithRGBAHexString:@"f3ffffff"];
        label4.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        [self addSubview:label4];
        
        UIView * circleV5 = [[UIView alloc] initWithFrame:CGRectMake(10, 33, 10, 10)];
        circleV5.clipsToBounds=YES;
        circleV5.layer.borderWidth=0;
        circleV5.layer.backgroundColor =[[UIColor colorFromHexString:@"ffd633"] CGColor];
        circleV5.layer.cornerRadius=4;
        [self addSubview:circleV5];
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(28, 32, 48, 12)];
        label5.text=@"验标异常";
        label5.textColor=[UIColor colorWithRGBAHexString:@"f3ffffff"];
        label5.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        [self addSubview:label5];
        
        UIView * circleV6 = [[UIView alloc] initWithFrame:CGRectMake(10, 55, 10, 10)];
        circleV6.clipsToBounds=YES;
        circleV6.layer.borderWidth=0;
        circleV6.layer.backgroundColor =[[UIColor colorFromHexString:@"8de3eb"] CGColor];
        circleV6.layer.cornerRadius=4;
        [self addSubview:circleV6];
        UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(28, 54, 70, 12)];
        label6.text=@"验标待采集";
        label6.textColor=[UIColor colorWithRGBAHexString:@"f3ffffff"];
        label6.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        [self addSubview:label6];
        
    }
    return self;
}

@end
