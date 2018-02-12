//
//  UICollectionView+XYSectionSizeCache.h
//  Demo
//
//  Created by wuw on 16/8/25.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XYSectionSizeCache :NSObject
- (CGSize)getSizeCacheBySection:(NSInteger)section;
- (BOOL)exsistSectionSizeCache:(NSInteger)section;
- (void)cacheSizeBySection:(NSInteger)section size:(CGSize)size;
@end

@interface UICollectionView (XYSectionSizeCache)
- (CGSize)xy_getSizeCacheBySection:(NSInteger)section;
- (BOOL)xy_exsistSectionSizeCache:(NSInteger)section;
- (void)xy_cacheSizeBySection:(NSInteger)section size:(CGSize)size;
@property (nonatomic, strong, readonly) XYSectionSizeCache *xy_sectionSizeCache;
@end
