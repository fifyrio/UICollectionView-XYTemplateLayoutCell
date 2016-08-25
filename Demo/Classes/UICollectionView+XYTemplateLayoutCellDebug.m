//
//  UICollectionView+XYTemplateLayoutCellDebug.m
//  Demo
//
//  Created by wuw on 16/6/23.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "UICollectionView+XYTemplateLayoutCellDebug.h"
#import <objc/runtime.h>

@implementation UICollectionView (XYTemplateLayoutCellDebug)
- (BOOL)xy_debugEnable{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setXy_debugEnable:(BOOL)xy_debugEnable{
    objc_setAssociatedObject(self, @selector(xy_debugEnable), @(xy_debugEnable), OBJC_ASSOCIATION_RETAIN);
}
- (void)xy_templateLayoutCellDebug:(NSString*)message{
    if (self.xy_debugEnable) {
        NSLog(@"%@",message);
    }
}
@end
