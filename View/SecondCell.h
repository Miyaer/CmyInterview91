//
//  SecondCell.h
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "CollectionModel.h"
#import "AlertView.h"
@interface SecondCell : UITableViewCell

@property (nonatomic,strong) UIImageView * titleImage;
@property (nonatomic,strong) UILabel * titleName;
@property (nonatomic,strong) StarView * starView;
@property (nonatomic,strong) UILabel * downloadL;
@property (nonatomic,strong) UILabel * sizeL;
@property (nonatomic,strong) UIButton * myBtn;
@property (nonatomic,assign) UIViewController * vc;
@property (nonatomic,strong) AlertView * view;
- (void)sendModel:(CollectionModel *)model;
@end
