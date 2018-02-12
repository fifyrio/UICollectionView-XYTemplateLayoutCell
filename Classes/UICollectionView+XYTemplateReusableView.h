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
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier width:(CGFloat)width cacheBySection:(NSInteger)section config:(void (^)(id reusableView))config;

//固定高度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier height:(CGFloat)height config:(void (^)(id reusableView))config;
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier height:(CGFloat)height cacheBySection:(NSInteger)section config:(void (^)(id reusableView))config;

//不固定宽度高度
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier config:(void (^)(id reusableView))config;
- (CGSize)xy_getReusableViewSizeForIdentifier:(NSString *)identifier cacheBySection:(NSInteger)section config:(void (^)(id reusableView))config;
@end
