//
//  UICollectionView+XYTemplateLayoutCell.h
//  tableView
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (XYTemplateLayoutCell)
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width config:(void (^)(id cell))config;
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config;
@end
