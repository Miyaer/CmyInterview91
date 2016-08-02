//
//  firstCell.m
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "firstCell.h"
#import "UIImageView+WebCache.h"
@implementation firstCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.bounds.size.width-20, self.bounds.size.height-20)];
        self.titleImage.layer.masksToBounds = YES;
        self.titleImage.layer.cornerRadius = 5;
        [self.contentView addSubview:self.titleImage];
        self.nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-21, self.bounds.size.width, 20)];
        self.nameL.textAlignment = NSTextAlignmentCenter;
        self.nameL.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameL];
    }
    return self;
}

-(void)sendModel:(CollectionModel *)model{
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameL.text = model.name;
}
@end
