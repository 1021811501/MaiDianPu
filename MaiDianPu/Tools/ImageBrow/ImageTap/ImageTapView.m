//
//  ImageTapView.m
//  warenqi
//
//  Created by 李志帅 on 16/5/3.
//  Copyright © 2016年 Mr.Lin. All rights reserved.
//

#import "ImageTapView.h"
#import "PopupView.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DownActionSheetCell.h"
@implementation ImageTapView
{
    UIImageView *imageView;
    UIViewController *VC;
    NSArray *dataArray;
    UITableView *table ;
}
-(id)initWithImageTapWithUrl:(id )url{
    self = [super init];
    if (self) {
        dataArray= @[@"保存到相册",@"取消"];
        [self createViewWithUrl:url];
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapgesture];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:longPress];
    }
    return self;
}
-(void)createViewWithUrl:(id)url{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = RGBA_COLOR(0 , 0, 0, 0.8);
    
    imageView = [[UIImageView alloc] init];
    imageView.center = self.center;
    imageView.bounds = CGRectMake(0, 0, 100, 100);
    imageView.userInteractionEnabled = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"TaskPlaceHoderImage.jpg"]];
    [self addSubview:imageView];
    if ([url isKindOfClass:[UIImage class]]) {
        imageView.image = url;
        [self changeImageViewFrameWithImageView:imageView andImage:url];
    }else if ([url isKindOfClass:[NSString class]]){
        kWeakSelf
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"TaskPlaceHoderImage.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.25 animations:^{
                    NSLog(@"%f,,%f",image.size.width,image.size.height);
                    [weakself changeImageViewFrameWithImageView:imageView andImage:image];
                }];
            });
        }];

    }
//    [imageView addGestureRecognizer:[self addPinchGuester]];
//    [imageView addGestureRecognizer:[self addPanGuester]];
}
//-(UIPanGestureRecognizer *)addPanGuester{
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//    return pan;
//}
//-(UIPinchGestureRecognizer *)addPinchGuester{
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
//    return pinch;
//}
-(void)pinchAction:(UIPinchGestureRecognizer *)guester{
    UIView *view = [guester view];
    if (guester.state == UIGestureRecognizerStateBegan || guester.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, guester.scale, guester.scale);
        guester.scale = 1;
        NSLog(@"%f,%f,%f,%f",view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
    }else if (guester.state == UIGestureRecognizerStateEnded || guester.state == UIGestureRecognizerStateFailed || guester.state == UIGestureRecognizerStateCancelled){
//        if (view.layer) {
//            <#statements#>
//        }
    }
}
-(void)panAction:(UIPanGestureRecognizer *)recognizer{
    [self resetAnchorPoint:recognizer];
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
        UIView *view = [recognizer view];
        CGPoint point = [recognizer locationInView:view.superview];
        view.center = point;
    }
}
-(void)resetAnchorPoint:(UIGestureRecognizer *)recognize{
    if (recognize.state == UIGestureRecognizerStateBegan) {
        UIView *view = [recognize view];
        CGPoint point = [recognize locationInView:view];
        view.layer.anchorPoint = CGPointMake(point.x/view.frame.size.width, point.y/view.frame.size.height);
    }
    
}
-(void)changeImageViewFrameWithImageView:(UIImageView *)imageView1 andImage:(UIImage *)image{
    
    if (image.size.width > kScreenWidth) {
        imageView1.bounds = CGRectMake(0, 0, kScreenWidth, image.size.height/image.size.width * kScreenWidth);
    }
    else if (image.size.height > kScreenHeight) {
        imageView1.bounds = CGRectMake(0, 0, image.size.width/image.size.height*kScreenHeight, kScreenHeight);
    }
    else{
        imageView1.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    
}
- (void)showInView:(UIViewController *)Sview{
    if(Sview==nil){
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    }else{
        VC = Sview;
        Sview.navigationController.navigationBar.hidden = YES;
        [Sview.view addSubview:self];
    }

}
-(void)tapAction{
   [UIView animateWithDuration:0.25 animations:^{
       if (table) {
           table.frame = CGRectMake(0, kScreenHeight , kScreenWidth, 50*dataArray.count);
       }
       imageView.bounds = CGRectMake(0, 0, 0, 0);
   } completion:^(BOOL finished) {
       if (table) {
           [table removeFromSuperview];
       }
       VC.navigationController.navigationBar.hidden = NO;
       [self removeFromSuperview];
   }];
}
-(void)longPressAction:(UILongPressGestureRecognizer *)press{
    if (press.state == UIGestureRecognizerStateBegan) {
        if (!table) {
            [self createTableView];
            [self doAnimation];
        }
        return;
    }
}
-(void)createTableView{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 50*dataArray.count)];
    table.delegate = self;
    table.dataSource = self;
    //解决tableView分割线左边不到边的情况
    if ([table respondsToSelector:@selector(setSeparatorInset:)])
    {
        [table setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([table respondsToSelector:@selector(setLayoutMargins:)])
    {
        [table setLayoutMargins:UIEdgeInsetsZero];
    }
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:table];
    
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
    cell.infoLabel.text = dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row == 0){
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
            ALERTSTRING(@"请到设置-隐私-图片 中打开权限")
        }else{
            [self saveImageToPhotos:imageView.image];
        }
        
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
        table.frame = CGRectMake(0, kScreenHeight , kScreenWidth, 50*dataArray.count);
    } completion:^(BOOL finished) {
        table = nil;
        [table removeFromSuperview];
    }];
}
-(void)doAnimation{
    [UIView animateWithDuration:0.25 animations:^{
        table.frame = CGRectMake(0, kScreenHeight - 50 *dataArray.count, kScreenWidth, 50*dataArray.count);
    }];
}
-(void)saveImageToPhotos:(UIImage *)saveImage{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        BOOL hasAuthorized = (status == PHAuthorizationStatusAuthorized);
        if (hasAuthorized) {
            UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }else{
            ALERTSTRING(@"请到设置-隐私-图片 中打开权限")
        }
    }];
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
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
