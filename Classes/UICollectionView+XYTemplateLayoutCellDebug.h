//
//  UICollectionView+XYTemplateLayoutCellDebug.h
//  Demo
//
//  Created by wuw on 16/6/23.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (XYTemplateLayoutCellDebug)
@property (nonatomic,assign) BOOL xy_debugEnable;
- (void)xy_templateLayoutCellDebug:(NSString*)message;
@end
