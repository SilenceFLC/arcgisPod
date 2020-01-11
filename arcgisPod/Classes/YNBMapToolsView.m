//
//  YNBToolsVIew.m
//  YueNongBao
//
//  Created by gis on 2019/7/16.
//  Copyright © 2019 gis. All rights reserved.
//

#import "YNBMapToolsView.h"
@interface YNBMapToolsView()
@property(nonatomic,strong)NSMutableArray *btns;
@end
@implementation YNBMapToolsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame tools:(NSArray*)tools{
    if (self = [super initWithFrame: frame]) {
        int i=0;
        _btns =[NSMutableArray new];
        for(UIImage * image in tools)
        {
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, i*frame.size.width, frame.size.width, frame.size.width)];
            btn.tag = 1000+i;
            i++;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchDown)];
            [btn setImage:image forState:(UIControlStateNormal)];
            [self addSubview:btn];
            [_btns addObject:btn];
        }
    }
    self.layer.cornerRadius=8;
    self.layer.masksToBounds=YES;
    return self;
}
-(void)btnClicked:(id)sender
{
    UIButton * btn = (UIButton*)sender;
    if ([self.delegate respondsToSelector:@selector(toolsView:clickedIndex:)]) {
        [self.delegate toolsView:self clickedIndex:btn.tag-1000];
    }
}
-(void)setEnabled:(BOOL)enabled forIndex:(NSInteger)index
{
    UIButton * btn = [_btns objectAtIndex:index];
    if (btn) {
        btn.enabled = enabled;
    }
}
@end
