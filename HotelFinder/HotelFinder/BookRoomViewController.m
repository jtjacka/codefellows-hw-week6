//
//  BookRoomViewController.m
//  HotelFinder
//
//  Created by Jeff Jacka on 9/9/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

#import "BookRoomViewController.h"

@interface BookRoomViewController ()

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation BookRoomViewController

-(void) loadView {
  
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor blueColor];
  
  //Create Date Picker
  UIDatePicker *datePicker = [[UIDatePicker alloc] init];
  self.datePicker = datePicker;
  [datePicker setTranslatesAutoresizingMaskIntoConstraints:false];
  
    [rootView addSubview:datePicker];
  
  //Constraints for Date Picker
  NSLayoutConstraint *datePickerBottom = [NSLayoutConstraint constraintWithItem:datePicker attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0.0];
  NSLayoutConstraint *dateCenterX = [NSLayoutConstraint constraintWithItem:datePicker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  
  datePickerBottom.active = true;
  dateCenterX.active = true;
  
  UILabel *viewLabel = [[UILabel alloc] init];
  viewLabel.text = @"Starting reservation date";
  [viewLabel setTextColor:[UIColor whiteColor]];
  [viewLabel setFont:[UIFont  boldSystemFontOfSize:20]];
  [viewLabel setBackgroundColor:[UIColor blackColor]];
  [viewLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  
  [rootView addSubview:viewLabel];
  [rootView bringSubviewToFront:viewLabel];
  
  //Constraints for Label
  NSLayoutConstraint *labelCenterX = [NSLayoutConstraint constraintWithItem:viewLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:viewLabel attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:80.0];
  
  labelCenterX.active = true;
  labelTopConstraint.active = true;
  
  
  self.view = rootView;

  
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.datePicker.datePickerMode = UIDatePickerModeDate;
  self.dateFormatter = [[NSDateFormatter alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
