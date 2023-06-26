//
//  SecondDetailViewController.h
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondDetailViewController : UIViewController

@property(strong, nonatomic) NSArray *detailModal;

@property (weak, nonatomic) IBOutlet UIImageView *secondDTImage;
@property (weak, nonatomic) IBOutlet UILabel *secondDTLabel;
@property (weak, nonatomic) IBOutlet UITextView *secondDTText;

@end

NS_ASSUME_NONNULL_END
