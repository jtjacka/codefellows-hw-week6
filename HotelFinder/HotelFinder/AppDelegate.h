//
//  AppDelegate.h
//  HotelFinder
//
//  Created by Jeffrey Jacka on 9/7/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoreDataStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CoreDataStack *coreDataStack;

@end

