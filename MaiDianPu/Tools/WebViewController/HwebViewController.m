//
//  HelpViewController.m
//  warenqi
//
//  Created by Mr.Lin. on 16/5/4.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "HwebViewController.h"

@interface HwebViewController ()
{
    UIWebView *_webView;
    UIButton *_backBtn;
    UIButton *_closeBtn;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@end

@implementation HwebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createWebView];
    [self _createRightItem];
    if (self.isShowShare) {
        [self _createShareBtn];
    }
    if (self.isFromHelp) {
        [self _createHelpBtn];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.showNavLeftItem = NO;
    [self _createItems];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)_createWebView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 49)];
    _webView.delegate = self;
    _webView.backgroundColor = HexColor(@"fafafa", 1);
    if (self.htmlString) {
        [_webView loadHTMLString:self.htmlString baseURL:nil];
    }else{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
        [_webView loadRequest:request];
    }
    [self.view addSubview:_webView];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = CGRectMake(0, 0, kScreenWidth, 64);
    CGRect barFrame = CGRectMake(0, 64, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.progressBarView.alpha = 1;
    _progressView.progressBarView.backgroundColor = [UIColor orangeColor];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_progressView];
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (self.htmlString) {
        _progressView.progressBarView.alpha = 0;
    }else{
        [_progressView setProgress:progress animated:YES];
    }
}

- (void)_createRightItem{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 55, 30);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:@selector(helpBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)_createItems{
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 40, 30);
    [_backBtn setImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn.frame = CGRectMake(0, 0, 40, 30);
    _closeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _closeBtn.hidden = YES;
    [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:_closeBtn];
    
    NSArray *itemArray = @[backItem2, closeItem];
    self.navigationItem.leftBarButtonItems = itemArray;
    
}

- (void)_createHelpBtn{
    
    UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    helpBtn.frame = CGRectMake(0, 0, 35, 35);
    [helpBtn setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
    [helpBtn addTarget:self action:@selector(helpBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *helpItem = [[UIBarButtonItem alloc] initWithCustomView:helpBtn];
    self.navigationItem.rightBarButtonItem = helpItem;
    
}

- (void)_createShareBtn{
    UIButton *sharaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharaBtn.frame = CGRectMake(0, 0, 30, 30);
    [sharaBtn setImage:[UIImage imageNamed:@"shareNew"] forState:UIControlStateNormal];
    [sharaBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:sharaBtn];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)backBtnAction{
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)helpBtnAction{

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://im/chat?chat_type=crm&uin=800172665&version=1&src_type=web"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://im/chat?chat_type=crm&uin=800172665&version=1&src_type=web"]];
    }else{
        ALERTSTRING(@"联系在线客服需要安装手机QQ!");
    }
}

- (void)shareBtnAction{
    
}

- (void)closeBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_webView.canGoBack) {
        _closeBtn.hidden = NO;
    }else{
        _closeBtn.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
