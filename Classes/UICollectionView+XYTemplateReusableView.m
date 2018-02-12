//
//  UICollectionView+XYTemplateReusableView.m
//  XYHiRepairs
//
//  Created by wuw on 16/8/12.
//  Copyright © 2016年 Kingnet. All rights reserved.
//

#import "UICollectionView+XYTemplateReusableView.h"
#import <objc/runtime.h>
#import "UICollectionView+XYSectionSizeCache.h"

typedef NS_ENUM(NSUInteger, XYReusableViewType) {
    XYReusableViewTypeDynamicSize = 0,
    XYReusableViewTypeFixedWidth = 1,
    XYReusableViewTypeFixedHeight = 2,
};

@implementation UICollectionView (XYTemplateReusableView)
#pragma mark - Private
- (UICollectionReusableView *)getTempReusableViewForIndentifier:(NSString *)identifier{
    NSMutableDictionary *tempReusableViewDict = objc_getAssociatedObject(self, _cmd);
    if (!tempReusableViewDict) {
        tempReusableViewDict = @{}.mutableCopy;
    }
    UICollectionReusableView *reusableView = tempReusableViewDict[identifier];
    if (!reusableView) {
        reusableView = [[[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] firstObject];
        NSAssert(reusableView != nil, @"reusableView must be registered to collection view for identifier - %@", identifier);
        [tempReusableViewDict setObject:reusableView forKey:identifier];
        objc_setAssociatedObject(self, _cmd, tempReusableViewDict, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return reusableView;
}
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier type:(XYReusableViewType)type sizeValue:(CGFloat)sizeValue config:(void (^)(id reusableView))config{
    NSAssert(identifier.length > 0, @"identifier can't be nil - %@",identifier);
    if (!identifier.length) {
        return CGSizeZero;
    }
    UICollectionReusableView *reusableView = [self getTempReusableViewForIndentifier:identifier];
    [reusableView prepareForReuse];
    if (config) {
        config(reusableView);
    }
    
    CGSize fittingSize = CGSizeZero;
    if (type == XYReusableViewTypeDynamicSize) {
        fittingSize = [reusableView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    }else{
        //自动约束获取高度
        NSLayoutConstraint *tempWidthConstraint =
        [NSLayoutConstraint constraintWithItem:reusableView
                                     attribute:type == XYReusableViewTypeFixedWidth?NSLayoutAttributeWidth:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:sizeValue];
        [reusableView addConstraint:tempWidthConstraint];
        // Auto layout engine does its math
        fittingSize = [reusableView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        [reusableView removeConstraint:tempWidthConstraint];
    }
    return fittingSize;
}
#pragma mark - Public
//固定宽度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier width:(CGFloat)width config:(void (^)(id reusableView))config{
    return [self xy_getReusableViewSizeForIdentifier:identifier
                                                type:XYReusableViewTypeFixedWidth
                                           sizeValue:width
                                              config:config];
}
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheBySection:(NSInteger)section config:(void (^)(id reusableView))config{
    //若有缓存读取缓存
    if ([self.xy_sectionSizeCache exsistSectionSizeCache:section]) {
        return [self.xy_sectionSizeCache getSizeCacheBySection:section];
    }
    //计算尺寸大小
    CGSize fittingSize = [self xy_getReusableViewSizeForIdentifier:identifier width:width config:config];
    [self.xy_sectionSizeCache cacheSizeBySection:section size:fittingSize];
    return fittingSize;
}

//固定高度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier height:(CGFloat)height config:(void (^)(id reusableView))config{
    return [self xy_getReusableViewSizeForIdentifier:identifier
                                                type:XYReusableViewTypeFixedHeight
                                           sizeValue:height
                                              config:config];
}
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier height:(CGFloat)height cacheBySection:(NSInteger)section config:(void (^)(id reusableView))config{
    //若有缓存读取缓存
    if ([self.xy_sectionSizeCache exsistSectionSizeCache:section]) {
        return [self.xy_sectionSizeCache getSizeCacheBySection:section];
    }
    //计算尺寸大小
    CGSize fittingSize = [self xy_getReusableViewSizeForIdentifier:identifier height:height config:config];
    [self.xy_sectionSizeCache cacheSizeBySection:section size:fittingSize];
    return fittingSize;
}

//不固定宽度高度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier config:(void (^)(id reusableView))config{
    return [self xy_getReusableViewSizeForIdentifier:identifier
                                                type:XYReusableViewTypeDynamicSize
                                           sizeValue:0
                                              config:config];
}
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier cacheBySection:(NSInteger)section config:(void (^)(id reusableView))config{
    //若有缓存读取缓存
    if ([self.xy_sectionSizeCache exsistSectionSizeCache:section]) {
        return [self.xy_sectionSizeCache getSizeCacheBySection:section];
    }
    //计算尺寸大小
    CGSize fittingSize = [self xy_getReusableViewSizeForIdentifier:identifier config:config];
    [self.xy_sectionSizeCache cacheSizeBySection:section size:fittingSize];
    return fittingSize;
}
@end
