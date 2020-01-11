//
//  YNBStandardToolView.m
//  YueNongBao
//
//  Created by gis on 2019/7/26.
//  Copyright © 2019 gis. All rights reserved.
//
#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#import "YNBStandardToolView.h"
#import "Colours.h"
#import "UIColor+RGBA.h"
@interface YNBStandardToolView()
@property(nonatomic,strong) UILabel *areaLabel;
@property(nonatomic,strong) UIButton * nextButton;
@property(nonatomic,retain)UILabel *badge;
@end
@implementation YNBStandardToolView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius=8;
        self.layer.masksToBounds=YES;
        _areaLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, 15, frame.size.width-130, 30)];
        _areaLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [_areaLabel setTextColor:[UIColor colorWithRGBAHexString:@"99212121"]];
      
        [self addSubview:_areaLabel];
    
        
        self.nextButton =[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-120, 10, 100, 40)];
        [self addSubview:self.nextButton];
        
        [self.nextButton addTarget:self action:@selector(submit:) forControlEvents:(UIControlEventTouchDown)];
        [self.nextButton setTitleColor:[UIColor colorWithRGBAHexString:@"99212121"] forState:UIControlStateNormal];
        self.nextButton.layer.cornerRadius = 20;
        self.nextButton.layer.borderColor=[[UIColor colorFromHexString:@"212121"] CGColor];
        self.nextButton.layer.borderWidth=1;
        [self addSubview:self.badge];
        _hasNewSamplePoint =NO;
    }
    return self;
}
-(UILabel*)badge
{
    if(!_badge)
    {
        _badge = [[UILabel alloc] init];
        _badge.frame = CGRectMake(0, 0, 24, 24);
        _badge.center=CGPointMake(DEVICEWIDTH-58, 16);
        _badge.textAlignment=NSTextAlignmentCenter;
        _badge.text = [NSString stringWithFormat:@"%ld",_badgeNumber];
        _badge.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _badge.textColor =[UIColor whiteColor];
        _badge.layer.cornerRadius=12;
        _badge.layer.masksToBounds=true;
        _badge.backgroundColor=[UIColor colorWithRed:255/255.0 green:72/255.0 blue:37/255.0 alpha:1/1.0];
        [_badge setHidden:NO];
    }
    return _badge;
}
-(void)setStatus:(NSInteger)status
{
    _status = status;
    [self refreshView];
   
}
-(void)setHasNewSamplePoint:(BOOL)hasNewSamplePoint
{
    _hasNewSamplePoint = hasNewSamplePoint;
    [self refreshView];
}
-(void)refreshView
{
    self.badge.hidden =YES;
    switch (_status) {
        case 0:
        {
            [self.nextButton setTitle:@"下一步" forState:(UIControlStateNormal)];
            _areaLabel.text = @"请勾画出你要验标的地块";
        }
            break;
        case 1:
        {
            if (_hasNewSamplePoint) {
                [self.nextButton setTitle:@"下一步" forState:(UIControlStateNormal)];
                _areaLabel.text = @"请勾画出你要验标的地块";
            }
            else
            {
                _areaLabel.text =[NSString stringWithFormat: @"已采集样点：%ld 个",_count ];
                if (_badgeNumber > 0) {
                    self.badge.hidden =NO;
                }
                else
                {
                    self.badge.hidden =YES;
                }
                _badge.text = [NSString stringWithFormat:@"%ld",_badgeNumber];
                [self.nextButton setTitle:@"完成验标" forState:(UIControlStateNormal)];
            }
            
        }
            break;
        case 2:
        {
            _areaLabel.text =[NSString stringWithFormat: @"已采集样点：%ld 个",_count ];
            [self.nextButton setTitle:@"验标详情" forState:(UIControlStateNormal)];
        }
            break;
        default:
            break;
    }
}
-(void)setCount:(NSInteger)count
{
    _count = count;
    [self refreshView];
}
-(void)setBadgeNumber:(NSInteger)badgeNumber
{
    _badgeNumber = badgeNumber;
    [self refreshView];
}
/*
-(void)setArea:(double)area
{
    _area = area;
    self.areaLabel.text = [NSString stringWithFormat:@"地块面积：%.2lf亩",_area/666.67];
}
 */
-(void)submit:(id)sender
{
      
    if ([self.delegate respondsToSelector:@selector(standardToolViewNext:)]) {
        [self.delegate standardToolViewNext:self];
    }
     
}
@end
