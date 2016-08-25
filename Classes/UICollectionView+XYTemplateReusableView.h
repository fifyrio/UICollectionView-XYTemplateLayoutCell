//
//  UICollectionView+XYTemplateReusableView.h
//  XYHiRepairs
//
//  Created by wuw on 16/8/12.
//  Copyright © 2016年 Kingnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (XYTemplateReusableView)
//固定宽度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier width:(CGFloat)width config:(void (^)(id reusableView))config;
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id reusableView))config;

//固定高度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier height:(CGFloat)height config:(void (^)(id reusableView))config;
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier height:(CGFloat)height cacheByIndexPath:(NSIndexPath *)indexPath config:(void (^)(id reusableView))config;
@end
