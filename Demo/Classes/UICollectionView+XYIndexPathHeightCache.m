//
//  UICollectionView+XYIndexPathHeightCache.m
//  tableView
//
//  Created by wuw on 16/6/12.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "UICollectionView+XYIndexPathHeightCache.h"
#import <objc/runtime.h>

@interface XYIndexPathHeightCache()
@property (nonatomic, retain) NSMutableArray *sizesBySections;
@end

@implementation XYIndexPathHeightCache
#pragma mark - Initialize
- (instancetype)init
{
    self = [super init];
    if (self) {
        _sizesBySections = [NSMutableArray array];
    }
    return self;
}
#pragma mark - Private
- (void)buildSectionsIfNeed:(NSIndexPath *)indexPath{
    [self sectionsEnumerateObjectsUsingBlock:^(NSMutableArray *array) {
        NSInteger targetSection = indexPath.section;
        for (NSInteger i = 0; i <= targetSection; i ++) {
            if (i >= array.count) {
                array[i] = [NSMutableArray array];
            }
        }
    }];
}
- (void)buildRowsIfNeed:(NSIndexPath *)indexPath inSection:(NSInteger)section{
    [self sectionsEnumerateObjectsUsingBlock:^(NSMutableArray *array) {
        NSMutableArray *rows = array[section];
        NSInteger targetRow = indexPath.row;
        for (NSInteger i = 0; i <= targetRow; i ++) {
            if (i >= rows.count) {
                rows[i] = @-1;
            }
        }
    }];
}
- (void)sectionsEnumerateObjectsUsingBlock:(void (^)(NSMutableArray *array))block{
    block(self.sizesBySections);
}
#pragma mark - Public
//是否存在本地缓存
- (BOOL)exsistIndexPathSizeCache:(NSIndexPath *)indexPath{
    if (indexPath.section + 1 > self.sizesBySections.count) {
        return NO;
    }else{
        NSMutableArray *rows = self.sizesBySections[indexPath.section];
        if (indexPath.row + 1 > rows.count) {
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}
//根据indexPath获取缓存的size
- (CGSize)getSizeCacheByIndexPath:(NSIndexPath *)indexPath{
    if ([self exsistIndexPathSizeCache:indexPath]) {
        NSValue *value = self.sizesBySections[indexPath.section][indexPath.row];
        return [value CGSizeValue];
    }else{
        return CGSizeZero;
    }
}

- (void)cacheSizeByIndexPath:(NSIndexPath *)indexPath size:(CGSize)size{
    [self buildSectionsIfNeed:indexPath];
    [self buildRowsIfNeed:indexPath inSection:indexPath.section];
    self.sizesBySections[indexPath.section][indexPath.row] = [NSValue valueWithCGSize:size];
}
@end

@implementation UICollectionView (XYIndexPathHeightCache)
- (XYIndexPathHeightCache *)xy_indexPathHeightCache{
    XYIndexPathHeightCache *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [XYIndexPathHeightCache new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}

@end
