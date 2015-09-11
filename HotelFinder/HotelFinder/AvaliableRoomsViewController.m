//
//  AvaliableRoomsViewController.m
//  
//
//  Created by Jeffrey Jacka on 9/10/15.
//
//

#import "AvaliableRoomsViewController.h"
#import "ReservationService.h"
#import "Room.h"

@interface AvaliableRoomsViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *availableRooms;

@end

@implementation AvaliableRoomsViewController

-(void) loadView {
  
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  self.tableView = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView];
  
  self.availableRooms = [ReservationService avaliableRoomsForStartDate:self.startDate endDate:self.endDate];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  [tableView reloadData];
  
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  

  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.availableRooms.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  Room *avaliableRoom = self.availableRooms[indexPath.row];
  
  cell.textLabel.text = [avaliableRoom.number stringValue];
  
  return cell;
}

@end
