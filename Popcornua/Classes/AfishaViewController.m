//
//  AfishaViewController.m
//  Popcornua
//
//  Created by Alex on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AfishaViewController.h"

#define MOVIE_TITLE_CELL_INDEX 0
#define MOVIE_YEAR_CELL_INDEX 1
#define MOVIE_CASTS_CELL_INDEX 2
#define MOVIE_DESCR_CELL_INDEX 8
#define CINEMA_TITLE_CELL_INDEX 3
#define CINEMA_PHONE_CELL_INDEX 4
#define CINEMA_TIME_CELL_INDEX 5
#define CINEMA_PRICE_CELL_INDEX 6
#define CINEMA_SITE_CELL_INDEX 7

@implementation AfishaViewController

@synthesize afishaMain, rootTableView;

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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"") 
                                                                   style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    
    self.title = afishaMain.movie.title;
    
    UIImageView *posterView = nil;
    if (afishaMain.movie.getPosterImage){
        posterView = [[UIImageView alloc] initWithImage:afishaMain.movie.getPosterImage];
    } else {
        posterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
    }
    posterView.frame = CGRectMake(0, 0, 320, 260);
    posterView.contentMode = UIViewContentModeCenter;
    posterView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    rootTableView.tableHeaderView = posterView;
    [posterView release];
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
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 9;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    int result = 1;
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *headerText = @"";
    switch (section) {
		case MOVIE_TITLE_CELL_INDEX:
			headerText =  NSLocalizedString(@"Movie Name", @"");
			break;
		case MOVIE_YEAR_CELL_INDEX:
			headerText = NSLocalizedString(@"Movie Year", @"");
			break;
        case MOVIE_CASTS_CELL_INDEX:
			headerText = NSLocalizedString(@"Movie Casts", @"");
			break;
        case MOVIE_DESCR_CELL_INDEX:
            headerText = NSLocalizedString(@"Movie Description", @"");
            break;
        case CINEMA_TITLE_CELL_INDEX:
            headerText = NSLocalizedString(@"Cinema Name", @"");
            break;
        case CINEMA_TIME_CELL_INDEX:
            headerText = NSLocalizedString(@"Afisha Time", @"");
            break;
        case CINEMA_PRICE_CELL_INDEX:
            headerText = NSLocalizedString(@"Afisha Price", @"");
            break;
        case CINEMA_PHONE_CELL_INDEX:
            headerText = NSLocalizedString(@"Cinema Phone", @"");
            break;
        case CINEMA_SITE_CELL_INDEX:
            headerText = NSLocalizedString(@"Cinema Site", @"");
            break;
		default:
			break;
	}
    return headerText;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *footerText = @"";
    return footerText;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	switch (indexPath.section) {
		case MOVIE_TITLE_CELL_INDEX:
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = afishaMain.movie.title;
            cell.detailTextLabel.text = afishaMain.movie.orig_title;
			break;
        case MOVIE_YEAR_CELL_INDEX:
            if (afishaMain.movie.year){
                cell.textLabel.text = afishaMain.movie.year;
            } else {
                cell.textLabel.text = NSLocalizedString(@"Not set", @"");
            }
            cell.detailTextLabel.text = nil;
            break;
        case MOVIE_CASTS_CELL_INDEX:
            if (afishaMain.movie.casts){
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = [afishaMain.movie.casts htmlEntityDecode];
            } else {
                cell.textLabel.text = NSLocalizedString(@"Not set", @"");
            }
            cell.detailTextLabel.text = nil;
            break;
        case MOVIE_DESCR_CELL_INDEX:
            if (afishaMain.movie.descr){
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = [afishaMain.movie.descr htmlEntityDecode];
            } else {
                cell.textLabel.text = NSLocalizedString(@"Not set", @"");
            }
            cell.detailTextLabel.text = nil;
            break;
        case CINEMA_TITLE_CELL_INDEX:
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = afishaMain.cinema.title;
            cell.detailTextLabel.text = afishaMain.cinema.address;
			break;
        case CINEMA_TIME_CELL_INDEX:
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = afishaMain.times;
            cell.detailTextLabel.text = nil;
			break;
        case CINEMA_PRICE_CELL_INDEX:
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = afishaMain.prices;
            cell.detailTextLabel.text = nil;
			break;
        case CINEMA_PHONE_CELL_INDEX:
            if (afishaMain.cinema.phone){
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = afishaMain.cinema.phone;
                cell.detailTextLabel.text = afishaMain.cinema.call_phone;
            } else {
                cell.textLabel.text = NSLocalizedString(@"Not set", @"");
                cell.detailTextLabel.text = nil;
            }
			break;
        case CINEMA_SITE_CELL_INDEX:
            if (afishaMain.cinema.link){
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = afishaMain.cinema.link;
            } else {
                cell.textLabel.text = NSLocalizedString(@"Not set", @"");
            }
            cell.detailTextLabel.text = nil;
			break;
		default:
			break;
	}
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    MovieViewController *movieController = nil;
    CinemaViewController *cinemaController = nil;
    switch (indexPath.section) {
        case CINEMA_PHONE_CELL_INDEX:
            if (afishaMain.cinema.call_phone){
                UIAlertView *alert = [[UIAlertView alloc] init];
                [alert setTitle:NSLocalizedString(@"Call Title", @"")];
                [alert setMessage:[NSString stringWithFormat:NSLocalizedString(@"Call Descr", @""), afishaMain.cinema.call_phone]];
                [alert setDelegate:self];
                [alert addButtonWithTitle:NSLocalizedString(@"Yes", @"")];
                [alert addButtonWithTitle:NSLocalizedString(@"No", @"")];
                [alert show];
                [alert release];
            }
            break;
        case CINEMA_SITE_CELL_INDEX:
            if (afishaMain.cinema.link){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:afishaMain.cinema.link]];
            }
            break;
        case MOVIE_TITLE_CELL_INDEX:
            movieController = [[MovieViewController alloc] initWithNibName:@"MovieViewController" bundle:nil];
            movieController.movieMain = afishaMain.movie;
            [self.navigationController pushViewController:movieController animated:YES];
            [movieController release];
            break;
        case CINEMA_TITLE_CELL_INDEX:
            cinemaController = [[CinemaViewController alloc] initWithNibName:@"CinemaViewController" bundle:nil];
            cinemaController.cinemaMain = afishaMain.cinema;
            [self.navigationController pushViewController:cinemaController animated:YES];
            [cinemaController release];
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (0 == buttonIndex){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", afishaMain.cinema.call_phone]]];
    }
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 45;
	switch (indexPath.section) {
		case MOVIE_TITLE_CELL_INDEX:
            if ([afishaMain.movie.title length] > 50){
                height = 90;
            } else if ([afishaMain.movie.title length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
        case MOVIE_CASTS_CELL_INDEX:
            if ([afishaMain.movie.casts length] > 100){
                height = 110;
            } else if ([afishaMain.movie.casts length] > 50) {
                height = 70;
            } else if ([afishaMain.movie.casts length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
        case MOVIE_DESCR_CELL_INDEX:
            if (afishaMain.movie.descr.length > 0){
                switch (self.interfaceOrientation) {
                    case UIInterfaceOrientationPortrait:
                    case UIInterfaceOrientationPortraitUpsideDown:
                        height = ([[afishaMain.movie.descr htmlEntityDecode] length] / 1.5);
                        break;
                    default:
                        height = ([[afishaMain.movie.descr htmlEntityDecode] length] / 2.2);
                        break;
                }
            } else {
                height = 45;
            }
            break;
        case CINEMA_TITLE_CELL_INDEX:
            if ([afishaMain.cinema.title length] > 50){
                height = 90;
            } else if ([afishaMain.cinema.title length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
        case CINEMA_TIME_CELL_INDEX:
            if ([afishaMain.times length] > 50){
                height = 90;
            } else if ([afishaMain.times length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
        case CINEMA_PRICE_CELL_INDEX:
            if ([afishaMain.prices length] > 50){
                height = 90;
            } else if ([afishaMain.prices length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
        case CINEMA_PHONE_CELL_INDEX:
            if ([afishaMain.cinema.phone length] > 50){
                height = 90;
            } else if ([afishaMain.cinema.phone length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
        case CINEMA_SITE_CELL_INDEX:
            if ([afishaMain.cinema.link length] > 50){
                height = 90;
            } else if ([afishaMain.cinema.link length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
		default:
			break;
	}
    return height;
}

- (void)dealloc {
    [rootTableView release];
    [afishaMain release];
    [super dealloc];
}

@end
