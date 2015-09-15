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

@interface AvaliableRoomsViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *availableRooms;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

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
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
  NSError *error;
  if (![[self fetchedResultsController] performFetch:&error]) {
    // Update to handle the error appropriately.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    exit(-1);  // Fail
  }
  
  self.title = @"Available Rooms";

  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    // Do any additional setup after loading the view.
}

//Ray Wenderlich Tutorial: NSFetchedResultsController
//http://www.raywenderlich.com/999/core-data-tutorial-for-ios-how-to-use-nsfetchedresultscontroller
- (NSFetchedResultsController *)fetchedResultsController {
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  if (_fetchedResultsController != nil) {
    return _fetchedResultsController;
  }
  
  //Logic copied from AvaliableRoomService
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, self.startDate];
  
  request.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  NSMutableArray *reservedRooms = [[NSMutableArray alloc] init];
  for (Reservation *reservation in results) {
    [reservedRooms addObject:reservation.room];
  }
  
  NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", reservedRooms];
  finalRequest.predicate = finalPredicate;
  
  NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
  [finalRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
  
  [finalRequest setFetchBatchSize:100];
  
  NSFetchedResultsController *theFetchedResultsController =
  [[NSFetchedResultsController alloc] initWithFetchRequest:finalRequest
                                      managedObjectContext:appDelegate.coreDataStack.managedObjectContext sectionNameKeyPath:@"hotel.name"
                                                 cacheName:nil];
  self.fetchedResultsController = theFetchedResultsController;
  _fetchedResultsController.delegate = self;
  
  return _fetchedResultsController;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return _fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  id  sectionInfo =
  [[_fetchedResultsController sections] objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  
  Room *avaliableRoom = [_fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = [avaliableRoom.number stringValue];
  
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  [self configureCell:cell atIndexPath:indexPath];
  
  return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
  NSArray *objects = [sectionInfo objects];
  Room *managedObject = [objects objectAtIndex:0];
  
  NSString *hotelName = managedObject.hotel.name;
  
  return hotelName;
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

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
  [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  
  UITableView *tableView = self.tableView;
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
      
    case NSFetchedResultsChangeMove:
      [tableView deleteRowsAtIndexPaths:[NSArray
                                         arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [tableView insertRowsAtIndexPaths:[NSArray
                                         arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
  [self.tableView endUpdates];
}

@end
