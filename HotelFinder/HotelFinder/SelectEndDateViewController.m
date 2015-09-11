//
//  SelectEndDateViewController.m
//  
//
//  Created by Jeffrey Jacka on 9/10/15.
//
//

#import "SelectEndDateViewController.h"
#import "AvaliableRoomsViewController.h"

@interface SelectEndDateViewController ()

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIButton *nextButton;

@end

@implementation SelectEndDateViewController

- (void) loadView {
  
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor greenColor];
  
  //Create Date Picker
  UIDatePicker *datePicker = [[UIDatePicker alloc] init];
  self.datePicker = datePicker;
  [datePicker setTranslatesAutoresizingMaskIntoConstraints:false];
  
  [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
  
  [rootView addSubview:datePicker];
  
  //Constraints for Date Picker
  NSLayoutConstraint *datePickerBottom = [NSLayoutConstraint constraintWithItem:datePicker attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0.0];
  NSLayoutConstraint *dateCenterX = [NSLayoutConstraint constraintWithItem:datePicker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  
  datePickerBottom.active = true;
  dateCenterX.active = true;
  
  //Create Title Label
  UILabel *viewTitleLabel = [[UILabel alloc] init];
  viewTitleLabel.text = @"Ending Reservation Date";
  [viewTitleLabel setTextColor:[UIColor whiteColor]];
  [viewTitleLabel setFont:[UIFont  boldSystemFontOfSize:20]];
  [viewTitleLabel setBackgroundColor:[UIColor blackColor]];
  [viewTitleLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  
  [rootView addSubview:viewTitleLabel];
  
  //Constraints for Label
  NSLayoutConstraint *labelCenterX = [NSLayoutConstraint constraintWithItem:viewTitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:viewTitleLabel attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:80.0];
  
  labelCenterX.active = true;
  labelTopConstraint.active = true;
  
  //Create Next Button
  UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  nextButton.enabled = false;
  self.nextButton = nextButton;
  [nextButton setTitle:@"Next" forState:UIControlStateNormal];
  [nextButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [nextButton addTarget:self action:@selector(nextButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [rootView addSubview:nextButton];
  
  NSLayoutConstraint *nextButtonCenterX = [NSLayoutConstraint constraintWithItem:nextButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  //NSLayoutConstraint *nextButtonBottom = [NSLayoutConstraint constraintWithItem:nextButton attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0.0];
  NSLayoutConstraint *nextButtonCenterY = [NSLayoutConstraint constraintWithItem:nextButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
  
  nextButtonCenterX.active = true;
  nextButtonCenterY.active = true;
  //nextButtonBottom.active = true;
  
  self.view = rootView;
  
}

-(void)checkValidDate{
  
  
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.datePicker.datePickerMode = UIDatePickerModeDate;
  self.dateFormatter = [[NSDateFormatter alloc] init];
}

-(void)datePickerValueChanged:(UIDatePicker *)sender {
  NSLog(@"Start date: %@, End Date: %@", self.startDate, sender.date);
  
  //Found on StackOverflow
  //http://stackoverflow.com/questions/5965044/how-to-compare-two-nsdates-which-is-more-recent
  if ([self.startDate compare:sender.date] == NSOrderedAscending) {
    self.nextButton.enabled = true;
  } else if ([self.startDate  compare:sender.date] == NSOrderedDescending) {
    self.nextButton.enabled = false;
  } else {
    self.nextButton.enabled = false;
  }
}

-(void)nextButtonPressed{
  AvaliableRoomsViewController *destinationVC = [[AvaliableRoomsViewController alloc] init];
  
  destinationVC.startDate = self.startDate;
  destinationVC.endDate = self.datePicker.date;
  
  [self.navigationController pushViewController:destinationVC animated:true];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
