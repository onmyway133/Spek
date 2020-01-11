//
//  SpekHelperTestCase.m
//  Spek
//
//  Created by khoa on 11/01/2020.
//

#if _XCTEST_

#import "SpekHelperTestCase.h"

@interface SpekSelector ()
@property(nonatomic, assign) SEL selector;
@end

@implementation SpekSelector

- (instancetype)initWithSelector:(SEL)selector {
    self = [super init];
    _selector = selector;
    return self;
}

@end

@implementation SpekHelperTestCase

+ (NSArray<NSInvocation *> *)testInvocations {
    NSArray<SpekSelector *> *selectors = [self spek_testMethodSelectors];
    NSMutableArray<NSInvocation *> *invocations = [NSMutableArray arrayWithCapacity:selectors.count];

    for (SpekSelector *aSelector in selectors) {
        SEL selector = aSelector.selector;
        NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.selector = selector;

        [invocations addObject:invocation];
    }

    return invocations;
}

+ (NSArray<SpekSelector *> *)spek_testMethodSelectors {
    return @[];
}

@end

#endif
