//
//  UICollectionView+XYTemplateLayoutCell.h
//  tableView
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (XYTemplateLayoutCell)
//固定宽度
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width config:(void (^)(id cell))config;
/*若使用UICollectionView+XYIndexPathHeightCache的xy_cacheSizeByIndexPath:size:方法，则不能使用该方法*/
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config;

//固定高度
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier height:(CGFloat)height config:(void (^)(id cell))config;
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier height:(CGFloat)height cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config;

//不固定高度宽度
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier config:(void (^)(id cell))config;
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config;
@end
