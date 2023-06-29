//
//  CollectionViewCell.m
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/19.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Khởi tạo UIImageView và thiết lập các thuộc tính cần thiết
        self.cellImage = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.cellImage.contentMode = UIViewContentModeScaleAspectFit;
        
        // Thêm UIImageView vào contentView của cell
        [self.contentView addSubview:self.cellImage];
    }
    return self;
}
@end
