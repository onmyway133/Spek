//
//  SpekHelperTestCase.m
//  Spek
//
//  Created by khoa on 11/01/2020.
//

#import "include/SpekHelperTestCase.h"

@implementation SpekHelperTestCase

- (instancetype)init {
    self = [super initWithInvocation: nil];
    return self;
}

+ (NSArray<NSInvocation *> *)testInvocations {
    NSArray<NSString *> *selectorStrings = [self spekTestMethodSelectors];
    NSMutableArray<NSInvocation *> *invocations = [NSMutableArray arrayWithCapacity:selectorStrings.count];

    for (NSString *selectorString in selectorStrings) {
        SEL selector = NSSelectorFromString(selectorString);
        NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.selector = selector;

        [invocations addObject:invocation];
    }

    return invocations;
}

+ (NSArray<NSString *> *)spekTestMethodSelectors {
    return @[];
}

@end
