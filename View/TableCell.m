//
//  TableCell.m
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "TableCell.h"
#import "firstCell.h"
#import "CollectionModel.h"
#import "TwoDetailViewController.h"
@implementation TableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout * flayout = [[UICollectionViewFlowLayout alloc]init];
        flayout.minimumInteritemSpacing = 10;
        flayout.minimumLineSpacing = 10;
        flayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flayout.itemSize = CGSizeMake(90, 90);
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 100) collectionViewLayout:flayout];
        self.collectionView.bounces = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.contentOffset = CGPointMake(0, 0);
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.collectionView];
        
        [self.collectionView registerClass:NSClassFromString(@"firstCell") forCellWithReuseIdentifier:@"cell"];

    }
    return self;
}
-(void)loadData{
    __weak typeof(self) weakSelf = self;
    [self.manager GET:self.url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * result = dict[@"Result"];
        NSArray * items = result[@"items"];
        JSONModelArray * jsonArr = [[JSONModelArray alloc]initWithArray:items modelClass:[CollectionModel class]];
        for (CollectionModel * model in jsonArr) {
            [weakSelf.datasource addObject:model];
        }
        [weakSelf.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
    
}

#pragma mark -delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TwoDetailViewController * vc = [[TwoDetailViewController alloc]init];
    CollectionModel * model = self.datasource[indexPath.item];
    vc.url = model.detailUrl;
    [self.vc.navigationController pushViewController:vc animated:YES];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.datasource.count>=10) {
        return 10;
    }else
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    firstCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CollectionModel * model = self.datasource[indexPath.item];
    [cell sendModel:model];
    return cell;
}
#pragma mark -懒加载
-(NSMutableArray * )datasource{
    if (!_datasource) {
    _datasource = [[NSMutableArray alloc]init];
    }
    return _datasource;
}
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _manager;
}

@end
