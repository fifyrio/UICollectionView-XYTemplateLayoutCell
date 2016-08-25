//
//  UICollectionView+XYTemplateReusableView.m
//  XYHiRepairs
//
//  Created by wuw on 16/8/12.
//  Copyright © 2016年 Kingnet. All rights reserved.
//

#import "UICollectionView+XYTemplateReusableView.h"
#import <objc/runtime.h>
#import "UICollectionView+XYIndexPathSizeCache.h"

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
#pragma mark - Public
//固定宽度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier width:(CGFloat)width config:(void (^)(id reusableView))config{
    NSAssert(identifier.length > 0, @"identifier can't be nil - %@",identifier);
    if (!identifier.length) {
        return CGSizeZero;
    }
    UICollectionReusableView *reusableView = [self getTempReusableViewForIndentifier:identifier];
    [reusableView prepareForReuse];
    if (config) {
        config(reusableView);
    }
    //将内容放进cell获取高度
    CGFloat contentViewWidth = width;
    CGSize fittingSize = CGSizeZero;
    //自动约束获取高度
    NSLayoutConstraint *tempWidthConstraint =
    [NSLayoutConstraint constraintWithItem:reusableView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:contentViewWidth];
    [reusableView addConstraint:tempWidthConstraint];
    // Auto layout engine does its math
    fittingSize = [reusableView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [reusableView removeConstraint:tempWidthConstraint];
    return CGSizeMake(width, fittingSize.height);
}
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id reusableView))config{
    //若有缓存读取缓存
    if ([self.xy_indexPathSizeCache exsistIndexPathSizeCache:indexPath]) {
        return [self.xy_indexPathSizeCache getSizeCacheByIndexPath:indexPath];
    }
    //计算尺寸大小
    CGSize fittingSize = [self xy_getReusableViewSizeForIdentifier:identifier width:width config:config];
     [self.xy_indexPathSizeCache cacheSizeByIndexPath:indexPath size:CGSizeMake(width, fittingSize.height)];
    return CGSizeMake(width, fittingSize.height);
}

//固定高度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier height:(CGFloat)height config:(void (^)(id reusableView))config{
    NSAssert(identifier.length > 0, @"identifier can't be nil - %@",identifier);
    if (!identifier.length) {
        return CGSizeZero;
    }
    UICollectionReusableView *reusableView = [self getTempReusableViewForIndentifier:identifier];
    [reusableView prepareForReuse];
    if (config) {
        config(reusableView);
    }
    //将内容放进cell获取高度
    CGFloat contentViewHeight = height;
    CGSize fittingSize = CGSizeZero;
    //自动约束获取高度
    NSLayoutConstraint *tempWidthConstraint =
    [NSLayoutConstraint constraintWithItem:reusableView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:contentViewHeight];
    [reusableView addConstraint:tempWidthConstraint];
    // Auto layout engine does its math
    fittingSize = [reusableView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [reusableView removeConstraint:tempWidthConstraint];
    return CGSizeMake(fittingSize.width, contentViewHeight);
}
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier height:(CGFloat)height cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id reusableView))config{
    //若有缓存读取缓存
    if ([self.xy_indexPathSizeCache exsistIndexPathSizeCache:indexPath]) {
        return [self.xy_indexPathSizeCache getSizeCacheByIndexPath:indexPath];
    }
    //计算尺寸大小
    CGSize fittingSize = [self xy_getReusableViewSizeForIdentifier:identifier height:height config:config];
    [self.xy_indexPathSizeCache cacheSizeByIndexPath:indexPath size:CGSizeMake(fittingSize.width, height)];
    return CGSizeMake(fittingSize.width, height);
}
@end
