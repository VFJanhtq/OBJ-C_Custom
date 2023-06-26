//
//  ServicesTableViewController.m
//  OBJ-C_Custom
//
//  Created by anhtq on R 5/06/19.
//

#import "ServicesTableViewController.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "SecondDetailViewController.h"
#import "WaitingTableViewCell.h"

@interface ServicesTableViewController ()
@property (nonatomic, assign) NSInteger displayedItemCount;
@property (nonatomic, assign) NSInteger totalItemCount;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isLoadingMoreData;
@property (nonatomic, assign) NSInteger numberOfAdditionalCells;
@property (nonatomic, assign) NSInteger currentCellCount;

@end

@implementation ServicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // pull to refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.tableView.rowHeight = 100;
    
    // get data with split file.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Landmarks" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    dataArray = dict[@"Places"];
    
    //
    [[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    // delegate
    self.tableView.delegate = self;
    
    
    self.displayedItemCount = 10;
    self.totalItemCount = dataArray.count;
    self.isLoading = NO;
    
    [self.tableView reloadData];
}

#pragma mark - Pull to refresh

- (void)handleRefresh:(UIRefreshControl *)refreshControl {
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1.0];
    [refreshControl endRefreshing];
}

- (void)refreshData {
    [self.tableView reloadData];
    // refresh data in UITableView
    // fetch data
    // Once done,call endRefreshing to end the refresh:
    [self.tableView.refreshControl endRefreshing];
}

#pragma mark - Load more data
- (void)loadMoreData {
    self.currentCellCount += 6;
    [self.tableView reloadData];
}

// loading more data
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat scrollViewHeight = scrollView.frame.size.height;
    
    if (offsetY >= contentHeight - scrollViewHeight) {
        [self loadMoreData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger dataCount = dataArray.count;
    NSInteger totalCellCount = dataCount + self.currentCellCount;
    
    return totalCellCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = dataArray[indexPath.row % dataArray.count];
    
    if (self.refreshControl.refreshing) {
        WaitingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaitingCell" forIndexPath:indexPath];
        NSLog(@"Hello, WaitingTableViewCell!");
        // Start or stop animation based on the display status
        if (cell.waitingCell.isAnimating) {
            [cell.waitingCell stopAnimating];
        } else {
            UIImage *image1 = [UIImage imageNamed:@"image1"];
            UIImage *image2 = [UIImage imageNamed:@"image2"];
            UIImage *image3 = [UIImage imageNamed:@"image3"];
            
            cell.waitingCell.animationImages = @[image1, image2, image3]; // Set the animation images
            cell.waitingCell.animationDuration = 1.0; // Set the animation duration
            cell.waitingCell.animationRepeatCount = 0; // Set the repeat count
            [cell.waitingCell startAnimating];
        }
        
        return cell;
    } else if (self.generateRandomNumber % 2 == 0) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell" forIndexPath:indexPath];
        NSLog(@"Hello, FirstTableViewCell!"); // In ra thông điệp "Hello, world!"
        // Configure the cell...
        cell.firstText.text = dict[@"Description"];
        cell.firstLabel.text = dict[@"Title"];
        
        return cell;
    } else {
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell" forIndexPath:indexPath];
        NSLog(@"Hello, SecondTableViewCell!"); // In ra thông điệp "Hello, world!"
        // Configure the cell...
        cell.secondLabel.text = dict[@"Title"];
        cell.secondText.text = dict[@"Description"];
        cell.secondImage.image = [UIImage imageNamed:dict[@"Image"]];
        return cell;
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableView.estimatedRowHeight = 200;
    return UITableViewAutomaticDimension;
}

- (NSInteger)generateRandomNumber {
    NSUInteger randomNumber = arc4random_uniform(6) + 1;
    return randomNumber;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        SecondDetailViewController *detailView = [segue destinationViewController];
        NSIndexPath *myIndexpath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *dict = dataArray[myIndexpath.row];
        
        detailView.detailModal = @[dict[@"Title"],
                                   dict[@"Address"],
                                   dict[@"Image"],
                                   dict[@"Description"],
                                   dict[@"Latitude"],
                                   dict[@"Longitude"]];
        
        
    }
    
    
}

@end
