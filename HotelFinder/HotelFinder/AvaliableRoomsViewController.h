//
//  AvaliableRoomsViewController.h
//  
//
//  Created by Jeffrey Jacka on 9/10/15.
//
//

#import <UIKit/UIKit.h>

@interface AvaliableRoomsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end
