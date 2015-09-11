//
//  ReservationService.m
//  
//
//  Created by Jeffrey Jacka on 9/10/15.
//
//

#import "ReservationService.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Reservation.h"

@implementation ReservationService

+ (NSArray *)avaliableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  
  if (!startDate || !endDate) {
    return [[NSArray alloc] init];
  }
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
  
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
    
    NSError *finalError;
    NSArray *finalResults = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:finalRequest error:&finalError];
    
    if (finalError) {
        return nil;
    }
  
    return finalResults;
}

@end
