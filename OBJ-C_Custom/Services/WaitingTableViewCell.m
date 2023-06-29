//
//  WaitingTableViewCell.m
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/25.
//

#import "WaitingTableViewCell.h"

@implementation WaitingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        self.activityIndicator.hidesWhenStopped = YES;
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.activityIndicator];

        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                                             attribute:NSLayoutAttributeCenterX
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.contentView
                                                                             attribute:NSLayoutAttributeCenterX
                                                                            multiplier:1.0
                                                                              constant:0.0];
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                                             attribute:NSLayoutAttributeCenterY
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.contentView
                                                                             attribute:NSLayoutAttributeCenterY
                                                                            multiplier:1.0
                                                                              constant:0.0];
        [self.contentView addConstraints:@[centerXConstraint, centerYConstraint]];
    }
    return self;
}

@end
