//
//  StarView.m
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "StarView.h"
@interface StarView ()
{
    UIImageView *_backgroundImage;
    UIImageView *_starImage;
}

@end

@implementation StarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _backgroundImage = [[UIImageView alloc]initWithFrame:self.bounds];
    _starImage = [[UIImageView alloc]initWithFrame:self.bounds];
    _backgroundImage.image = [UIImage imageNamed:@"StarsBackground"];
    _starImage.image = [UIImage imageNamed:@"StarsForeground"];
    [self addSubview:_backgroundImage];
    [self addSubview:_starImage];
    _starImage.contentMode = UIViewContentModeLeft;
    _starImage.clipsToBounds = YES;
    
}

-(void)setStarValue:(NSString *)value
{
    CGFloat starCount = value.floatValue;
    _starImage.frame = CGRectMake(0, 0, starCount * self.frame.size.width * 1.0/5.0, self.frame.size.height);
}
@end
