//
//  Room.h
//  
//
//  Created by Jeffrey Jacka on 9/8/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) Hotel *hotel;
@property (nonatomic, retain) Reservation *reservation;

@end
