//
//  CoreDataStack.h
//  
//
//  Created by Jeffrey Jacka on 9/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Reservation.h"
#import "Guest.h"

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(Reservation *)createNewReservation;
-(Guest *)createNewGuest;
-(BOOL) saveCompleteReservation:(Reservation *)reservation guestInfo:(Guest *)guest;

@end
