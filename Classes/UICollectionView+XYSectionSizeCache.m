//
//  UICollectionView+XYSectionSizeCache.m
//  Demo
//
//  Created by wuw on 16/8/25.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "UICollectionView+XYSectionSizeCache.h"
#import <objc/runtime.h>

@interface XYSectionSizeCache()
@property (nonatomic, retain) NSMutableArray *sizesBySections;
@end

@implementation XYSectionSizeCache
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
- (void)buildSectionsIfNeed:(NSInteger)section{
    [self sectionsEnumerateObjectsUsingBlock:^(NSMutableArray *array) {
        NSInteger targetSection = section;
        for (NSInteger i = 0; i <= targetSection; i ++) {
            if (i >= array.count) {
                array[i] = @-1;
            }
        }
    }];
}
- (void)sectionsEnumerateObjectsUsingBlock:(void (^)(NSMutableArray *array))block{
    block(self.sizesBySections);
}
#pragma mark - Public
//是否存在本地缓存
- (BOOL)exsistSectionSizeCache:(NSInteger)section{
    if (section + 1 > self.sizesBySections.count) {
        return NO;
    }else{
        return YES;
    }
}
//根据indexPath获取缓存的size
- (CGSize)getSizeCacheBySection:(NSInteger)section{
    if ([self exsistSectionSizeCache:section]) {
        NSValue *value = self.sizesBySections[section];
        return [value CGSizeValue];
    }else{
        return CGSizeZero;
    }
}
- (void)cacheSizeBySection:(NSInteger)section size:(CGSize)size{
    [self buildSectionsIfNeed:section];
    self.sizesBySections[section] = [NSValue valueWithCGSize:size];
}
@end

@implementation UICollectionView (XYSectionSizeCache)
#pragma mark - Private
- (XYSectionSizeCache *)xy_sectionSizeCache{
    XYSectionSizeCache *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [XYSectionSizeCache new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}
#pragma mark - Public
- (CGSize)xy_getSizeCacheBySection:(NSInteger)section{
    return [self.xy_sectionSizeCache getSizeCacheBySection:section];
}
- (BOOL)xy_exsistSectionSizeCache:(NSInteger)section{
    return [self.xy_sectionSizeCache exsistSectionSizeCache:section];
}
- (void)xy_cacheSizeBySection:(NSInteger)section size:(CGSize)size{
    [self.xy_sectionSizeCache cacheSizeBySection:section size:size];
}
@end
