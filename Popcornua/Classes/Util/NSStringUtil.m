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

- (NSString *)htmlEntityDecode
{
    self = [self stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    self = [self stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    self = [self stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    self = [self stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    self = [self stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    self = [self stringByReplacingOccurrencesOfString:@"&laquo;" withString:@"\""];
    self = [self stringByReplacingOccurrencesOfString:@"&raquo;" withString:@"\""];
    self = [self stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    self = [self stringByReplacingOccurrencesOfString:@"&ndash;" withString:@" - "];
    self = [self stringByReplacingOccurrencesOfString:@"&mdash;" withString:@" - "];
    
    return self;
}

@end

@implementation NSNumber (NumericValueHack)
- (NSNumber *)numericValue {
	return self;
}
@end
