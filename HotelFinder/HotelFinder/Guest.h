//
//  Guest.h
//  HotelFinder
//
//  Created by Jeff Jacka on 9/11/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reservation;

@interface Guest : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) Reservation *reservation;

@end
