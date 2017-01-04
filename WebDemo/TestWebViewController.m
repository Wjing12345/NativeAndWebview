//
//  TestWebViewController.m
//  wisenjoyapp
//
//  Created by wangjingmac on 2017/1/3.
//  Copyright © 2017年 wisenjoy. All rights reserved.
//

#import "TestWebViewController.h"
#import "DetailNativeView.h"
#import <WebKit/WebKit.h>
#import "UIFactory.h"
#include <objc/runtime.h>
#include <objc/message.h>
#import "YNTableView.h"

#define kProductDetailButtonBaseTag    9999
//宽度
#define kScreenWidth                                    [UIScreen mainScreen].bounds.size.width
//高度
#define kScreenHeight                                   [UIScreen mainScreen].bounds.size.height

#define kStatusBarHeight                                [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavigationBarHeight                            44.0
#define kBottomTabBarHeight                             49.0

//导航条高度
#define kNavBarHeight                                   kNavigationBarHeight+kStatusBarHeight

#define UICOLOR_FROM_RGB(r,g,b,a)                       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UICOLOR_FROM_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define kAppWhiteColor                                  [UIColor whiteColor]//白色
#define kAppDarkGrayColor                               [UIColor darkGrayColor]//深灰色
#define kAppGrayColor                                   [UIColor grayColor]//灰色
#define kAppBlackColor                                  [UIColor blackColor]//黑色
#define kAppMainBgColor                                 UICOLOR_FROM_RGB(240,240,240,1)

//随机颜色

#define random(r, g, b, a)                              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define kRandomColor                                    random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//字体
#define UIFont_size(size)                               [UIFont systemFontOfSize:size]
#define UIFont_boldsize(size)                               [UIFont boldSystemFontOfSize:size]

@interface TestWebViewController ()<WKNavigationDelegate,WKUIDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *backbtn;
@property (nonatomic, strong) UIButton *sharebtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, assign) int likeNum;
@property (nonatomic, assign) int favoriteNum;
@property (nonatomic, assign) int commentCount;
@property (nonatomic, assign) int likeCount;
@property (nonatomic, assign) int collectionCount;
@property (nonatomic, assign) int interaction;
@property (nonatomic, strong) DetailNativeView *nativeView;
@property (nonatomic, assign) BOOL isReload;


@property (nonatomic, assign) BOOL isTop;

@end

@implementation TestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    _isReload = YES;
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.navView];
    
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 30, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_back"] forState:UIControlStateNormal];
    backbtn.backgroundColor = [UIColor clearColor];
//    [backbtn setEnlargeEdge:15];
    [backbtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    self.backbtn = backbtn;
    
    UIButton *sharebtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-40, 25, 30, 30)];
    [sharebtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_share"] forState:UIControlStateNormal];
    sharebtn.backgroundColor = [UIColor clearColor];
//    [sharebtn setEnlargeEdge:15];
    [sharebtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sharebtn];
    self.sharebtn = sharebtn;

}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark ===== 视图创建 =====
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
//        NSInteger cellHeight = [self headViewHeight];
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) configuration:configuration];
        _wkWebView.scrollView.delegate = self;
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        NSString *t = @"http://zhidian.com.cn/editorschoice/24/zui-hao-de-kong-qi-jing-hua-qi-guo-chou-ban.html?utm_source=app&utm_medium=zhidian";
//        t = @"http://www.baidu.com";
        NSURL *newURL = [NSURL URLWithString:t];
        NSURLRequest *request = [NSURLRequest requestWithURL:newURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:3600];
        
        [_wkWebView loadRequest:request];
    }
    return _wkWebView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[YNTableView alloc]initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight+20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = [self setNativeDetailView];
    }
    return _tableView;
    
};

- (UIView *)navView{
    
    if (!_navView) {
        _navView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        _navView.backgroundColor = [UIColor whiteColor];
        _navView.alpha = 0;
        
        UIView *line = [UIFactory viewWithFrame:CGRectMake(0, 63.5, kScreenWidth, 0.5) bgColor:UICOLOR_FROM_HEX(0xDADADA)];
        [_navView addSubview:line];
    }
    return _navView;
}


- (NSInteger)headViewHeight{
    return 20+50+10+20+20+40+20;
}

