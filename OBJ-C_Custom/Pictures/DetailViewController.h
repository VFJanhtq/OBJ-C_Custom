//
//  DetailViewController.h
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (strong, nonatomic) NSString *detail;
@end

NS_ASSUME_NONNULL_END
