//
//  CollectionModel.h
//  CmyInterview91
//
//  Created by miya on 16/7/25.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "JSONModel.h"

@interface CollectionModel : JSONModel
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * detailUrl;
@property (nonatomic,copy) NSString * icon;
@property (nonatomic,copy) NSNumber * star;
@property (nonatomic,copy) NSString * downTimes;
@property (nonatomic,copy) NSNumber * size;
@property (nonatomic,copy) NSString * summary;
@end
