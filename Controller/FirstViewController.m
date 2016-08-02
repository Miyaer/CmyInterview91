//
//  FirstViewController.m
//  CmyInterview91
//
//  Created by miya on 16/7/25.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "FirstViewController.h"
#import "AllModel.h"
#import "TableCell.h"
#import "AppCell.h"
#import "AFNetworking.h"
#import "SecondCell.h"
#import "HeaderView.h"
#import "MiyaerScrollView.h"
#import "AlertView.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * nameArr;
    NSMutableArray * scrollArr;
}
@property (nonatomic,strong) AlertView * alertView;
@property (nonatomic,strong) UIScrollView * myScroll;
@property (nonatomic,strong) NSArray * urlArray;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UICollectionView * appCollection;
@property (nonatomic,strong) NSMutableArray * dataSorce;
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@property (nonatomic,strong) NSMutableArray * JPArr;
@property (nonatomic,strong) NSMutableArray * HMArr;
@property (nonatomic,strong) NSMutableArray * BJArr;
@property (nonatomic,strong) MiyaerScrollView * scrollView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadScrollData];
    scrollArr = [[NSMutableArray alloc]init];
    self.urlArray = @[HOTAPP,JPAPP,XSAPP,ZJAPP,YYAPP,HMAPP,BJAPP];
    [self loadData];
    nameArr = [[NSArray alloc]init];
    nameArr = @[@"热门应用",@"精品推荐",@"限时免费",@"装机必备",@"应用专题",@"黑马闯入",@"编辑推荐"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];


}
#pragma mark 加载数据
- (void)loadData{
    [self.dataSorce removeAllObjects];
    [self.JPArr removeAllObjects];
    [self.HMArr removeAllObjects];
    [self.BJArr removeAllObjects];
    
    NSString * url = @"http://applebbx.sj.91.com/api/?";
    
    NSDictionary * dic = @{@"cuid":@"41f2eab81400f6effbf3e273ca675ea325735e1e",@"act":@1,@"imei":@"1D4586B8-47C1-4F03-A4EA-BC30A4DF4F9D",@"spid":@2,@"osv":@"8.4.1",@"dm":@"iPhone7,1",@"sv":@"3.1.3",@"nt":@10,@"mt":@1,@"pid":@2};
    __weak typeof(self) weakSelf = self;
    [self.manager GET:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dict[@"Result"];
        NSDictionary * dic2 = [array firstObject];
        NSArray * partsArr = dic2[@"parts"];
        JSONModelArray * jsonArr = [[JSONModelArray alloc]initWithArray:partsArr modelClass:[AllModel class]];
        
        for (AllModel * model in jsonArr) {
            [weakSelf.dataSorce addObject:model];
             [weakSelf loadTableData:JPAPP andArr:self.JPArr];
            [weakSelf loadTableData:HMAPP andArr:self.HMArr];
            [weakSelf loadTableData:BJAPP andArr:self.BJArr];
        }
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView reloadData];

    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];
    
    

     }
