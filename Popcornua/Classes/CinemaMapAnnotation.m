//
//  CinemaMapAnnotation.m
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CinemaMapAnnotation.h"

@implementation CinemaMapAnnotation

@synthesize title, subtitle, coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	self = [super init];
    if (self) {
        coordinate = c;
    }
	return self;
}

-(void) dealloc {
    self.title = nil;
    self.subtitle = nil;
	[super dealloc];
}


@end
