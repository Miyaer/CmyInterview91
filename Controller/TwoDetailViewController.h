//
//  TwoDetailViewController.h
//  CmyInterview91
//
//  Created by miya on 16/7/27.
//  Copyright © 2016年 miya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
@interface TwoDetailViewController : UIViewController
@property (nonatomic,strong) UILabel * desc;
@property (nonatomic,strong) UILabel * cateName;
@property (nonatomic,strong) UILabel * downTimes;
@property (nonatomic,strong) UILabel * name;
@property (nonatomic,strong) UILabel * price;
@property (nonatomic,strong) UILabel * introReason;
@property (nonatomic,strong) UIImageView * icon;
@property (nonatomic,strong) NSArray * recommendSofts;
@property (nonatomic,strong) NSString * url;
@end
