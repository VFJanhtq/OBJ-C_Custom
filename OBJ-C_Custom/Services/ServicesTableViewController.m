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
#import "ActivityIndicatorHeaderFooterView.h"

@interface ServicesTableViewController ()
@property (nonatomic, assign) NSInteger displayedItemCount;
@property (nonatomic, assign) NSInteger totalItemCount;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isLoadingMoreData;
@property (nonatomic, assign) NSInteger numberOfAdditionalCells;
@property (nonatomic, assign) NSInteger currentCellCount;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) BOOL isLoadingMore;
@end

@implementation ServicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *xib = [UINib nibWithNibName:@"ActivityIndicatorHeaderFooterView" bundle:nil];
    [self.tableView registerNib:xib forHeaderFooterViewReuseIdentifier:@"ActivityIndicatorHeaderFooterView"];
    // pull to refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
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
    
//    [self.tableView reloadData];
}

#pragma mark - Pull to refresh

- (void)handleRefresh:(UIRefreshControl *)refreshControl {
    double delayInSeconds = 2.0;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    // Tạo một độ trễ 2 giây
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        // Gọi phương thức refreshData hoặc thực hiện công việc lấy dữ liệu ở đây
        [self refreshData];
        
        // Kết thúc quá trình làm mới của self.tableView.refreshControl
        [refreshControl endRefreshing];
        
        // Reload table view hoặc cập nhật giao diện tại đây
    });
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
    NSLog(@"Anndy, loadMoreData!");
    // Thực hiện công việc khi kéo xuống cuối cùng
//    self.currentCellCount += 6;
//    [self.tableView reloadData];
    // Khi công việc hoàn thành, dừng hiển thị activityIndicator
//    [self stopActivityIndicator];
}





// loading more data
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat scrollViewHeight = scrollView.bounds.size.height;
    
    if (offsetY >= contentHeight - scrollViewHeight) {
        // Hiển thị UIActivityIndicatorView
        dispatch_async(
            dispatch_get_main_queue(),
            ^{
                [self.activityIndicator startAnimating];
                
            }
        );
        
        
        // Thực hiện công việc khi kéo xuống cuối cùng
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
    
   if (self.generateRandomNumber % 2 == 0) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell" forIndexPath:indexPath];
        // Configure the cell...
        cell.firstText.text = dict[@"Description"];
        cell.firstLabel.text = dict[@"Title"];
        
        return cell;
    } else {
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell" forIndexPath:indexPath];
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
