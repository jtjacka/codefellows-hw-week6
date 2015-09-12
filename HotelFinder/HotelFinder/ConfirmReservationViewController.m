//
//  ConfirmReservationViewController.m
//  
//
//  Created by Jeffrey Jacka on 9/11/15.
//
//

#import "ConfirmReservationViewController.h"
#import "Room.h"
#import "Hotel.h"
#import "AppDelegate.h"
#import "Guest.h"

@interface ConfirmReservationViewController ()

@property (strong, nonatomic) UITextField *firstNameField;
@property (strong, nonatomic) UITextField *lastNameField;

@end

@implementation ConfirmReservationViewController

- (void) loadView {
  
  UIView *rootView = [[UIView alloc] init];
    rootView.backgroundColor = [UIColor purpleColor];
    
    
    UIButton *submitReservation = [[UIButton alloc] init];
    [submitReservation setTitle:@"Submit" forState:UIControlStateNormal];
    [rootView addSubview:submitReservation];
    [submitReservation setTranslatesAutoresizingMaskIntoConstraints:false];
    [submitReservation addTarget:self action:@selector(submitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *views = @{@"submitReservation" : submitReservation};
    
    NSArray *submitVerticalContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[submitReservation]-|" options:0 metrics:nil views:views];
    [rootView addConstraints:submitVerticalContraints];
    
    NSLayoutConstraint *submitCenterX = [NSLayoutConstraint constraintWithItem:submitReservation attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    submitCenterX.active = true;
    
    UILabel *viewTitle = [[UILabel alloc] init];
    [viewTitle setText:@"Reservation Details"];
    [viewTitle setTranslatesAutoresizingMaskIntoConstraints:false];
    [rootView addSubview:viewTitle];
    
    UILabel *hotelName = [[UILabel alloc] init];
    [hotelName setText:[NSString stringWithFormat:@"Hotel Rating: %@", self.currentReservation.room.hotel.name]];
    [rootView addSubview:hotelName];
    [hotelName setTranslatesAutoresizingMaskIntoConstraints:false];
    
    UILabel *hotelRating = [[UILabel alloc] init];
    [hotelRating setText:[NSString stringWithFormat:@"Hotel Rating: %@", self.currentReservation.room.hotel.stars]];
    [rootView addSubview:hotelRating];
    [hotelRating setTranslatesAutoresizingMaskIntoConstraints:false];
    
    UILabel *hotelLocation = [[UILabel alloc] init];
    [hotelLocation setText:[NSString stringWithFormat:@"Location: %@", self.currentReservation.room.hotel.location]];
    [rootView addSubview:hotelLocation];
    [hotelLocation setTranslatesAutoresizingMaskIntoConstraints:false];
    
    UILabel *reservationStartDate = [[UILabel alloc] init];
    [reservationStartDate setText:[NSString stringWithFormat:@"Reservation State Date: %@", self.currentReservation.startDate]];
    [rootView addSubview:reservationStartDate];
    [reservationStartDate setTranslatesAutoresizingMaskIntoConstraints:false];
    
    UILabel *reservationEndDate = [[UILabel alloc] init];
    [reservationEndDate setText:[NSString stringWithFormat:@"Reservation End Date: %@", self.currentReservation.endDate]];
    [rootView addSubview:reservationEndDate];
    [reservationEndDate setTranslatesAutoresizingMaskIntoConstraints:false];
    
    UITextField *firstNameField = [[UITextField alloc] init];
    [firstNameField setPlaceholder:@"First Name"];
    self.firstNameField = firstNameField;
    [firstNameField setTranslatesAutoresizingMaskIntoConstraints:false];
    [rootView addSubview:firstNameField];
    
    UITextField *lastNameField = [[UITextField alloc] init];
    [lastNameField setPlaceholder:@"Last Name"];
    self.lastNameField = firstNameField;
    [lastNameField setTranslatesAutoresizingMaskIntoConstraints:false];
    [rootView addSubview:lastNameField];
    
    NSDictionary *labelViews = @{@"viewTitle" : viewTitle,
                                 @"hotelName" : hotelName,
                                 @"hotelRating": hotelRating,
                                 @"hotelLocation" : hotelLocation,
                                 @"reservationStartDate" : reservationStartDate,
                                 @"reservationEndDate" : reservationEndDate,
                                 @"firstNameField" : firstNameField,
                                 @"lastNameField" : lastNameField};
    
    NSArray *labelViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[viewTitle]-[hotelName]-[hotelRating]-[hotelLocation]-[reservationStartDate]-[reservationEndDate]-[firstNameField]-[lastNameField]" options:0 metrics:nil views:labelViews];
    
    [rootView addConstraints:labelViewConstraints];
    
    self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) submitButtonPressed {
    BOOL results =  [ReservationService saveReservation:self.currentReservation reservationGuestFirstName:self.firstNameField.text reservationLastName:self.lastNameField.text];
    
    if(results) {
        [self.navigationController popToRootViewControllerAnimated:true];
    }
    
}

@end
