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

typedef NS_ENUM(NSUInteger, XYCellType) {
    XYCellTypeDynamicSize = 0,
    XYCellTypeFixedWidth = 1,
    XYCellTypeFixedHeight = 2,
};

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
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier type:(XYCellType)type sizeValue:(CGFloat)sizeValue config:(void (^)(id cell))config{
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
    
    CGSize fittingSize = CGSizeZero;
    if (type == XYCellTypeDynamicSize) {
        fittingSize = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    }else{        
        //自动约束获取高度
        NSLayoutConstraint *tempWidthConstraint =
        [NSLayoutConstraint constraintWithItem:cell.contentView
                                     attribute:type == XYCellTypeFixedWidth?NSLayoutAttributeWidth:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:sizeValue];
        [cell.contentView addConstraint:tempWidthConstraint];
        // Auto layout engine does its math
        fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        [cell.contentView removeConstraint:tempWidthConstraint];
    }
    return fittingSize;
}
#pragma mark - Public
//固定宽度
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width config:(void (^)(id cell))config{
    return [self xy_getCellSizeForIdentifier:identifier
                                        type:XYCellTypeFixedWidth
                                   sizeValue:width
                                      config:config];
}
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config{
    //若有缓存读取缓存
    if ([self.xy_indexPathSizeCache exsistIndexPathSizeCache:indexPath]) {
        return [self.xy_indexPathSizeCache getSizeCacheByIndexPath:indexPath];
    }
    //计算尺寸
    CGSize fittingSize = [self xy_getCellSizeForIdentifier:identifier width:width config:config];
    //将将尺寸缓存
    [self.xy_indexPathSizeCache cacheSizeByIndexPath:indexPath size:fittingSize];
    return fittingSize;
}

//固定高度
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier height:(CGFloat)height config:(void (^)(id cell))config{
    return [self xy_getCellSizeForIdentifier:identifier
                                        type:XYCellTypeFixedHeight
                                   sizeValue:height
                                      config:config];
}
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier height:(CGFloat)height cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config{
    //若有缓存读取缓存
    if ([self.xy_indexPathSizeCache exsistIndexPathSizeCache:indexPath]) {
        return [self.xy_indexPathSizeCache getSizeCacheByIndexPath:indexPath];
    }
    //计算尺寸大小
    CGSize fittingSize = [self xy_getCellSizeForIdentifier:identifier height:height config:config];
    //将尺寸缓存
    [self.xy_indexPathSizeCache cacheSizeByIndexPath:indexPath size:fittingSize];
    return fittingSize;
}

//不固定高度宽度
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier config:(void (^)(id cell))config{
    return [self xy_getCellSizeForIdentifier:identifier
                                        type:XYCellTypeDynamicSize
                                   sizeValue:0
                                      config:config];
}
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id cell))config{
    //若有缓存读取缓存
    if ([self.xy_indexPathSizeCache exsistIndexPathSizeCache:indexPath]) {
        return [self.xy_indexPathSizeCache getSizeCacheByIndexPath:indexPath];
    }
    //计算尺寸大小
    CGSize fittingSize = [self xy_getCellSizeForIdentifier:identifier config:config];
    //将尺寸缓存
    [self.xy_indexPathSizeCache cacheSizeByIndexPath:indexPath size:fittingSize];
    return fittingSize;
}
@end
