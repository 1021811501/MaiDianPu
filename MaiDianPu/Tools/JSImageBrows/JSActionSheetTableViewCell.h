


#import <UIKit/UIKit.h>

@interface JSActionSheetTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString* title;


- (void)show;

@end


@interface JSActionSheetTableViewCellContent : UIView

@property (nonatomic,copy) NSString* title;

@end
