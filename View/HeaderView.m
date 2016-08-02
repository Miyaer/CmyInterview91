//
//  HeaderView.m
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameL = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
        self.nameL.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.nameL];
        
        self.moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-103, 0, 100, 30)];
        [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        self.moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
        [self.moreBtn setImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
        [self.moreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self addSubview:self.moreBtn];
        
    }
    return self;
}

@end
