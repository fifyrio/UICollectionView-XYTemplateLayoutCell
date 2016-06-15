//
//  UICollectionView+XYIndexPathHeightCache.h
//  tableView
//
//  Created by wuw on 16/6/12.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XYIndexPathHeightCache : NSObject
- (CGSize)getSizeCacheByIndexPath:(NSIndexPath *)indexPath;
- (BOOL)exsistIndexPathSizeCache:(NSIndexPath *)indexPath;
- (void)cacheSizeByIndexPath:(NSIndexPath *)indexPath size:(CGSize)size;
@end

@interface UICollectionView (XYIndexPathHeightCache)
@property (nonatomic, strong, readonly) XYIndexPathHeightCache *xy_indexPathHeightCache;

@end
