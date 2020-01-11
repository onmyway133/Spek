//
//  SpekHelperTestCase.h
//  Spek
//
//  Created by khoa on 11/01/2020.
//

#if _XCTEST_

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpekSelector : NSObject
- (instancetype)initWithSelector:(SEL)selector;
@end

@interface SpekHelperTestCase : XCTestCase

+ (NSArray<SpekSelector *> *)spek_testMethodSelectors;
@end

NS_ASSUME_NONNULL_END

#endif
