//
//  PhotoBrowserUITests.m
//  PhotoBrowserUITests
//
//  Created by Sowmya Srinivasan on 07/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkLayer.h"

@interface PhotoBrowserUITests : XCTestCase
@property NetworkLayer * networkLayer;
@property NSString * urlString1;
@property NSString * urlString2;

@end

@implementation PhotoBrowserUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _networkLayer = [[NetworkLayer alloc] init];
    _urlString1 = @"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg";
    _urlString1 = @"http://www.donegalhimalayans.com/images/That%20fish%20was%20this%20big.jpg";
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
   
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void) testDataDownload {
    [_networkLayer downloadDatacompletionBlock:^(BOOL succeeded, NSString * title, NSArray *details){
        XCTAssertTrue(succeeded,"Data Download Success");
        [[[XCUIApplication alloc] init].alerts[@"Network Error"].buttons[@"Ok"] tap];
                        XCTAssertTrue(!succeeded,"Data Download failed");

    }];
}

- (void) testImageDownload1 {
    [_networkLayer downloadImage:_urlString1 completionBlock:^(BOOL succeeded, UIImage *image) {
        XCTAssertTrue(succeeded,"Image Download Success");
        XCTAssertTrue(!succeeded,"Image Download Failed");

    }];
    
    [_networkLayer downloadImage:_urlString2 completionBlock:^(BOOL succeeded, UIImage *image) {
        XCTAssertTrue(succeeded,"Image Download Success");
        XCTAssertTrue(!succeeded,"Image Download Failed");
        [[[XCUIApplication alloc] init].alerts[@"Network Error"].buttons[@"Ok"] tap];

    }];
}

@end
