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

@interface HoteListViewController ()

@property (strong, nonatomic) NSArray *hotels;

@end

@implementation HoteListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
  //Fetch Stored Data
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  NSManagedObjectContext* context = appDelegate.managedObjectContext;
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
  self.hotels = [context executeFetchRequest:fetchRequest error:&fetchError];
  
  
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  
  tableView = [[UITableView alloc]init];
  tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
  
  //Is this proper syntax?
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


#pragma mark - Navigation




@end
