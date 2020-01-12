//
//  SpekHelperTestCase.h
//  Spek
//
//  Created by khoa on 11/01/2020.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface SpekHelperTestCase : XCTestCase
+ (NSArray<NSString *> *)spekTestMethodSelectors;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
@end
