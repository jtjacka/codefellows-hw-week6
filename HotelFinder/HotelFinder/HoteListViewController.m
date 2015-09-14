//
//  HoteListViewController.m
//  
//
//  Created by Jeffrey Jacka on 9/7/15.
//
//

#import "HoteListViewController.h"
#import "Hotel.h"
#import "AppDelegate.h"
#import "RoomListViewController.h"
#import "CoreDataStack.h"
#import <Google/Analytics.h>

@interface HoteListViewController ()

@property (strong, nonatomic) NSArray *hotels;

@end

@implementation HoteListViewController

-(void)viewDidAppear:(BOOL)animated {
  id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
  [tracker set:kGAIScreenName value:@"Hotel List"];
  [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
  //Fetch Stored Data
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
 self.hotels = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  
  
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  
  tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
  
  tableView.dataSource = self;
  tableView.delegate = self;
  
  [tableView reloadData];
  
  self.view = rootView;
  [self.view addSubview:tableView];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotels.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  Hotel *currentHotel = self.hotels[indexPath.row];
  
  cell.textLabel.text = currentHotel.name;
  
  return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  RoomListViewController *destinationVC = [[RoomListViewController alloc] init];
  
  destinationVC.currentHotel = self.hotels[indexPath.row];
  
  [self.navigationController pushViewController:destinationVC animated:true];
}


@end
