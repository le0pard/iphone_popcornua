//
//  CinemasMapController.h
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Cinema.h"
#import "CinemaMapAnnotation.h"
#import "PopcornuaAppDelegate.h"

@interface CinemasMapController : UIViewController <MKMapViewDelegate, MKReverseGeocoderDelegate> {
    MKMapView *mapView;
    MKReverseGeocoder *reverseGeokoder;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet MKReverseGeocoder *reverseGeokoder;

-(void)fetchCinemasAndMapIts;

@end
