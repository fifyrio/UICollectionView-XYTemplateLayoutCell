//
//  XYFeedCell.m
//  Demo
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "XYFeedCell.h"
@interface XYFeedCell()
@property (weak, nonatomic) IBOutlet UILabel *goodNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@end

@implementation XYFeedCell
- (void)setModel:(XYFeedModel *)model{
    _model = model;
    self.goodNumberLabel.text = model.thumbs_up;
    self.contentLabel.text = model.content;
    self.userLabel.text = model.username;
    self.fromLabel.text = model.from;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
