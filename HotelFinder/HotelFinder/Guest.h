//
//  Guest.h
//  
//
//  Created by Jeffrey Jacka on 9/8/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Guest : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *reservation;

@end
