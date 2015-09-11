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
#import "ConfirmReservationViewController.h"
#import "Reservation.h"

@interface AvaliableRoomsViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *availableRooms;

@end

@implementation AvaliableRoomsViewController

-(void) loadView {
  
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor purpleColor];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:rootView.frame style:UITableViewStylePlain];
  self.tableView = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView];
  
  NSDictionary *views = @{@"tableView" : tableView};
  
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVerticalConstraints];
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontalConstraints];
  
  self.availableRooms = [ReservationService avaliableRoomsForStartDate:self.startDate endDate:self.endDate];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ConfirmReservationViewController *destinationVC = [[ConfirmReservationViewController alloc] init];
  
  Room *selectedRoom = self.availableRooms[indexPath.row];
  
  Reservation *newReservation = [[Reservation alloc] init];
  [newReservation setStartDate:self.startDate];
  [newReservation setEndDate:self.endDate];
  [newReservation setRoom:selectedRoom];
  
  destinationVC.newReservation = newReservation;
  
  [self.navigationController pushViewController:destinationVC animated:true];
  
}

@end
