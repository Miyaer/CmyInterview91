//
//  AppCell.m
//  CmyInterview91
//
//  Created by miya on 16/7/26.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "AppCell.h"
#import "TableViewController.h"
#import "AppCollectionCell.h"
#import "appModel.h"
#import "UIImageView+WebCache.h"
#import "HeaderView.h"
@implementation AppCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout * flayout = [[UICollectionViewFlowLayout alloc]init];
        flayout.scrollDirection =UICollectionViewScrollDirectionVertical;
        flayout.itemSize = CGSizeMake((WIDTH-40)/2, 90);
        flayout.minimumInteritemSpacing = 10;
        flayout.minimumLineSpacing = 10;
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, 200) collectionViewLayout:flayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.collectionView registerClass:NSClassFromString(@"AppCollectionCell") forCellWithReuseIdentifier:@"cell"];
        
//        [self.collectionView registerClass:NSClassFromString(@"HeaderView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [self.contentView addSubview:self.collectionView];
        
    }
    return self;
}


-(void)loadData{
    __weak typeof(self) weakSelf = self;
    [self.manager GET:self.url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * result = dict[@"Result"];
        JSONModelArray * jsonArr = [[JSONModelArray alloc]initWithArray:result modelClass:[appModel class]];
        for (appModel * model in jsonArr) {
            [weakSelf.datasource addObject:model];
        }
        [weakSelf.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
    
}

#pragma mark - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TableViewController * tvc = [[TableViewController alloc]init];
    appModel * model = self.datasource[indexPath.row];
    
    tvc.url =model.url;
    [self.vc.navigationController pushViewController:tvc animated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.datasource.count>=4) {
        return 4;
    }else
        return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AppCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    appModel * model = self.datasource[indexPath.item];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    return cell;
}
#pragma mark -懒加载
-(NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc]init];
    }
    return _datasource;
}
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _manager;
}
@end
