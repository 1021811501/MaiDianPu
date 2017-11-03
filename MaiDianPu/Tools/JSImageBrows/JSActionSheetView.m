


#import "JSActionSheetView.h"
#import "UIImage+JSUtility.h"
#import "JSActionSheetTableViewCell.h"
//#import "GallopUtils.h"


const CGFloat cellHeight = 50.0f;


@interface JSActionSheetView ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImageView* screenshotImageView;
@property (nonatomic,copy) NSArray* dataSource;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,assign) NSInteger titlesCount;

@end

@implementation JSActionSheetView

- (id)initTilesArray:(NSArray *)titles delegate:(id <JSActionSheetViewDelegate>)delegate {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.delegate = delegate;
        self.titlesCount = titles.count;
        self.dataSource = titles;

        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        UIImage* screenshot = [self _screenshotFromView:window];

        self.screenshotImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.screenshotImageView.backgroundColor = [UIColor clearColor];
//        self.screenshotImageView.image = [screenshot applyBlurWithRadius:10
//                                                               tintColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f]
//                                                   saturationDeltaFactor:1.4
//                                                               maskImage:nil];
        self.screenshotImageView.image = screenshot;
        [self addSubview:self.screenshotImageView];

        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                       [UIScreen mainScreen].bounds.size.height  - cellHeight * self.titlesCount ,
                                                                       [UIScreen mainScreen].bounds.size.width,
                                                                       cellHeight * self.titlesCount)
                                                      style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark -

- (void)show {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];

    NSArray* cells = [self.tableView visibleCells];
    for (NSInteger i = 0;i < cells.count;i ++) {
        JSActionSheetTableViewCell* cell = cells[i];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * 0.09f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cell show];
        });
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - cellHeight * self.titlesCount ), point)) {
        [self _hide];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"cellIdentifier";
    JSActionSheetTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[JSActionSheetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self _hide];
    if ([self.delegate respondsToSelector:@selector(lwActionSheet:didSelectedButtonWithIndex:)]
        &&[self.delegate conformsToProtocol:@protocol(JSActionSheetViewDelegate)]) {
        [self.delegate lwActionSheet:self didSelectedButtonWithIndex:indexPath.row];
    }
}

- (void)tapView {
    [self _hide];
}

- (void)_hide {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.tableView.frame = CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,cellHeight * self.titlesCount);
        weakSelf.screenshotImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


- (UIImage *)_screenshotFromView:(UIView *)aView {
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size,NO,[UIScreen mainScreen].scale);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

#pragma mark - UIGestrueDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
