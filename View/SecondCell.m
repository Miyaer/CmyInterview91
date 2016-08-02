//
//  SecondCell.m
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "SecondCell.h"
#import "UIImageView+WebCache.h"
#import "StarView.h"
#import "AlertView.h"
@implementation SecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 80, 80)];
        self.titleImage.layer.masksToBounds = YES;
        self.titleImage.layer.cornerRadius = 5;
        [self.contentView addSubview:self.titleImage];
        
        self.titleName = [[UILabel alloc]initWithFrame:CGRectMake(100, 13, WIDTH-65-55, 20)];
        self.titleName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleName];
        
        self.starView = [[StarView alloc]initWithFrame:CGRectMake(100, 13+22,58, 20)];
        [self.contentView addSubview:self.starView];
        
        self.downloadL = [[UILabel alloc]initWithFrame:CGRectMake(100, self.starView.frame.size.height+self.starView.frame.origin.y+10, (WIDTH-65-55)/3*2, 20)];
        self.sizeL.font = [UIFont systemFontOfSize:12];
        self.sizeL.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.downloadL];
        
        self.sizeL = [[UILabel alloc]initWithFrame:CGRectMake(100+self.downloadL.frame.size.width, self.starView.frame.size.height+self.starView.frame.origin.y+10,(WIDTH-65-55)/3 , 20)];
        self.sizeL.font = [UIFont systemFontOfSize:12];
        self.sizeL.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.sizeL];
        
        self.myBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, (100-20)/2, 45, 30)];
        [self.myBtn setTitle:@"免费" forState:UIControlStateNormal];
        [self.myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.myBtn.backgroundColor = [UIColor yellowColor];

        self.myBtn.layer.masksToBounds = YES;
        self.myBtn.layer.cornerRadius =5;
        [self.contentView addSubview:self.myBtn];
    }
    return self;
}
- (void)sendModel:(CollectionModel *)model{

    [self.view.titleImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.titleName.text = model.name;
    self.downloadL.text = [NSString stringWithFormat:@"%@次下载",model.downTimes];
    self.sizeL.text = [NSString stringWithFormat:@"%.2fMB",([model.size floatValue]/1024/1024)];
    [self.starView setStarValue:[NSString stringWithFormat:@"%@",model.star]];
}
@end
