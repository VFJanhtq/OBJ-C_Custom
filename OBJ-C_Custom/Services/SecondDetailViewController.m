//
//  SecondDetailViewController.m
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/19.
//

#import "SecondDetailViewController.h"

@interface SecondDetailViewController ()

@end

@implementation SecondDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.detailModal[0];
    
    self.secondDTLabel.text = self.detailModal[0];
    self.secondDTText.text = self.detailModal[3];
    self.secondDTImage.image = [UIImage imageNamed:self.detailModal[2]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
