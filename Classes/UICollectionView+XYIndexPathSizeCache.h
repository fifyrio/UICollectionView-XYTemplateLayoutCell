//
//  UICollectionView+XYIndexPathSizeCache.h
//  tableView
//
//  Created by wuw on 16/8/25.
//  Copyright © 2016年 Kingnet. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XYIndexPathSizeCache : NSObject
- (CGSize)getSizeCacheByIndexPath:(NSIndexPath *)indexPath;
- (BOOL)exsistIndexPathSizeCache:(NSIndexPath *)indexPath;
- (void)cacheSizeByIndexPath:(NSIndexPath *)indexPath size:(CGSize)size;
@end

@interface UICollectionView (XYIndexPathSizeCache)
- (CGSize)xy_getSizeCacheByIndexPath:(NSIndexPath *)indexPath;
- (BOOL)xy_exsistIndexPathSizeCache:(NSIndexPath *)indexPath;
- (void)xy_cacheSizeByIndexPath:(NSIndexPath *)indexPath size:(CGSize)size;
@property (nonatomic, strong, readonly) XYIndexPathSizeCache *xy_indexPathSizeCache;
@end
