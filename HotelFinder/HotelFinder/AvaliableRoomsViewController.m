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
#import "CoreDataStack.h"
#import "AppDelegate.h"
#import "Hotel.h"

@interface AvaliableRoomsViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *availableRooms;
@property (strong, nonatomic) NSArray *hotels;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation AvaliableRoomsViewController

@synthesize fetchedResultsController = _fetchedResultsController;

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
  [self retrieveHotelsFromReservation];
  
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

-(void)retrieveHotelsFromReservation {
  self.hotels = [self.availableRooms valueForKeyPath:@"@distinctUnionOfObjects.hotel"];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  return self.hotels.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  Hotel  *currentHotel = self.hotels[section];
  
  return currentHotel.name;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  Hotel  *currentHotel = self.hotels[section];
  NSMutableArray *roomsInSection = [[NSMutableArray alloc] init];
  
  for (Room *index in self.availableRooms) {
    if([currentHotel isEqual:index.hotel]) {
      [roomsInSection addObject:index];
    }
  }
  
  return roomsInSection.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  Room *avaliableRoom = self.availableRooms[indexPath.row];
  
  cell.textLabel.text = [avaliableRoom.number stringValue];
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ConfirmReservationViewController *destinationVC = [[ConfirmReservationViewController alloc] init];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  Room *selectedRoom = self.availableRooms[indexPath.row];
  
    Reservation *newReservation = appDelegate.coreDataStack.createNewReservation;
    
  [newReservation setStartDate:self.startDate];
  [newReservation setEndDate:self.endDate];
  [newReservation setRoom:selectedRoom];
  
  destinationVC.currentReservation = newReservation;
  
  [self.navigationController pushViewController:destinationVC animated:true];
  
}

@end
