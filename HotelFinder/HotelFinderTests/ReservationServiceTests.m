//
//  ReservationServiceTests.m
//  
//
//  Created by Jeffrey Jacka on 9/14/15.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ReservationService.h"

@interface ReservationServiceTests : XCTestCase

@end

@implementation ReservationServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

-(void)testAvailableRoomsForNilDates {
  NSArray *results = [ReservationService avaliableRoomsForStartDate:nil endDate:nil];
  XCTAssertNotNil(results);
  XCTAssertEqual(0, results.count,@"Results should be equal to zero");
}

@end
