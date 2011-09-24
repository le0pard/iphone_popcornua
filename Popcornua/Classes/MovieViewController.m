//
//  MovieViewController.m
//  Popcornua
//
//  Created by Alex on 9/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    int result = 1;
    switch (section) {
        case 10:
            result = 2;
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
			headerText =  NSLocalizedString(@"Movie Name", @"");
			break;
		case 1:
			headerText = NSLocalizedString(@"Movie Year", @"");
			break;
        case 2:
			headerText = NSLocalizedString(@"Movie Casts", @"");
			break;
        case 3:
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
        case 1:
            if (movieMain.year){
                cell.textLabel.text = movieMain.year;
            } else {
                cell.textLabel.text = NSLocalizedString(@"Not set", @"");
            }
            cell.detailTextLabel.text = nil;
            break;
        case 2:
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
        case 3:
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
    /*
	if(indexPath.section == 0) {
		
		NSDictionary *selectedBlog = [usersBlogs objectAtIndex:indexPath.row];
		
		if(![selectedBlogs containsObject:[selectedBlog valueForKey:@"blogid"]]) {
			[selectedBlogs addObject:[selectedBlog valueForKey:@"blogid"]];
		}
		else {
			int indexToRemove = -1;
			int count = 0;
			for (NSString *blogID in selectedBlogs) {
				if([blogID isEqual:[selectedBlog valueForKey:@"blogid"]]) {
					indexToRemove = count;
					break;
				}
				count++;
			}
			if(indexToRemove > -1)
				[selectedBlogs removeObjectAtIndex:indexToRemove];
		}
		[tv reloadData];
		
		if(selectedBlogs.count == usersBlogs.count)
			[self selectAllBlogs:self];
		else if(selectedBlogs.count == 0)
			[self deselectAllBlogs:self];
	}
	else if(indexPath.section == 1) {
		[self signOut];
	}
	
	[self checkAddSelectedButtonStatus];
    */
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
        case 2:
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
        case 3:
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
