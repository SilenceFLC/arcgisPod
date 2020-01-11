//
//  UIColor+RGBA.m
//  YueNongBao
//
//  Created by gis on 2019/5/2.
//  Copyright © 2019 gis. All rights reserved.
//

#import "UIColor+RGBA.h"
#import <objc/runtime.h>
@implementation UIColor (RGBA)
+(UIColor*)colorWithRGBAHexString:(NSString*)hexString
{

    int pos = [hexString hasPrefix:@"#"] ? 1 : 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    scanner.scanLocation = pos;
    
    unsigned rgbaColor;
    [scanner scanHexInt:&rgbaColor];
    
    if ([hexString length] - pos == 4) {
        unsigned red = rgbaColor >> 12 & 0x0f;
        unsigned green = rgbaColor >> 8 & 0x0f;
        unsigned blue = rgbaColor >> 4 & 0x0f;
        unsigned alpha = rgbaColor & 0x0f;
        return [UIColor colorWithRed:(red << 4 | red) / (CGFloat)0xff
                               green:(green << 4 | green) / (CGFloat)0xff
                                blue:(blue << 4 | blue) / (CGFloat)0xff
                               alpha:(alpha << 4 | alpha) / (CGFloat)0xff];
    }
    
    if ([hexString length] - pos == 8) {
        /*
        unsigned red = rgbaColor >> 24 & 0xff;
        unsigned green = rgbaColor >> 16 & 0xff;
        unsigned blue = rgbaColor >> 8 & 0xff;
        unsigned alpha = rgbaColor & 0xff;
         */
        unsigned alpha= rgbaColor >> 24 & 0xff;
        unsigned red  = rgbaColor >> 16 & 0xff;
        unsigned green = rgbaColor >> 8 & 0xff;
        unsigned blue = rgbaColor & 0xff;

        return [UIColor colorWithRed:red / (CGFloat)0xff
                               green:green / (CGFloat)0xff
                                blue:blue / (CGFloat)0xff
                               alpha:alpha / (CGFloat)0xff];
    }
    return nil;
 
}
@end
