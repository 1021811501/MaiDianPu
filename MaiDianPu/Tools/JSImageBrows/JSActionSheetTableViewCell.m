
//
//

//

#import "JSActionSheetTableViewCell.h"


@interface JSActionSheetTableViewCell ()

@property (nonatomic,strong) JSActionSheetTableViewCellContent* content;

@end

@implementation JSActionSheetTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.content = [[JSActionSheetTableViewCellContent alloc] initWithFrame:CGRectMake(0.0f,50.0f, [UIScreen mainScreen].bounds.size.width, 50.0f)];
        [self.contentView addSubview:self.content];
    }
    return self;
}


- (void)show {
    [UIView animateWithDuration:0.05f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.content.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50.0f);
    } completion:^(BOOL finished) {

    }];
}

- (void)setTitle:(NSString *)title {
    if (_title != title ) {
        _title = title;
    }
    self.content.title = self.title;
}

@end



@interface JSActionSheetTableViewCellContent ()


@property (nonatomic,strong) UILabel* textLabel;

@end


@implementation JSActionSheetTableViewCellContent : UIView


- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = [title copy];
    }
    self.textLabel.text = self.title;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor blackColor];
        [self addSubview:self.textLabel];
    }
    return self;

}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10.0f, 49.9f);
    CGContextAddLineToPoint(context, rect.size.width - 10.0f, 49.9f);
    CGContextSetLineWidth(context, 0.1f);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
}

@end
