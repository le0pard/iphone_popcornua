//
//  MoviesViewController.m
//  Popcornua
//
//  Created by Alex on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoviesViewController.h"

@implementation MoviesViewController

@synthesize rootTableView, moviesArray;

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

-(void)fetchMoviesTodayRecords{
    PCUSharedManager *myStoreManager = [PCUSharedManager sharedManager];
	self.moviesArray = [Movie getMoviesTodayList:myStoreManager.managedObjectContext];
}

-(void)updateTableView:(id)sender{
    [self fetchMoviesTodayRecords];
    [self.rootTableView reloadData];
    [self.rootTableView flashScrollIndicators];
}

- (void)viewChanged:(NSNotification *)notification{
    if ([[notification object] isEqualToString:@"selectCity"]){
        [[self navigationController] popToRootViewControllerAnimated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Movies", @"");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView:) name:@"updateTableViews" object:nil];
    
    [self fetchMoviesTodayRecords];
    
    PopcornuaAppDelegate *mainDelegate = (PopcornuaAppDelegate *)[[UIApplication sharedApplication] delegate];
    
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
	return [self.moviesArray count];
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
    Movie *movie = [self.moviesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = movie.title;
    cell.detailTextLabel.text = movie.orig_title;

    return cell;
}
#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // GA
    NSError *error;
    if (![[GANTracker sharedTracker] trackPageview:@"/movie_selected"
                                         withError:&error]) {
        NSLog(@"Error: %@", "Error load GA!");
    }
    [[GANTracker sharedTracker] dispatch];
    
    // select movie
    MovieViewController *movieController = [[MovieViewController alloc] initWithNibName:@"MovieViewController" bundle:nil];
	Movie *movie = [self.moviesArray objectAtIndex:indexPath.row];
	movieController.movieMain = movie;
	[self.navigationController pushViewController:movieController animated:YES];
    [movieController release];
}


- (void)dealloc {
	[moviesArray release];
    [rootTableView release];
    [super dealloc];
}

@end
