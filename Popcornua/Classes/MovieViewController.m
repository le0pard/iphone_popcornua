//
//  MovieViewController.m
//  Popcornua
//
//  Created by Alex on 9/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieViewController.h"

#define AFISHA_SELL 1

@implementation MovieViewController

@synthesize movieMain, rootTableView, afishasArray;

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

- (NSMutableArray *)groupByCinemas:(NSMutableArray *)ary{
    NSMutableArray *mutableAr = [[NSMutableArray alloc] init];
    BOOL is_uniq = YES;
    for (Afisha *afisha in ary){
        is_uniq = YES;
        for (Afisha *tempAf in mutableAr){
            if (tempAf.cinema == afisha.cinema){
                is_uniq = NO;
                tempAf.times = [NSString stringWithFormat:@"%@ %@", tempAf.times, afisha.times];
            }
        }
        if (is_uniq){
            [mutableAr addObject:afisha];
        }
    }
    [mutableAr autorelease];
    return mutableAr;
}

-(void)fetchCinemasTodayRecords{
    PCUSharedManager *myStoreManager = [PCUSharedManager sharedManager];
	self.afishasArray = [self groupByCinemas:[Afisha getAfishaTodayListByMovie:movieMain withContext:myStoreManager.managedObjectContext]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchCinemasTodayRecords];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Movie", @"") 
                                                                   style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    
    self.title = movieMain.title;
    
    UIImageView *posterView = nil;
    if (movieMain.getPosterImage){
        posterView = [[UIImageView alloc] initWithImage:movieMain.getPosterImage];
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    int result = 1;
    switch (section) {
        case AFISHA_SELL:
            result = [self.afishasArray count];
            break;
		default:
			break;
	}
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *headerText = @"";
    switch (section) {
		case 0:
			headerText = NSLocalizedString(@"Movie Name", @"");
			break;
		case 2:
			headerText = NSLocalizedString(@"Movie Year", @"");
			break;
        case 3:
			headerText = NSLocalizedString(@"Movie Casts", @"");
			break;
        case AFISHA_SELL:
            headerText = NSLocalizedString(@"Movie Afisha", @"");
            break;
        case 4:
            headerText = NSLocalizedString(@"Movie Description", @"");
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
    Afisha *afishaObj = nil;
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	switch (indexPath.section) {
		case 0:
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = movieMain.title;
            cell.detailTextLabel.text = movieMain.orig_title;
			break;
        case 2:
            if (movieMain.year){
                cell.textLabel.text = movieMain.year;
            } else {
                cell.textLabel.text = NSLocalizedString(@"Not set", @"");
            }
            cell.detailTextLabel.text = nil;
            break;
        case 3:
            if (movieMain.casts){
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = [movieMain.casts htmlEntityDecode];
            } else {
                cell.textLabel.text = NSLocalizedString(@"Not set", @"");
            }
            cell.detailTextLabel.text = nil;
            break;
        case AFISHA_SELL:
            /* afisha */
            afishaObj = [self.afishasArray objectAtIndex:indexPath.row];
            cell.textLabel.text = afishaObj.cinema.title;
            cell.detailTextLabel.text = afishaObj.times;
            break;
        case 4:
            if (movieMain.descr){
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = [movieMain.descr htmlEntityDecode];
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
    
    if (AFISHA_SELL == indexPath.section){
        AfishaViewController *afishaController = [[AfishaViewController alloc] initWithNibName:@"AfishaViewController" bundle:nil];
        Afisha *afisha = [self.afishasArray objectAtIndex:indexPath.row];
        afishaController.afishaMain = afisha;
        [self.navigationController pushViewController:afishaController animated:YES];
        [afishaController release];
    }
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 45;
	switch (indexPath.section) {
		case 0:
            if ([movieMain.title length] > 50){
                height = 90;
            } else if ([movieMain.title length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
        case 3:
            if ([movieMain.casts length] > 100){
                height = 110;
            } else if ([movieMain.casts length] > 50) {
                height = 70;
            } else if ([movieMain.casts length] > 20) {
                height = 65;
            } else {
                height = 45;
            }
            break;
        case 4:
            if (movieMain.descr.length > 0){
                switch (self.interfaceOrientation) {
                    case UIInterfaceOrientationPortrait:
                    case UIInterfaceOrientationPortraitUpsideDown:
                        height = ([[movieMain.descr htmlEntityDecode] length] / 1.5);
                        break;
                    default:
                        height = ([[movieMain.descr htmlEntityDecode] length] / 2.2);
                        break;
                }
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
	[afishasArray release];
    [rootTableView release];
    [movieMain release];
    [super dealloc];
}

@end
