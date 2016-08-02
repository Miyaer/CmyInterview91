//
//  DetailViewController.m
//  CmyInterview91
//
//  Created by miya on 16/7/27.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>
@interface DetailViewController ()
@property (nonatomic,strong) WKWebView * webView;
@end


@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [_webView loadRequest:request];
}


@end
