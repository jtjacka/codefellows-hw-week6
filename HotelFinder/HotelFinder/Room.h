//
//  Room.h
//  
//
//  Created by Jeffrey Jacka on 9/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) Hotel *hotel;
@property (nonatomic, retain) NSOrderedSet *reservation;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)insertObject:(Reservation *)value inReservationAtIndex:(NSUInteger)idx;
- (void)removeObjectFromReservationAtIndex:(NSUInteger)idx;
- (void)insertReservation:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeReservationAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInReservationAtIndex:(NSUInteger)idx withObject:(Reservation *)value;
- (void)replaceReservationAtIndexes:(NSIndexSet *)indexes withReservation:(NSArray *)values;
- (void)addReservationObject:(Reservation *)value;
- (void)removeReservationObject:(Reservation *)value;
- (void)addReservation:(NSOrderedSet *)values;
- (void)removeReservation:(NSOrderedSet *)values;
@end
