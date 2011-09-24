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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    int result = 0;
    switch (section) {
		case 0:
			result = 1;
			break;
		case 1:
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
			headerText = @"test";
			break;
		case 1:
			headerText = @"";
			break;
		default:
			break;
	}
    return headerText;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *footerText = @"";
    switch (section) {
		case 0:
			footerText = @"test";
			break;
		case 1:
			footerText = @"";
			break;
		default:
			break;
	}
    return footerText;
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	CGRect footerFrame = CGRectMake(0, 0, 320, 50);
	UIView *footerView = [[[UIView alloc] initWithFrame:footerFrame] autorelease];
    
	if(section == 0) {
		CGRect footerSpinnerFrame = CGRectMake(80, 0, 20, 20);
		CGRect footerTextFrame = CGRectMake(110, 0, 200, 20);
		if(DeviceIsPad() == YES) {
			footerSpinnerFrame = CGRectMake(190, 0, 20, 20);
			footerTextFrame = CGRectMake(220, 0, 200, 20);
		}
		if((usersBlogs.count == 0) && (!hasCompletedGetUsersBlogs)) {
			UIActivityIndicatorView *footerSpinner = [[UIActivityIndicatorView alloc] initWithFrame:footerSpinnerFrame];
			footerSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
			[footerSpinner startAnimating];
			[footerView addSubview:footerSpinner];
			[footerSpinner release];
			
			UILabel *footerText = [[UILabel alloc] initWithFrame:footerTextFrame];
			footerText.backgroundColor = [UIColor clearColor];
			footerText.textColor = [UIColor darkGrayColor];
			footerText.text = NSLocalizedString(@"Loading blogs...", @"");
			[footerView addSubview:footerText];
			[footerText release];
		}
		else if((usersBlogs.count == 0) && (hasCompletedGetUsersBlogs)) {
			UILabel *footerText = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 200, 20)];
			footerText.backgroundColor = [UIColor clearColor];
			footerText.textColor = [UIColor darkGrayColor];
			footerText.text = NSLocalizedString(@"No blogs found.", @"");
			[footerView addSubview:footerText];
			[footerText release];
		}
	}

	return footerView;
}
*/
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	switch (indexPath.section) {
		case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.text = movieMain.title;
                    cell.detailTextLabel.text = movieMain.orig_title;
                    break;
                case 1:
                    cell.textLabel.text = @"test3";
                    break;
                default:
                    break;
            }
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
            switch (indexPath.row) {
                case 0:
                    if ([movieMain.title length] > 50){
                        height = 90;
                    } else if ([movieMain.title length] > 20) {
                        height = 65;
                    } else {
                        height = 45;
                    }
                    break;
                case 1:
                    height = 45;
                    break;
                default:
                    break;
            }
			break;
		default:
			break;
	}
    return height;
}


/*
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    Cinema *cinema = [self.afishasArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cinema.title;
    cell.detailTextLabel.text = cinema.address;
    return cell;
}
#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 140;
}
*/

- (void)dealloc {
	[afishasArray release];
    [rootTableView release];
    [movieMain release];
    [super dealloc];
}

@end
