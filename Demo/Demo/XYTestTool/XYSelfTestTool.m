//
//  XYSelfTestTool.m
//  XYHiRepairs
//
//  Created by wuw on 2017/5/4.
//  Copyright © 2017年 Kingnet. All rights reserved.
//

#import "XYSelfTestTool.h"
#import "YYFPSLabel.h"

@interface XYSelfTestTool ()

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation XYSelfTestTool

#pragma mark - 单例
static XYSelfTestTool * __singleton__;
+ (XYSelfTestTool *)tool{
    static dispatch_once_t predicate;
    dispatch_once( &predicate, ^{ __singleton__ = [[[self class] alloc] init]; } );
    return __singleton__;
}

#pragma mark - Public
- (void)showFPS{
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.alpha = 0.9;
    _fpsLabel.frame = CGRectMake(0, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [[UIApplication sharedApplication].keyWindow addSubview:_fpsLabel];
}

@end
