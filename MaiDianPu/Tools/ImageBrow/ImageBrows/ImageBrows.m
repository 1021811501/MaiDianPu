//
//  ImageBrows.m
//  warenqi
//
//  Created by 李志帅 on 16/8/10.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "ImageBrows.h"

@implementation ImageBrows
{
    UIViewController *VC;
    NSArray *_dataArray;
    UITableView *_table ;
    UIScrollView *_scrollView;
    UIPageControl *_page;
}
-(id)initWithImageTapWithUrlArray:(NSArray *)urlArray andIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        _dataArray= @[@"保存到相册",@"取消"];
        [self createViewWithUrlArray:urlArray andIndex:index];
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapgesture];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:longPress];
    }
    return self;
}
-(void)createViewWithUrlArray:(NSArray *)urlArray andIndex:(NSInteger)index{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = RGBA_COLOR(0 , 0, 0, 0.8);
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth *urlArray.count, CGRectGetHeight(self.frame));
    [_scrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];

    for (int i = 0; i<urlArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.tag = i+1;
        imageView.center = CGPointMake(kScreenWidth/2.f+kScreenWidth*i, self.center.y);
        imageView.bounds = CGRectMake(0, 0, 100, 100);
        [_scrollView addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlArray[i]] placeholderImage:[UIImage imageNamed:@"pic_default@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.25 animations:^{
                    NSLog(@"%f,,%f",image.size.width,image.size.height);
                    
                    if (image.size.width > kScreenWidth) {
                        imageView.bounds = CGRectMake(0, 0, kScreenWidth, image.size.height/image.size.width * kScreenWidth);
                    }
                    else if (image.size.height > kScreenHeight) {
                        imageView.bounds = CGRectMake(0, 0, image.size.width/image.size.height*kScreenHeight, kScreenHeight);
                    }
                    else{
                        imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
                    }
                }];
            });
        }];
    }
    _page = [[UIPageControl alloc] init];
    _page.center = CGPointMake(self.center.x, kScreenHeight - 70);
    _page.numberOfPages = urlArray.count;
    _page.currentPage = index;
    _page.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:_page];
}
- (void)showInView:(UIViewController *)Sview{
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}
-(void)tapAction{
    [UIView animateWithDuration:0.25 animations:^{
        if (_table) {
            _table.frame = CGRectMake(0, kScreenHeight , kScreenWidth, 50*_dataArray.count);
        }
        for (int i = 0; i<_page.numberOfPages; i++) {
            UIImageView *imageView = [_scrollView viewWithTag:i+1];
            imageView.bounds = CGRectMake(0, 0, 0, 0);
        }
    } completion:^(BOOL finished) {
        if (_table) {
            [_table removeFromSuperview];
        }
        [_scrollView removeFromSuperview];
        VC.navigationController.navigationBar.hidden = NO;
        [self removeFromSuperview];
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _page.currentPage = scrollView.contentOffset.x/kScreenWidth;
}
-(void)longPressAction:(UILongPressGestureRecognizer *)press{
    if (press.state == UIGestureRecognizerStateBegan) {
        if (!_table) {
            [self createTableView];
            [self doAnimation];
        }
        return;
    }
}
-(void)createTableView{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 50*_dataArray.count)];
    _table.delegate = self;
    _table.dataSource = self;
    //解决tableView分割线左边不到边的情况
    if ([_table respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_table setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_table respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_table setLayoutMargins:UIEdgeInsetsZero];
    }
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:_table];
    
    //    [self addSubview:table]用这句话导致轻点手势和表didselectrow方法冲突didselectrow方法会不执行
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DownActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[DownActionSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.infoLabel.text = _dataArray[indexPath.row];
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        UIImageView *imageView = [_scrollView viewWithTag:_page.currentPage+1];
        [self saveImageToPhotos:imageView.image];
    }
    [self tappedCancel];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tappedCancel{
    [UIView animateWithDuration:0.25 animations:^{
        _table.frame = CGRectMake(0, kScreenHeight , kScreenWidth, 50*_dataArray.count);
    } completion:^(BOOL finished) {
        _table = nil;
        [_table removeFromSuperview];
    }];
}
-(void)doAnimation{
    [UIView animateWithDuration:0.25 animations:^{
        _table.frame = CGRectMake(0, kScreenHeight - 50 *_dataArray.count, kScreenWidth, 50*_dataArray.count);
    }];
}
-(void)saveImageToPhotos:(UIImage *)saveImage{
    UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSLog(@"%s",__FUNCTION__);
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    PopupView *pop = [[PopupView alloc] initWithTitle:msg];
    [pop show];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[self class]]) {
        return YES;
    }else{
        return NO;
    }
}

@end