- (UIView *)setNativeDetailView{
    
    UIView *headBackView = [UIView new];
    headBackView.userInteractionEnabled = YES;
    headBackView.frame = CGRectMake(0, 0, kScreenWidth,kScreenWidth/16*9);
    
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/16*9)];
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.clipsToBounds = YES;
    topImageView.image = [UIImage imageNamed:@"guide_img_4_1.jpg"];
    [headBackView addSubview:topImageView];
    self.topImageView = topImageView;
    
    return headBackView;
}

#pragma mark ===== UITableViewDelegate =====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = NO;
    
    switch (indexPath.row) {
        case 0:
        {
            static NSString *identifier = @"firstIdentifier";
            DetailNativeView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(cell == nil)
                cell = [[DetailNativeView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
            break;
        case 1:
        {
            static NSString *identifier = @"secondIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(cell == nil)
                cell = [[DetailNativeView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if(!_wkWebView)
                [cell addSubview:self.wkWebView];
            else
                [cell addSubview:_wkWebView];
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            return [self headViewHeight];
        }
            break;
        case 1:
        {
            return self.view.frame.size.height;
        }
            break;
        
        default:
            return 0;
            break;
    }
}

#pragma mark ===== 点击响应事件 =====
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction{
    
}

#pragma mark ===== WKWebViewDelegate =====
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
 
    [_tableView reloadData];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    _wkWebView.frame = CGRectMake(0, 0, kScreenWidth, 0);
    [_tableView reloadData];
}

#pragma mark ===== UIScrollViewDelegate =====
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if ([scrollView isKindOfClass:NSClassFromString(@"WKScrollView")]) {
        
        CGFloat offsetY = self.wkWebView.scrollView.contentOffset.y;
        
        if (offsetY <= 0) {
             _isTop = NO;
            self.wkWebView.scrollView.contentOffset = CGPointZero;
        }
        return;
    }
    
    
    
    CGFloat offsetY = _tableView.contentOffset.y;
    if(offsetY<0 && _isTop){
        self.wkWebView.scrollView.contentOffset = CGPointZero;
        return;
    }
    
    CGFloat rowOneY = CGRectGetMaxY([_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]) - 20;
//    NSLog(@"%f - %f",offsetY, rowOneY);
    if (offsetY >= rowOneY || _isTop) {
        _isTop = YES;
        _tableView.contentOffset = CGPointMake(0, rowOneY);
    } else {
        self.wkWebView.scrollView.contentOffset = CGPointZero;
    }
    
    
    //WKWebView更新渲染当前可视范围内的内容
//    if ([_wkWebView respondsToSelector:@selector(_updateVisibleContentRects)]) {
//        ((void(*)(id,SEL,BOOL))objc_msgSend)(_wkWebView,@selector(_updateVisibleContentRects),NO);
//    }
    
    CGFloat alphaSize = (offsetY+20)/((kScreenWidth-15)/16*9+195);
    _navView.alpha = alphaSize;
    
    if(alphaSize >= 0.5 && alphaSize <=1 ){
        [self.backbtn setBackgroundImage:[UIImage imageNamed:@"app_back"] forState:UIControlStateNormal];
        [self.sharebtn setBackgroundImage:[UIImage imageNamed:@"app_share"] forState:UIControlStateNormal];
    }else if (alphaSize < 0.5){
        [self.backbtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_back"] forState:UIControlStateNormal];
        [self.sharebtn setBackgroundImage:[UIImage imageNamed:@"enjoy_icon_share"] forState:UIControlStateNormal];
    }
    
    //1.处理图片放大
    CGFloat imageH = kScreenWidth/16*9;
    CGFloat imageW = kScreenWidth;
    if (offsetY < 0){
        CGFloat totalOffset = imageH + ABS(offsetY);
        CGFloat f = totalOffset / imageH;
        
        //如果想下拉固定头部视图不动，y和h 是要等比都设置。如不需要则y可为0
        self.topImageView.frame = CGRectMake(-(imageW * f - imageW) * 0.5, offsetY, imageW * f, totalOffset);
    }else{
        self.topImageView.frame = CGRectMake(0, 0, imageW, imageH);
    }
}





@end
