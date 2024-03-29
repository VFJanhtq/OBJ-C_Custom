//
//  CollectionViewController.m
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/19.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"

@interface CollectionViewController ()
@property (nonatomic, assign) NSInteger currentItemCount;
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) NSInteger spacingBetweenItems;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // column in view
    self.spacingBetweenItems = 10;
    self.numberOfColumns = 3;
    self.currentItemCount = 6;
    imageArray = @[@"Image1",
                   @"Image2",
                   @"Image3",
                   @"Image4",
                   @"Image5",
                   @"Image6"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"Current Item Count: %ld", (long)self.currentItemCount);
    return self.currentItemCount;
    
}

- (void)loadMoreData {
    self.currentItemCount += 6;
    
    [self.collectionView reloadData];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat numberOfColumns = self.numberOfColumns; // column
    CGFloat spacingBetweenItems = self.spacingBetweenItems; // space in cell
    CGFloat totalSpacing = (numberOfColumns - 1) * spacingBetweenItems;
    CGFloat itemWidth = (collectionView.bounds.size.width - totalSpacing) / numberOfColumns;
    
    return CGSizeMake(itemWidth, itemWidth);
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        DetailViewController *detailView = [segue destinationViewController];
        NSArray *arrayIndexPath = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [arrayIndexPath firstObject];
        
        int row = (int)[indexPath row];
        detailView.detail = imageArray[row];
        
    }
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *imageName = imageArray[indexPath.row];
    cell.cellImage.image = [UIImage imageNamed:imageName];
    
    return cell;
    
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

@end
