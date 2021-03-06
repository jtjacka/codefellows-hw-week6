//
//  MainMenuViewController.m
//  
//
//  Created by Jeffrey Jacka on 9/9/15.
//
//

#import "MainMenuViewController.h"
#import "HoteListViewController.h"
#import "BookRoomViewController.h"
#import "ReservationLookupViewController.h"
#import <Google/Analytics.h>

@interface MainMenuViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *menuTitles;

@end

@implementation MainMenuViewController

-(void)loadView {
    UIView *rootView = [[UIView alloc] init];
  
    self.menuTitles = @[NSLocalizedString(@"Browse Hotels", "Browse for a hotel"), NSLocalizedString(@"Book A Room", "Search for avaliable rooms to reserve"), NSLocalizedString(@"Look Up Reservation", "Look up a reservation previously made through the app.")];
    
    self.tableView = [[UITableView alloc] initWithFrame:rootView.frame style:UITableViewStylePlain];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
    [rootView addSubview:self.tableView];
    
    //Add Constraints to Table View
    NSDictionary *views = @{@"tableView" : self.tableView};
    NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
    [rootView addConstraints:tableViewVerticalConstraints];
    NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
    [rootView addConstraints:tableViewHorizontalConstraints];
    
    self.view = rootView;
}

-(void)viewDidAppear:(BOOL)animated {
  id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
  [tracker set:kGAIScreenName value:@"Main Menu"];
  [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
        self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *title = self.menuTitles[indexPath.row];
    
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *currentTitle = self.menuTitles[indexPath.row];
    
    if ([currentTitle isEqualToString:@"Browse Hotels"]) {
        HoteListViewController *destinationVC = [[HoteListViewController alloc] init];
        
        [self.navigationController pushViewController:destinationVC animated:true];
    }
    
    if ([currentTitle isEqualToString:@"Book A Room"]) {
        BookRoomViewController *destinationVC = [[BookRoomViewController alloc] init];
        
        [self.navigationController pushViewController:destinationVC animated:true];
    }
    
    if ([currentTitle isEqualToString:@"Look Up Reservation"]) {
        ReservationLookupViewController *destinationVC = [[ReservationLookupViewController alloc] init];
        
        [self.navigationController pushViewController:destinationVC animated:true];
    }
    
}

@end
