//
//  SecondTableViewCell.h
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondText;

@end

NS_ASSUME_NONNULL_END
