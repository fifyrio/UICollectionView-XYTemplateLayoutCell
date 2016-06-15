//
//  UICollectionView+XYTemplateLayoutCell.m
//  tableView
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "UICollectionView+XYTemplateLayoutCell.h"
#import "UICollectionView+XYIndexPathHeightCache.h"
#import <objc/runtime.h>

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
        NSAssert(cell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        [tempCellDict setObject:cell forKey:identifier];
        objc_setAssociatedObject(self, _cmd, tempCellDict, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return cell;
}
#pragma mark - Public
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width config:(void (^)(id cell))config{
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
    CGFloat contentViewWidth = CGRectGetWidth(self.frame);
    CGSize fittingSize = CGSizeZero;
    //自动约束获取高度
    NSLayoutConstraint *tempWidthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    [cell.contentView addConstraint:tempWidthConstraint];
    // Auto layout engine does its math
    fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [cell.contentView removeConstraint:tempWidthConstraint];
    return CGSizeMake(width, fittingSize.height);
}
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config{
    //若有缓存读取缓存
    if ([self.xy_indexPathHeightCache exsistIndexPathSizeCache:indexPath]) {
        return [self.xy_indexPathHeightCache getSizeCacheByIndexPath:indexPath];
    }
    //计算高度
    CGSize fittingSize = [self xy_getCellSizeForIdentifier:identifier width:width config:config];
    //将高度缓存
    [self.xy_indexPathHeightCache cacheSizeByIndexPath:indexPath size:CGSizeMake(width, fittingSize.height)];
    return CGSizeMake(width, fittingSize.height);
}
@end
