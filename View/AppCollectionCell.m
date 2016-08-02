//
//  AppCollectionCell.m
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "AppCollectionCell.h"

@implementation AppCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, (WIDTH-20)/2, 70)];

        [self.contentView addSubview:self.imageView];
    }
    return self;
}
@end
