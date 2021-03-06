//
//  TableCell.h
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface TableCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * datasource;
@property (nonatomic,strong) NSString * url;
@property (nonatomic,strong) NSString * titleName;
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@property (nonatomic,strong) UIViewController * vc;
-(void)loadData;
@end
