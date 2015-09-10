//
//  RoomListViewController.h
//  
//
//  Created by Jeffrey Jacka on 9/8/15.
//
//

#import <UIKit/UIKit.h>
#import "Hotel.h"

@interface RoomListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Hotel *currentHotel;

@end
