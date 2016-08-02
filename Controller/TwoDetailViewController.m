//
//  TwoDetailViewController.m
//  CmyInterview91
//
//  Created by miya on 16/7/27.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "TwoDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "detailCell.h"
@interface TwoDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * datasource;
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@end

@implementation TwoDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(5, HEIGHT-244-21, WIDTH, 21)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor darkGrayColor];
    label.text = @"您可能会喜欢以下软件：";
    [self.view addSubview:label];
    // Do any additional setup after loading the view.
}
- (void)loadData{
    
    [self.manager GET:self.url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary * dic= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * dict = dic[@"Result"];
        DetailModel * model = [[DetailModel alloc]initWithDictionary:dict error:nil];
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        self.name.text = model.name;
        self.downTimes.text = [NSString stringWithFormat:@"%@次下载",dict[@"downTimes"]];
        self.cateName.text = [NSString stringWithFormat:@"类别：%@",dict[@"cateName"]];
        self.desc.text = dict[@"desc"];
        [self.datasource addObjectsFromArray:model.recommendSofts];
     //   NSLog(@"desc %@",dict[@"desc"]);
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}
#pragma mark - delegate
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.datasource count];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TwoDetailViewController * vc = [[TwoDetailViewController alloc]init];
    vc.url = self.datasource[indexPath.row][@"detailUrl"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    detailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.datasource[indexPath.row][@"icon"]]];
    cell.name.text = self.datasource[indexPath.row][@"resName"];
    return cell;
}
#pragma mark - 懒加载
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, 90, 90)];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 5;
        [self.view addSubview:self.icon];
    }
    return _icon;
}
- (UILabel * )name{
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(120, 80, WIDTH-120, 21)];
        _name.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_name];
    }
    return _name;
}
- (UILabel *)downTimes{
    if (!_downTimes) {
        _downTimes = [[UILabel alloc]initWithFrame:CGRectMake(120,120,  WIDTH-120, 21)];
        _downTimes.font = [UIFont systemFontOfSize:15];
        _downTimes.textColor = [UIColor lightGrayColor];
        [self.view addSubview:_downTimes];
    }
    return _downTimes;
}
- (UILabel *)cateName{
    if (!_cateName) {
        _cateName = [[UILabel alloc]initWithFrame:CGRectMake(120,150 , WIDTH-120, 21)];
        _cateName.textColor = [UIColor lightGrayColor];
        _cateName.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_cateName];
    }
    return _cateName;
}
- (UILabel *)desc{
    if (!_desc) {
        _desc = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, WIDTH-20, 200)];
       // [_desc sizeToFit];
        _desc.font = [UIFont systemFontOfSize:18];
        _desc.textColor = [UIColor lightGrayColor];
        _desc.numberOfLines = 0;
        [self.view addSubview:self.desc];
        
    }
    return _desc;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flayout = [[UICollectionViewFlowLayout alloc]init];
        flayout.minimumInteritemSpacing=10;
        flayout.minimumLineSpacing = 10;
        flayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flayout.itemSize = CGSizeMake(120, 120);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, HEIGHT-44-170-30, WIDTH, 170) collectionViewLayout:flayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces= NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:self.collectionView];
        
        [_collectionView registerClass:NSClassFromString(@"detailCell") forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}
-(NSMutableArray *)datasource{
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
