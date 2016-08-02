//
//  DetailModel.h
//  CmyInterview91
//
//  Created by miya on 16/7/27.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "JSONModel.h"

@interface DetailModel : JSONModel
@property (nonatomic,copy) NSString * desc;
@property (nonatomic,copy) NSString * cateName;
@property (nonatomic,copy) NSString * downTimes;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * introReason;
@property (nonatomic,copy) NSString * icon;
@property (nonatomic,copy) NSArray * recommendSofts;
@end
