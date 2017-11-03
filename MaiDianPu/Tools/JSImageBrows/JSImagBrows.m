//
//  JSImagBrows.m
//  JSImageBrows
//
//  Created by JasonLee on 2017/10/30.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "JSImagBrows.h"
#import "UIImage+JSUtility.h"
#import "JSImageBrowsCell.h"
#import "JSItemView.h"
#import "JSActionSheetView.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface JSImagBrows ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JSItemViewDelegate,JSActionSheetViewDelegate>
//买玻璃效果
@property(nonatomic,strong)UIImageView *blurImageView;
//self.parentVC界面的截图//目的是为了有一个渐变的效果
@property(nonatomic,strong)UIImageView *screenShotImageView;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UIImage *placeHolderImage;
@property(nonatomic,strong)UIImage *blurImage;
@property(nonatomic,strong)UIImage *screenImage;
@end

@implementation JSImagBrows

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.blurImageView];
    [self.view addSubview:self.screenShotImageView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.screenShotImageView.alpha = 0;
    } completion:nil];
}
-(id)initWithParentController:(UIViewController *)VC images:(NSArray *)imageArray andCurrentIndex:(NSInteger)currentIndex andPlaceHolderImage:(UIImage *)placeHolderImage{
    self = [super init];
    if (self) {
        self.parentVC = VC;
        self.imageArray = imageArray;
        self.currentIndex = currentIndex;
        self.placeHolderImage = placeHolderImage;
        self.screenImage = [self screenShotImageFrom:[[UIApplication sharedApplication].delegate window]];
        self.blurImage = [self.screenImage applyBlurWithRadius:20 tintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f] saturationDeltaFactor:1.4 maskImage:nil];
    }
    return self;
}
-(void)show{
    [self.parentVC presentViewController:self animated:NO completion:nil];
}
#pragma mark     UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    JSImageBrowsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JSImageBrowsCell" forIndexPath:indexPath];
    cell.itemView.guestureDelegate = self;
    cell.itemView.placeHolderImage = self.placeHolderImage;
    if (indexPath.row < self.imageArray.count) {
        [cell updateCellWithImage:self.imageArray[indexPath.row]];
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark     UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width + 10, [UIScreen mainScreen].bounds.size.height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    self.pageControl.currentPage = index;
    self.currentIndex = index;
}
-(void)jsItemViewSigleTapActionToHide:(JSItemView *)itemView{
    [self hide];
}

- (void)jsItemViewLongPressAction:(JSItemView *)itemView {
    NSLog(@"ddd");
    JSActionSheetView *sheetView = [[JSActionSheetView alloc] initTilesArray:@[@"保存图片",@"取消"] delegate:self];
    [sheetView show];
}
- (void)lwActionSheet:(JSActionSheetView *)actionSheet didSelectedButtonWithIndex:(NSInteger)index{
    if (index == 0) {
        NSArray *array = [self.collectionView visibleCells];
        JSImageBrowsCell *cell = nil;
        if (array.count != 0) {
            cell = array[0];
        }
        if (!cell.itemView.itemImageView.image) return;
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请到设置-隐私-图片 中打开权限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
         UIImageWriteToSavedPhotosAlbum(cell.itemView.itemImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    JSPopUpView *pop = [[JSPopUpView alloc] initWithTitle:msg];
    [pop show];
}
-(void)hide{
    NSArray *array = [self.collectionView visibleCells];
    JSImageBrowsCell *cell = nil;
    if (array.count != 0) {
        cell = array[0];
        if (cell.itemView.zoomScale != 1.0f) {
            cell.itemView.zoomScale = 1.0f;
        }
    }
    [UIView animateWithDuration:0.1f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.screenShotImageView.alpha = 1.0f;
                         cell.itemView.itemImageView.bounds = CGRectMake(0, 0, 30, 30);
                     } completion:^(BOOL finished) {
                         [self dismissViewControllerAnimated:NO completion:nil];
                     }];
}
-(UIImageView *)blurImageView{
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc] init];
        _blurImageView.image = self.blurImage;
        _blurImageView.frame = [UIScreen mainScreen].bounds;
    }
    return _blurImageView;
}
-(UIImageView *)screenShotImageView{
    if (!_screenShotImageView) {
        _screenShotImageView = [[UIImageView alloc] init];
        _screenShotImageView.image = self.screenImage;
        _screenShotImageView.frame = [UIScreen mainScreen].bounds;
    }
    return _screenShotImageView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width + 10, [UIScreen mainScreen].bounds.size.height);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JSImageBrowsCell class] forCellWithReuseIdentifier:@"JSImageBrowsCell"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0,[UIScreen mainScreen].bounds.size.height - 70);
        _pageControl.numberOfPages = self.imageArray.count;
        _pageControl.currentPage = self.currentIndex;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}
-(UIImage *)screenShotImageFrom:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation JSPopUpView
-(id)initWithTitle:(NSString *)title andDisMissTime:(int)dismissTime{
    self = [super init];
    if (self) {
        self.dismissTime = dismissTime;
        [self createToastWithTitle:title];
    }
    return self;
    
}
-(id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.dismissTime = 2;
        [self createToastWithTitle:title];
    }
    return self;
}
-(void)createToastWithTitle:(NSString *)title{
    UIFont *font = [UIFont boldSystemFontOfSize:15];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *dic = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style.copy};
    CGSize labelSize = [title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 100) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    self.backgroundColor = [UIColor colorWithRed:192/255.0 green:182/255.0  blue:170/255.0  alpha:1];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height - 90);
    self.bounds = CGRectMake(0, 0, labelSize.width + 20, labelSize.height + 5);
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = title;
    label.numberOfLines = 0 ;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    [self addSubview:label];
}
-(void)show{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    [UIView animateWithDuration:self.dismissTime animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end


