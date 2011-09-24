//
//  NSString+Util.h
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

- (bool)isEmpty;
- (NSString *)trim;
- (NSNumber *)numericValue;
- (NSString *)htmlEntityDecode;

@end

@interface NSNumber (NumericValueHack)
- (NSNumber *)numericValue;
@end
