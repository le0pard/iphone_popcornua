//
//  CinemaMapAnnotation.h
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CinemaMapAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;

@end
