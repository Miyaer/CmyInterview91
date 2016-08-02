//
//  firstCell.h
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
@interface firstCell : UICollectionViewCell
@property (nonatomic,strong) UILabel * nameL;
@property (nonatomic,strong) UIImageView * titleImage;

- (void)sendModel:(CollectionModel *)model;
@end
