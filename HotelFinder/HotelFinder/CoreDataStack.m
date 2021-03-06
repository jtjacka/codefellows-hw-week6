//
//  CoreDataStack.m
//  
//
//  Created by Jeffrey Jacka on 9/9/15.
//
//

#import "CoreDataStack.h"
#import "Hotel.h"
#import "Room.h"

@interface CoreDataStack()

@property (nonatomic) BOOL testing;

@end


@implementation CoreDataStack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Core Data Stack
- (instancetype)init {
    self = [super init];
    if (self) {
        [self seedCoreDataIfNeeded];
    }
    return self;
}

#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "JeffJacka.HotelFinder" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HotelFinder" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HotelFinder.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Create New Reservation
-(Reservation *)createNewReservation {
    Reservation *newReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.managedObjectContext];
    
    return newReservation;
}

#pragma mark - Create New Guest
-(Guest *)createNewGuest {
    Guest *newGuest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.managedObjectContext];
    
    return newGuest;
}

-(BOOL) saveCompleteReservation:(Reservation *)reservation guestInfo:(Guest *)guest {
    
    guest.reservation = reservation;
    reservation.guest = guest;
    
    NSLog(@"Reservation to be saved: %@", reservation);
    NSLog(@"Guest to be saved %@" , guest);
    
    NSError *reservationError;
    BOOL reservationResult = [self.managedObjectContext save:&reservationError];
    
    NSError *guestError;
    BOOL guestResult = [self.managedObjectContext save:&guestError];
    
    if(reservationResult && guestResult) {
        return TRUE;
    } else {
        return FALSE;
    }
}

#pragma mark - Seed Core Data If Needed
-(void) seedCoreDataIfNeeded {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    NSError *fetchError;
    NSInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
    
    if (count == 0) {
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"hotels" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        
        NSError *jsonError;
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        
        if (jsonError) {
            return;
        }
        
        if([rootObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *hotels = rootObject[@"Hotels"];
            
            for (id hotel in hotels) {
                Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
                newHotel.name = hotel[@"name"];
                newHotel.location = hotel[@"location"];
                newHotel.stars = hotel[@"stars"];
                
                NSDictionary *rooms = hotel[@"rooms"];
                
                for (id room in rooms) {
                    Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
                    
                    newRoom.number = room[@"number"];
                    newRoom.beds = room[@"beds"];
                    newRoom.rate = room[@"rate"];
                    newRoom.hotel = newHotel;
                    
                    //Save Room
                    NSError *saveRoomError;
                    BOOL roomResult = [self.managedObjectContext save:&saveRoomError];
                    if (!roomResult) {
                        NSLog(@" %@",saveRoomError.localizedDescription);
                    }
                    [newHotel addRoomsObject:newRoom];
                }
                
                //Save Hotel
                NSError *saveHotelError;
                BOOL hotelResult = [self.managedObjectContext save:&saveHotelError];
                if (!hotelResult) {
                    NSLog(@" %@",saveHotelError.localizedDescription);
                }
            }
        }
    }
}

@end