- (void)loadScrollData{
    [self.manager GET:SCROLL parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"Result"];
        NSDictionary * dict = [array firstObject];
        NSArray * images = dict[@"Value"];
        for (NSDictionary * dic in images) {
            [scrollArr addObject:dic[@"LogoUrl"]];
        }
        
        self.scrollView.imageURLArray = scrollArr;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求数据失败");
    }];

}
- (void)loadTableData:(NSString *)url andArr:(NSMutableArray *)array{
    
    __weak typeof(self) weakSelf=self;
  [self.manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
      NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      NSDictionary * result = dict[@"Result"];
      NSArray * items = result[@"items"];
      JSONModelArray * jsonArr = [[JSONModelArray alloc]initWithArray:items modelClass:[CollectionModel class]];
     // NSLog(@"dic %@",dict);
      for (CollectionModel * model in jsonArr) {
          [array addObject:model];
      }
     // NSLog(@"%@",JPAPP);
      [weakSelf.tableView reloadData];
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"请求数据失败");
  }];
    
    
}
#pragma mark - 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSorce count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AllModel * model = self.dataSorce[section];
    if ([model.uiType intValue] == 4 ) {
        if (self.HMArr.count<10) {
            return self.HMArr.count;;
        } else if(self.JPArr.count<10){
            return self.JPArr.count;
        }else if (self.BJArr.count<10){
            return self.BJArr.count;
        }else{
            return 3;
        }
    } else {
        return 1;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 60; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllModel * model = self.dataSorce[indexPath.section];
    if ([model.uiType intValue]==1) {
        TableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[TableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell.vc = self;
        cell.url = self.urlArray[indexPath.section];
        [cell loadData];
        [cell.collectionView reloadData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if ([model.uiType intValue]==4){
        SecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell41"];
        if (!cell) {
            cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell41"];
        }
        if (indexPath.section==1) {
            if (self.JPArr.count>=10) {
                CollectionModel * model = self.JPArr[indexPath.row];
                [cell sendModel:model];
            }
        }else if (indexPath.section==5){
            if (self.JPArr.count>=10) {
                CollectionModel * model = self.JPArr[indexPath.row];
                [cell sendModel:model];
            }
        }else if (indexPath.section==6){
            if (self.JPArr.count>=10) {
                CollectionModel * model = self.JPArr[indexPath.row];
                [cell sendModel:model];
            }
        }
        
        [cell.myBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
    }else{
        AppCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell) {
            cell = [[AppCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
        }
        cell.url = self.urlArray[indexPath.section];
        [cell loadData];
        [cell.collectionView reloadData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.vc = self;
        return cell;
    }
    
    
    
}
- (void)btnClick:(UIButton *)btn{
        
    [self.view addSubview:self.alertView];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    AllModel * model = self.dataSorce[indexPath.section];
    if ([model.uiType intValue]==1) {
        return 100;
    }else if ([model.uiType intValue]==4){
        return 100;
    }else{
       return 200;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderView * view = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 35)];
    view.nameL.text = nameArr[section];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AllModel * model = self.dataSorce[indexPath.section];
    

    if ([model.uiType intValue]==4) {
        DetailViewController * dvc = [[DetailViewController alloc]init];
        if (indexPath.section==1) {
            CollectionModel * model = self.JPArr[indexPath.row];
            dvc.url = model.detailUrl;
        }else if (indexPath.section==5){
            CollectionModel * model = self.HMArr[indexPath.row];
            dvc.url = model.detailUrl;

        }else{
            CollectionModel * model = self.BJArr[indexPath.row];
            dvc.url = model.detailUrl;

        }
        [self.navigationController pushViewController:dvc animated:YES];
        
 }
}
#pragma mark 懒加载
- (NSArray *)urlArray{
    if (!_urlArray) {
        _urlArray = [[NSArray alloc]init];
    }
    return _urlArray;
}
- (NSMutableArray *)dataSorce{
    if (!_dataSorce) {
        _dataSorce = [[NSMutableArray alloc]init];
    }
    return _dataSorce;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-44) style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView.frame = CGRectMake(0, 0, WIDTH, 120);
        _tableView.tableHeaderView = self.scrollView;
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self loadData];
            [self.tableView reloadData];
            
        }];
    }
    return _tableView;
}
- (NSMutableArray *)JPArr{
    if (!_JPArr) {
        _JPArr = [[NSMutableArray alloc]init];
    }
    return _JPArr;
}
- (NSMutableArray *)HMArr{
    if (!_HMArr) {
        _HMArr = [[NSMutableArray alloc]init];
    }
    return _HMArr;
}
- (NSMutableArray *)BJArr{
    if (!_BJArr) {
        _BJArr = [[NSMutableArray alloc]init];
    }
    return _BJArr;
}
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _manager;
}
- (MiyaerScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[MiyaerScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
        _scrollView.needPageControl = YES;
        _scrollView.infiniteLoop = YES;
        
    }
    return _scrollView;
}
- (AlertView *)alertView{
    if (!_alertView) {
        _alertView = [[AlertView alloc]initWithFrame:CGRectMake(0, 0, WIDTH-20, 180)];
        self.alertView.center = self.view.center;
        
    }
    return _alertView;
}

@end
