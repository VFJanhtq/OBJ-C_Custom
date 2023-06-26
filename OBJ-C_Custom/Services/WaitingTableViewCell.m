//
//  WaitingTableViewCell.m
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/25.
//

#import "WaitingTableViewCell.h"

@implementation WaitingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.waitingCell = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.waitingCell.center = self.contentView.center;
        [self.contentView addSubview:self.waitingCell];
    }
    return self;
}


@end
