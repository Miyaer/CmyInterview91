//
//  TableViewController.m
//  CmyInterview91
//
//  Created by miya on 16/7/27.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "TableViewController.h"
#import "AFNetworking.h"
#import "SecondCell.h"
#import "CollectionModel.h"
#import "DetailViewController.h"
@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataSorce;
@property (nonatomic,strong)AFHTTPSessionManager * manager;

@end

@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}
-(void)loadData{
    __weak typeof(self) weakSelf = self;
    [self.manager GET:self.url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * dict = dic[@"Result"];
        NSArray * array = dict[@"items"];
        JSONModelArray * jsonArr = [[JSONModelArray alloc]initWithArray:array modelClass:[CollectionModel class]];
        for (CollectionModel * model in jsonArr) {
            [weakSelf.dataSorce addObject:model];
        }
        [weakSelf.tableView reloadData];
        NSLog(@"data %@",self.dataSorce);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
}
#pragma mark - delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSorce count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CollectionModel * model = self.dataSorce[indexPath.row];
    [cell sendModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * dvc = [[DetailViewController alloc]init];
    CollectionModel * model = self.dataSorce[indexPath.row];
    dvc.url = model.detailUrl;
    [self.navigationController pushViewController:dvc animated:YES];

}
#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-44) style:UITableViewStylePlain];
        _tableView.bounces = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate =self;
        _tableView.dataSource = self;
            }
    return _tableView;
}
-(NSMutableArray *)dataSorce{
    if (!_dataSorce) {
        _dataSorce = [[NSMutableArray alloc]init];
    }
    return _dataSorce;
}
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _manager;
}
@end
