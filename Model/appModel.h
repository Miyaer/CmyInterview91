//
//  appModel.h
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "JSONModel.h"

@interface appModel : JSONModel
@property (nonatomic,copy) NSString * icon;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * summary;
@end
