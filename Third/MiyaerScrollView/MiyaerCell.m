//
//  MiyaerCell.m
//  MiyaScrollView
//
//  Created by miya on 16/7/14.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "MiyaerCell.h"
#import "UIImageView+WebCache.h"
@implementation MiyaerCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createImage];
    }
    return self;
}
- (void)createImage{
    self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:self.imageView];
}
- (void)setPlaceNmae:(NSString *)placeNmae{
    _placeNmae = placeNmae;
}
- (void)setImageUrl:(NSURL *)imageUrl{
    _imageUrl = imageUrl;
    [_imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:self.placeNmae]];
}
- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:_imageName];
}
@end
