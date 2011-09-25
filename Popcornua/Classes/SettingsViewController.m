//
//  SettingsViewController.m
//  Popcornua
//
//  Created by Alex on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Settings", @"");
    self.delegate = self;
    [self setShowCreditsFooter:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -

- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForKey:(NSString*)key {
    NSLog(@"Key: %@", key);
    /*
	if ([key isEqualToString:@"ButtonDemoAction1"]) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Demo Action 1 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];
	} else {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Demo Action 2 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];
	}
     */
}

#pragma mark -
#pragma mark IASKAppSettingsViewControllerDelegate protocol
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {	
    [super dealloc];
}


@end
