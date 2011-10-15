//
//  CinemasViewController.m
//  Popcornua
//
//  Created by Alex on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CinemasViewController.h"

@implementation CinemasViewController

@synthesize rootTableView, cinemasArray;

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

-(void)fetchCinemasRecords:(NSManagedObjectContext *)moc{
    if ([moc tryLock]){
        self.cinemasArray = [Cinema getCinemasList:moc];
        [moc unlock];
    }
}

-(void)updateTableView:(id)sender{
    [self fetchCinemasRecords:mainDelegate.managedObjectContext];
    [self.rootTableView reloadData];
    [self.rootTableView flashScrollIndicators];
}

- (void)viewChanged:(NSNotification *)notification{
    if ([[notification object] isEqualToString:@"selectCity"]){
        [[self navigationController] popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Cinemas", @"");
    
    mainDelegate = (PopcornuaAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView:) name:@"updateTableViews" object:nil];
    
    [self fetchCinemasRecords:mainDelegate.managedObjectContext];
    
    UIBarButtonItem *syncButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                   target:mainDelegate 
                                   action:@selector(syncDataCore)];    
    self.navigationItem.rightBarButtonItem = syncButton;
    [syncButton release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewChanged:) name:kIASKAppSettingChanged object:nil];
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


#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.cinemasArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    Cinema *cinema = [self.cinemasArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cinema.title;
    cell.detailTextLabel.text = cinema.address;
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    CinemaViewController *cinemaController = [[CinemaViewController alloc] initWithNibName:@"CinemaViewController" bundle:nil];
	Cinema *cinema = [self.cinemasArray objectAtIndex:indexPath.row];
	cinemaController.cinemaMain = cinema;
    
    // GA begin
    NSError *error;
    if (![[GANTracker sharedTracker] setCustomVariableAtIndex:1
                                                         name:@"Cinema Selected"
                                                        value:cinema.title
                                                    withError:&error]) {
        NSLog(@"Error: %@", "Error load GA!");
    }
    if (![[GANTracker sharedTracker] trackPageview:@"/cinema_selected"
                                         withError:&error]) {
        NSLog(@"Error: %@", "Error load GA!");
    }
    [[GANTracker sharedTracker] dispatch];
    // GA end
    
	[self.navigationController pushViewController:cinemaController animated:YES];
    [cinemaController release];
}


- (void)dealloc {
	[cinemasArray release];
	[rootTableView release];
    [super dealloc];
}

@end
