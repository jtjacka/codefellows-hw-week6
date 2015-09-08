//
//  Hotel.h
//  
//
//  Created by Jeffrey Jacka on 9/8/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room;

@interface Hotel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * stars;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) Room *room;

@end
