//
//  Coordinate.h
//  Popcornua
//
//  Created by Alex on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Coordinate : NSObject <NSCoding> {
	CLLocationCoordinate2D _coordinate;
}
- (id)initWithCoordinate:(CLLocationCoordinate2D)c;
@property (readonly) CLLocationDegrees latitude;
@property (readonly) CLLocationDegrees longitude;
@property (assign) CLLocationCoordinate2D coordinate;

@end
