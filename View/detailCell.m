//
//  detailCell.m
//  CmyInterview91
//
//  Created by miya on 16/7/27.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "detailCell.h"

@implementation detailCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-10,self.bounds.size.height-25)];
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = 5;
        [self addSubview:self.imageView];
        
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-21, self.bounds.size.width-10, 21)];
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.name];
    }
    return self;
}
@end
