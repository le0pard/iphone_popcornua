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
    static NSString *MovieCellIdentifier = @"MovieCellIdentifier ";
	
	MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier: MovieCellIdentifier];
	if (cell == nil)  
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" 
                                                     owner:self options:nil];
		cell = (MovieCell *)[nib objectAtIndex:0];
		
	}
    
    // set cell
    Movie *movie = [self.moviesArray objectAtIndex:indexPath.row];
    [cell setCellByMovie:movie];
    //return cell
    
    return cell;
}
#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 140;
}


- (void)dealloc {
	[moviesArray release];
    [rootTableView release];
    [super dealloc];
}

@end
