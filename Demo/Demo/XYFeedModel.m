//
//  XYFeedModel.m
//  Demo
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "XYFeedModel.h"

@implementation XYFeedModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = super.init;
    if (self) {
        _thumbs_up = dictionary[@"thumbs_up"];
        _content = dictionary[@"content"];
        _username = dictionary[@"username"];
        _from = dictionary[@"from"];
    }
    return self;
}
@end
