//
//  ViewController.m
//  HotelFinder
//
//  Created by Jeffrey Jacka on 9/7/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void) loadView {
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  [redView setTranslatesAutoresizingMaskIntoConstraints:false];
  redView.backgroundColor = [UIColor greenColor];
  [rootView addSubview:redView];
  
  UILabel *blueLabel = [[UILabel alloc] init];
  blueLabel.text = @"Blue Label";
  blueLabel.textColor = [UIColor blueColor];
  [blueLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:blueLabel];
  
  NSDictionary *views = @{@"redView" : redView, @"blueLabel" : blueLabel};
  
  //Create Constraints
  NSArray *redViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[redView]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:redViewHorizontalConstraints];
  
  NSArray *redViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[redView]-100-|" options:0 metrics:nil views:views];
  [rootView addConstraints:redViewVerticalConstraints];
  
  NSArray *blueLabelVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[redView]-[blueLabel]" options:0 metrics:nil views:views];
  [rootView addConstraints:blueLabelVerticalConstraints];
  
  NSLayoutConstraint *blueLabelCenterXConstaint = [NSLayoutConstraint constraintWithItem:blueLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  blueLabelCenterXConstaint.active = true;
  
  
  
  self.view = rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Constraints



@end
