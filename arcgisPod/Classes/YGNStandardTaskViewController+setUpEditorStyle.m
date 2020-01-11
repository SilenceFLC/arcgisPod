//
//  YGNStandardTaskViewController+setUpEditorStyle.m
//  SunShineRN
//
//  Created by 冯立昌 on 2019/12/27.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "YGNStandardTaskViewController+setUpEditorStyle.h"



@implementation YGNStandardTaskViewController (setUpEditorStyle)
-(void)setupSketchEditor{
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onListenerGeometryDidChange:) name:AGSSketchEditorGeometryDidChangeNotification object:nil];
  
  AGSSketchEditor *sketchEditor = [AGSSketchEditor sketchEditor];
  sketchEditor.style = [self sketchSStyle];
  [self.mapView setSketchEditor:sketchEditor];
}
-(AGSSketchStyle *)sketchSStyle
{
    AGSSketchStyle * style = [[AGSSketchStyle alloc] init];
    style.lineSymbol = [AGSSimpleLineSymbol simpleLineSymbolWithStyle:(AGSSimpleLineSymbolStyleSolid) color:[UIColor colorFromHexString:@"ffd24c"] width:2];
    AGSSimpleMarkerSymbol *selectedVertexSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithStyle:(AGSSimpleMarkerSymbolStyleCircle) color:[UIColor redColor] size:20];
    selectedVertexSymbol.outline =[AGSSimpleLineSymbol simpleLineSymbolWithStyle:(AGSSimpleLineSymbolStyleSolid) color:[UIColor whiteColor] width:2];
    style.selectedVertexSymbol =selectedVertexSymbol;
    style.selectionColor=[UIColor clearColor];
    style.midVertexSymbol = nil;
    
    style.vertexSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithStyle:(AGSSimpleMarkerSymbolStyleCircle) color:[UIColor whiteColor] size:20];
    return style;
}
@end
