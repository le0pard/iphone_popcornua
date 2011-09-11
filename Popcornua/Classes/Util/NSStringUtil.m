//
//  NSStringUtil.m
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSStringUtil.h"

@implementation NSString (Util)

- (bool)isEmpty {
    return self.length == 0;
}

- (NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSNumber *)numericValue {
    return [NSNumber numberWithInt:[self intValue]];
}

@end

@implementation NSNumber (NumericValueHack)
- (NSNumber *)numericValue {
	return self;
}
@end
