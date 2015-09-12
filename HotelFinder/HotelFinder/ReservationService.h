//
//  ReservationService.h
//  
//
//  Created by Jeffrey Jacka on 9/10/15.
//
//

#import <Foundation/Foundation.h>
#import "Reservation.h"

@interface ReservationService : NSObject

+ (NSArray *)avaliableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (BOOL) saveReservation:(Reservation *)newReservation reservationGuestFirstName:(NSString *)firstName reservationLastName:(NSString *)lastName;


@end
