

#import <UIKit/UIKit.h>

@class JSActionSheetView;

@protocol JSActionSheetViewDelegate <NSObject>

@optional

- (void)lwActionSheet:(JSActionSheetView *)actionSheet didSelectedButtonWithIndex:(NSInteger)index;

@end

@interface JSActionSheetView : UIView

@property (nonatomic,weak) id <JSActionSheetViewDelegate> delegate;
@property (nonatomic,strong) id userInfo;

- (id)initTilesArray:(NSArray *)titles delegate:(id <JSActionSheetViewDelegate>)delegate;
- (void)show;

@end
