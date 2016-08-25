//
//  UICollectionView+XYTemplateLayoutCell.m
//  tableView
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "UICollectionView+XYTemplateLayoutCell.h"
#import <objc/runtime.h>
#import "UICollectionView+XYIndexPathSizeCache.h"

@implementation UICollectionView (XYTemplateLayoutCell)
#pragma mark - Private
- (UICollectionViewCell *)getTempCellForIndentifier:(NSString *)identifier{
    NSMutableDictionary *tempCellDict = objc_getAssociatedObject(self, _cmd);
    if (!tempCellDict) {
        tempCellDict = @{}.mutableCopy;
    }
    UICollectionViewCell *cell = tempCellDict[identifier];
    if (!cell) {
        cell = [[[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] firstObject];
        NSAssert(cell != nil, @"Cell must be registered to collection view for identifier - %@", identifier);
        [tempCellDict setObject:cell forKey:identifier];
        objc_setAssociatedObject(self, _cmd, tempCellDict, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return cell;
}
#pragma mark - Public
//固定宽度
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width config:(void (^)(id cell))config{
    NSAssert(identifier.length > 0, @"identifier can't be nil - %@",identifier);
    if (!identifier.length) {
        return CGSizeZero;
    }
    //获取cell
    UICollectionViewCell *cell = [self getTempCellForIndentifier:identifier];
    [cell prepareForReuse];
    if (config) {
        config(cell);
    }
    //将内容放进cell获取高度
    CGFloat contentViewWidth = width;
    CGSize fittingSize = CGSizeZero;
    //自动约束获取高度
    NSLayoutConstraint *tempWidthConstraint =
    [NSLayoutConstraint constraintWithItem:cell.contentView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:contentViewWidth];
    [cell.contentView addConstraint:tempWidthConstraint];
    // Auto layout engine does its math
    fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [cell.contentView removeConstraint:tempWidthConstraint];
    return CGSizeMake(width, fittingSize.height);
}
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config{
    //若有缓存读取缓存
    if ([self.xy_indexPathSizeCache exsistIndexPathSizeCache:indexPath]) {
        return [self.xy_indexPathSizeCache getSizeCacheByIndexPath:indexPath];
    }
    //计算尺寸
    CGSize fittingSize = [self xy_getCellSizeForIdentifier:identifier width:width config:config];
    //将将尺寸缓存
    [self.xy_indexPathSizeCache cacheSizeByIndexPath:indexPath size:CGSizeMake(width, fittingSize.height)];
    return CGSizeMake(width, fittingSize.height);
}

//固定高度
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier height:(CGFloat)height config:(void (^)(id cell))config{
    NSAssert(identifier.length > 0, @"identifier can't be nil - %@",identifier);
    if (!identifier.length) {
        return CGSizeZero;
    }
    //获取cell
    UICollectionViewCell *cell = [self getTempCellForIndentifier:identifier];
    [cell prepareForReuse];
    if (config) {
        config(cell);
    }
    
    CGFloat contentViewHeight = height;
    CGSize fittingSize = CGSizeZero;
    //自动约束获取高度
    NSLayoutConstraint *tempWidthConstraint =
    [NSLayoutConstraint constraintWithItem:cell.contentView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:contentViewHeight];
    [cell.contentView addConstraint:tempWidthConstraint];
    // Auto layout engine does its math
    fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [cell.contentView removeConstraint:tempWidthConstraint];
    return CGSizeMake(fittingSize.width, contentViewHeight);
}
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier height:(CGFloat)height cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config{
    //若有缓存读取缓存
    if ([self.xy_indexPathSizeCache exsistIndexPathSizeCache:indexPath]) {
        return [self.xy_indexPathSizeCache getSizeCacheByIndexPath:indexPath];
    }
    //计算尺寸大小
    CGSize fittingSize = [self xy_getCellSizeForIdentifier:identifier height:height config:config];
    //将尺寸缓存
    [self.xy_indexPathSizeCache cacheSizeByIndexPath:indexPath size:CGSizeMake(fittingSize.width, height)];
    return CGSizeMake(fittingSize.width, height);
}
@end
