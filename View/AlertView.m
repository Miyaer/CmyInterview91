//
//  AlertView.m
//  CmyInterview91
//
//  Created by miya on 16/7/27.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "AlertView.h"
#import "UIImageView+WebCache.h"
@implementation AlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor whiteColor];
        self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.titleImage.image = [UIImage imageNamed:@"bg.jpg"];
        [self addSubview:self.titleImage];
        self.nameL = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, WIDTH-20, 30)];
        self.nameL.textColor = [UIColor blackColor];
        self.nameL.textAlignment = NSTextAlignmentCenter;
        self.nameL.font = [UIFont systemFontOfSize:20];
        self.nameL.text = @"这款是免费的哦!";
        self.nameL.center = CGPointMake(self.center.x, self.center.y-50);
        [self addSubview:self.nameL];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake(0, 0, 100, 30);
        self.btn.center = CGPointMake(self.center.x, self.center.y+50);
        [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn setImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.btn];
    }
    return self;
}
- (void)btnClick:(UIButton *)btn{
    [UIView animateWithDuration:1 animations:^{
        [self removeFromSuperview];

    } completion:nil];
}
@end
