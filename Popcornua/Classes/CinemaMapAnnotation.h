//
//  CinemaMapAnnotation.h
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Cinema.h"

@interface CinemaMapAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    Cinema *cinemaMain;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, retain) IBOutlet Cinema *cinemaMain;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;

@end
