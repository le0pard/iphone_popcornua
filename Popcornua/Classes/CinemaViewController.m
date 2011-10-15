//
//  CinemaViewController.m
//  Popcornua
//
//  Created by Alex on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CinemaViewController.h"

@implementation CinemaViewController

@synthesize cinemaMain, rootTableView, afishasArray;

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

-(void)fetchMoviesTodayRecords:(NSManagedObjectContext *)moc{
	self.afishasArray = [Afisha getAfishaTodayListByCinema:cinemaMain withContext:moc];
}

- (void)viewChanged:(NSNotification *)notification{
    if ([[notification object] isEqualToString:@"selectCity"]){
        [[self navigationController] popToRootViewControllerAnimated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainDelegate = (PopcornuaAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cinema", @"") 
                                                                   style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];

    self.title = cinemaMain.title;
    
    [self fetchMoviesTodayRecords:mainDelegate.managedObjectContext];
    
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
	return [self.afishasArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
     static NSString *MovieCellIdentifier = @"MovieCellIdentifier ";
     
     MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier: MovieCellIdentifier];
     if (cell == nil)  {
         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" 
                                                      owner:self options:nil];
         cell = (MovieCell *)[nib objectAtIndex:0];
     }
     
     // set cell
     Afisha *afisha = [self.afishasArray objectAtIndex:indexPath.row];
     [cell setCellByAfisha:afisha];
     //return cell
    
    return cell;
}
#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AfishaViewController *afishaController = [[AfishaViewController alloc] initWithNibName:@"AfishaViewController" bundle:nil];
	Afisha *afisha = [self.afishasArray objectAtIndex:indexPath.row];
	afishaController.afishaMain = afisha;
    
    // GA begin
    NSError *error;
    if (![[GANTracker sharedTracker] setCustomVariableAtIndex:1
                                                         name:@"Afisha Selected"
                                                        value:[NSString stringWithFormat:@"%@ : %@", afisha.cinema.title, afisha.movie.title]
                                                    withError:&error]) {
        NSLog(@"Error: %@", "Error load GA!");
    }
    if (![[GANTracker sharedTracker] trackPageview:@"/afisha_selected"
                                         withError:&error]) {
        NSLog(@"Error: %@", "Error load GA!");
    }
    [[GANTracker sharedTracker] dispatch];
    // GA end
    
	[self.navigationController pushViewController:afishaController animated:YES];
    [afishaController release];
}


- (void)dealloc {
	[afishasArray release];
    [rootTableView release];
    [cinemaMain release];
    [super dealloc];
}

@end
