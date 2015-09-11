//
//  RoomListViewController.m
//  
//
//  Created by Jeffrey Jacka on 9/8/15.
//
//

#import "RoomListViewController.h"
#import "AppDelegate.h"
#import "Room.h"

@interface RoomListViewController ()

@property (strong, nonatomic) UIView *rootView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *rooms;

@end

@implementation RoomListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  self.rooms = [self.currentHotel.rooms allObjects];
  
  self.rootView = [[UIView alloc] init];
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  [self.tableView reloadData];
  
  self.view = self.rootView;
  [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.rooms.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  Room *currentRoom = self.rooms[indexPath.row];

  cell.textLabel.text = [currentRoom.number stringValue];
  
  return cell;
}


@end
