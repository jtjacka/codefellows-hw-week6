//
//  Reservation.h
//  
//
//  Created by Jeffrey Jacka on 9/8/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Room *room;
@property (nonatomic, retain) Guest *guest;

@end
