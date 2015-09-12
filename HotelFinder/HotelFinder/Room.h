//
//  Room.h
//  HotelFinder
//
//  Created by Jeff Jacka on 9/11/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) Hotel *hotel;
@property (nonatomic, retain) Reservation *reservation;

@end
