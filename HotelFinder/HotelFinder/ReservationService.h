//
//  ReservationService.h
//  
//
//  Created by Jeffrey Jacka on 9/10/15.
//
//

#import <Foundation/Foundation.h>

@interface ReservationService : NSObject

+ (NSArray *)avaliableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
