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
  
  return [[NSArray alloc] init];
}

@end
