//
//  CinemasMapController.m
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CinemasMapController.h"

@implementation CinemasMapController

@synthesize mapView, reverseGeokoder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)fetchCinemasAndMapIts{
    PopcornuaAppDelegate *mainDelegate = (PopcornuaAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSMutableArray *cinemasArray = [Cinema getCinemasList:mainDelegate.managedObjectContext];
    
    
    MKCoordinateRegion cityRegion;
    cityRegion.center.latitude = 0;
    cityRegion.center.longitude = 0;
    cityRegion.span.latitudeDelta = 0.2;
    cityRegion.span.longitudeDelta = 0.2; 
    
    NSInteger iteratorTaps = 0;
    
    for (Cinema *cinema in cinemasArray) {
        if (cinema.geolocation){
            CinemaMapAnnotation *cinemaTap = [[CinemaMapAnnotation alloc] initWithCoordinate:cinema.geolocation.coordinate];
            cinemaTap.title = cinema.title;
            cinemaTap.subtitle = cinema.address;
            [mapView addAnnotation:cinemaTap];
            [cinemaTap release];
            
            cityRegion.center.latitude += cinema.geolocation.latitude;
            cityRegion.center.longitude += cinema.geolocation.longitude;
            iteratorTaps++;
        }
    }
    
    if (iteratorTaps){
        cityRegion.center.latitude = cityRegion.center.latitude / iteratorTaps;
        cityRegion.center.longitude = cityRegion.center.longitude / iteratorTaps;
    
        [mapView setRegion:cityRegion animated:NO];
        [mapView setCenterCoordinate:mapView.region.center animated:NO];
    }
}

- (void)changeMapView:(id)sender{
    UIBarButtonItem *mapViewButton = (UIBarButtonItem *)sender;
    if (NSLocalizedString(@"SatellitView", @"") == [mapViewButton title]){
        mapView.mapType = MKMapTypeSatellite;
        mapViewButton.title = NSLocalizedString(@"MapView", @"");
    } else {
        mapView.mapType = MKMapTypeStandard;
        mapViewButton.title = NSLocalizedString(@"SatellitView", @"");
    }
}

-(void)updateMapAnotations:(id)sender{
    for (id annotation in mapView.annotations) {
        if ([annotation isKindOfClass:[CinemaMapAnnotation class]]){
            [mapView removeAnnotation:annotation];
        }
    }
    [self fetchCinemasAndMapIts];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Map", @"");
    
	[self fetchCinemasAndMapIts];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMapAnotations:) name:@"updateTableViews" object:nil];
    
    UIBarButtonItem *mapViewButton = [[UIBarButtonItem alloc]
                                   initWithTitle:NSLocalizedString(@"SatellitView", @"") 
                                   style:UIBarButtonItemStylePlain 
                                   target:self action:@selector(changeMapView:)];    
    self.navigationItem.rightBarButtonItem = mapViewButton;
    [mapViewButton release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Map Anotation

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id)annotation
{
    static NSString* MyIdentifier = @"CinemaMapAnotation";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MyIdentifier];
    if (!pinView)
    {
        MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                               initWithAnnotation:annotation reuseIdentifier:MyIdentifier] autorelease];
        customPinView.animatesDrop = NO;
        customPinView.canShowCallout = YES;
        customPinView.draggable = NO;
        return customPinView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}

#pragma mark - Reverce geocoder

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
    //
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark;{
    //
}

#pragma mark - View lifecycle

- (void)dealloc {
	[mapView release];
	[reverseGeokoder release];
    [super dealloc];
}

@end
