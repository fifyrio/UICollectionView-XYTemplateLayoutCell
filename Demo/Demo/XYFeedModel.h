//
//  XYFeedModel.h
//  Demo
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYFeedModel : NSObject
@property (nonatomic, copy) NSString *thumbs_up;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *from;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end