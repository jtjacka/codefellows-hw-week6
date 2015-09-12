//
//  ConfirmReservationViewController.h
//  
//
//  Created by Jeffrey Jacka on 9/11/15.
//
//

#import <UIKit/UIKit.h>
#import "Reservation.h"
#import "ReservationService.h"

@interface ConfirmReservationViewController : UIViewController

@property (strong, nonatomic) Reservation *currentReservation;
@property (strong, nonatomic) ReservationService *reservationService;

@end
