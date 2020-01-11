//
//  YGNStandardTaskViewController+drawAction.m
//  SunShineRN
//
//  Created by 冯立昌 on 2019/12/27.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "YGNStandardTaskViewController+drawAction.h"



@implementation YGNStandardTaskViewController (drawAction)
-(void)toolsView:(YNBMapToolsView*)view clickedIndex:(NSInteger)clickedIndex
{
    int idx = view.tag-2001;
    switch (idx) {
        case 0:
        {
            switch (clickedIndex) {
                case 0:
                {
                    [self startDraw:view];
                }
                    break;
                case 1:
                {
//                    YNBWalkMapViewController * walkVC = [[YNBWalkMapViewController alloc] init];
//                    walkVC.delegate = self;
//                    [self.navigationController pushViewController:walkVC animated:YES];
                    
                }
                    break;
              
           
                default:
                    break;
            }
        }
            break;
        case 1:
        {
  
            switch (clickedIndex) {
                case 0:
                {
                    [self startMesureLine];
                }
                    break;
                case 1:
                {
                    [self startMesurePolgyon];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (clickedIndex) {
                case 0:
                {
                    [self del];
                }
                    break;
                case 1:
                {
                    [self undo];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

-(void) startDraw:(UIView*)view
{
    self.currentTool = 1;
   // self.areaView.hidden = YES;
    self.editToolsView.hidden=NO;
    self.tool1View.hidden = YES;
    self.standardToolView.hidden=YES;
    [self.editToolsView setEnabled:YES forIndex:1];
    
    [self.mapView.sketchEditor startWithCreationMode:AGSSketchCreationModePolygon editConfiguration:[self sketchEditConfiguration]];
    self.finishButton.hidden=NO;

}
- (AGSSketchEditConfiguration *)sketchEditConfiguration {
    AGSSketchEditConfiguration *configuration = [[AGSSketchEditConfiguration alloc] init];
    configuration.allowRotate=NO;
    configuration.allowMoveParts= YES;
    configuration.allowPartSelection=NO;
      configuration.allowVertexEditing=YES;
    return configuration;
}
-(void)startMesureLine{
    self.currentTool = 2;
    self.editToolsView.hidden=NO;
    self.tool1View.hidden = YES;
    [self.editToolsView setEnabled:NO forIndex:1];
    [self.mapView.sketchEditor startWithCreationMode:AGSSketchCreationModePolyline editConfiguration:[self sketchEditConfiguration]];
    self.finishButton.hidden=NO;
}
-(void)startMesurePolgyon{
    self.currentTool = 3;
    self.editToolsView.hidden=NO;
    self.tool1View.hidden = YES;
    [self.editToolsView setEnabled:NO forIndex:1];
    [self.mapView.sketchEditor startWithCreationMode:AGSSketchCreationModePolygon editConfiguration:[self sketchEditConfiguration]];
    self.finishButton.hidden=NO;
}
-(void)undo
{
    if ([self.mapView.sketchEditor.undoManager canUndo]) {
        [self.mapView.sketchEditor.undoManager undo];
    }
//  if ([self.mapView.sketchEditor.undoManager canRedo]) {
//    [self.mapView.sketchEditor.undoManager redo];
//  }
}
-(void)del
{
    self.editToolsView.hidden=YES;
    self.tool1View.hidden = NO;
    [self clear];
    [self clearTemp];
    self.finishButton.hidden=YES;
    self.standardToolView.hidden=NO;
}
- (void)clear {
    [self.mapView.sketchEditor clearGeometry];
    [self.mapView.sketchEditor stop];
    self.mapView.touchDelegate = self;
}
-(void)clearTemp
{
    if (self.tempGraphic != nil) {
        [self.overlay.graphics removeObject:self.tempGraphic];
        self.tempGraphic=nil;
    }
}
- (void)onListenerGeometryDidChange:(NSNotification *)notification {
    
    if (self.currentTool ==1 || self.currentTool==3) {
        AGSPolygon * p = self.mapView.sketchEditor.geometry;
        [self clearTemp];
        if(p.parts[0].pointCount >=3)
        {
            
            double area = [YNBGeometryUtil areaOfPolygon:p];
            AGSTextSymbol *txtSymbol =[AGSTextSymbol textSymbolWithText:[NSString stringWithFormat:@"%.2lf亩",area/666.67]
                                                                  color:[UIColor colorFromHexString:@"212121"] size:12 horizontalAlignment:(AGSHorizontalAlignmentCenter) verticalAlignment:(AGSVerticalAlignmentMiddle)];
            txtSymbol.haloWidth=1;
            txtSymbol.haloColor=[UIColor whiteColor];
            self.tempGraphic = [AGSGraphic graphicWithGeometry:self.mapView.sketchEditor.geometry symbol:txtSymbol attributes:nil];
            [self.overlay.graphics addObject:self.tempGraphic];
        }
    }
    else
    {
        AGSPolyline *p = self.mapView.sketchEditor.geometry;
        [self clearTemp];
        if(p.parts[0].pointCount >=2)
        {
            double length = [self lengthOfPolyline:p];
            AGSTextSymbol *txtSymbol =[AGSTextSymbol textSymbolWithText:[NSString stringWithFormat:@"%.2lf米",length]
                                                                  color:[UIColor whiteColor] size:14 horizontalAlignment:(AGSHorizontalAlignmentCenter) verticalAlignment:(AGSVerticalAlignmentMiddle)];
            self.tempGraphic = [AGSGraphic graphicWithGeometry:self.mapView.sketchEditor.geometry symbol:txtSymbol attributes:nil];
            [self.overlay.graphics addObject:self.tempGraphic];
        }
    }
    
}
/// 计算线段的长度
-(double) lengthOfPolyline:(AGSPolyline*)polyline
{
    return [AGSGeometryEngine geodeticLengthOfGeometry:polyline lengthUnit:[AGSLinearUnit  meters] curveType:AGSGeodeticCurveTypeGeodesic];
}

-(void)finish:(id)sender{
    if (self.currentTool ==1 || self.currentTool ==3) {
        AGSPolygon * p = self.mapView.sketchEditor.geometry;
        if(p.parts[0].pointCount <3)
        {
            [CRToastManager showErrorNotificationWithText:@"点数不能小于3"];
            return;
        }
        else{
            
            double area = [YNBGeometryUtil areaOfPolygon:self.mapView.sketchEditor.geometry];
            AGSTextSymbol *txtSymbol =[AGSTextSymbol textSymbolWithText:[NSString stringWithFormat:@"%.2lf亩",area/666.67]
                                                                  color:[UIColor colorFromHexString:@"212121"] size:12 horizontalAlignment:(AGSHorizontalAlignmentCenter) verticalAlignment:(AGSVerticalAlignmentMiddle)];
            txtSymbol.haloWidth=1;
            txtSymbol.haloColor=[UIColor whiteColor];
            AGSCompositeSymbol *cSymbol =[AGSCompositeSymbol compositeSymbolWithSymbols:@[self.selectedSymbol,txtSymbol]];
            AGSGraphic * graphic = [AGSGraphic graphicWithGeometry:self.mapView.sketchEditor.geometry symbol:cSymbol attributes:nil];
            [self.drawAreaOVerlay.graphics addObject:graphic];
           
            self.finishButton.hidden=YES;
            self.standardToolView.hidden=NO;
            self.standardToolView.hasNewSamplePoint=YES;
            [self clearTemp];
        }
    }
    else
    {
        AGSSimpleLineSymbol * slSymbol = [[AGSSimpleLineSymbol alloc] initWithStyle:(AGSSimpleLineSymbolStyleSolid) color:[UIColor redColor] width:1];
        
        double length = [self lengthOfPolyline:self.mapView.sketchEditor.geometry];
        AGSTextSymbol *txtSymbol =[AGSTextSymbol textSymbolWithText:[NSString stringWithFormat:@"%.2lf米",length]
                                                              color:[UIColor whiteColor] size:14 horizontalAlignment:(AGSHorizontalAlignmentCenter) verticalAlignment:(AGSVerticalAlignmentMiddle)];
        AGSCompositeSymbol *cSymbol =[AGSCompositeSymbol compositeSymbolWithSymbols:@[slSymbol,txtSymbol]];
        AGSGraphic * graphic = [AGSGraphic graphicWithGeometry:self.mapView.sketchEditor.geometry symbol:cSymbol attributes:nil];
        [self.drawAreaOVerlay.graphics addObject:graphic];
        self.finishButton.hidden=YES;
        [self clearTemp];
    }
    
    [self del];
    [self clear];
    
}
///  长按某个地块
- (void)geoView:(AGSGeoView *)geoView didLongPressAtScreenPoint:(CGPoint)screenPoint mapPoint:(AGSPoint *)mapPoint
{
//    if(self.task.status >1)
//    {
//        return;
//    }
//    __weak typeof(self) weakSelf = self;
//    [geoView identifyGraphicsOverlay:self.plotAreaOverlay screenPoint:screenPoint tolerance:22 returnPopupsOnly:NO completion:^(AGSIdentifyGraphicsOverlayResult * _Nonnull identifyResult) {
//        if (identifyResult.graphics.count >0) {
//            AGSGraphic * g =identifyResult.graphics[0];
//            if ([g.attributes objectForKey:@"samplePointId"] != nil) {
//                [self showDeleteAlert:[[g.attributes objectForKey:@"samplePointId"] integerValue]];
//            }
//
//
//        }
//    }];
    
    [geoView identifyGraphicsOverlay:self.drawAreaOVerlay screenPoint:screenPoint tolerance:22 returnPopupsOnly:NO completion:^(AGSIdentifyGraphicsOverlayResult * _Nonnull identifyResult) {
        if (identifyResult.graphics.count >0) {
            AGSGraphic * g =identifyResult.graphics[0];
            
                
                [self.drawAreaOVerlay.graphics removeObject:g];
                [self.drawAreaOVerlay.graphics removeAllObjects];
                [self continueEdit:g.geometry];
            
        }
    }];
}
/// 继续编辑
-(void) continueEdit:(AGSGeometry*)geom
{
    self.currentTool = 1;
    self.editToolsView.hidden=NO;
    self.tool1View.hidden = YES;
    self.standardToolView.hidden=YES;
    [self.editToolsView setEnabled:YES forIndex:1];
//   BOOL isStart = [self.mapView.sketchEditor startWithCreationMode:AGSSketchCreationModePolygon editConfiguration:[self sketchEditConfiguration]];
//  AGSPolygon *polygon =(AGSPolygon*)geom;
//  AGSPartCollection *parts = polygon.parts;
//  [self.mapView.sketchEditor startWithGeometry:[AGSPolygon polygonWithPoints:@[parts[0].startPoint]] creationMode :AGSSketchCreationModePolygon editConfiguration:[self sketchEditConfiguration]];
//
//   if (parts.count>0) {
//    for ( AGSPart* part in parts) {
//      AGSPointCollection *points= part.points;
////      for (AGSPoint *point in points) {
////       BOOL isSuccess = [self.mapView.sketchEditor insertVertexAfterSelectedVertexWithPoint:point];
////        NSLog(@"%@--------",point);
////
////      }
//      for (int i = 1; i<points.count; i++) {
//               BOOL isSuccess = [self.mapView.sketchEditor insertVertexAfterSelectedVertexWithPoint:points[i]];
//               NSLog(@"%@--------",points[i]);
//      }
//    }
//  }
  

    [self.mapView.sketchEditor startWithGeometry:geom creationMode :AGSSketchCreationModePolygon editConfiguration:[self sketchEditConfiguration]];

    self.finishButton.hidden=NO;
}

@end
