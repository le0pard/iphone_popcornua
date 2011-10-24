//
//  CinemasViewController.h
//  Popcornua
//
//  Created by Alex on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"
#import "PopcornuaAppDelegate.h"
#import "CinemaViewController.h"
#import "NSString+HTML.h"

@interface CinemasViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *rootTableView;
    NSMutableArray *cinemasArray;
    PopcornuaAppDelegate *mainDelegate;
}

@property (nonatomic, retain) IBOutlet UITableView *rootTableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *cinemasArray;

-(void)fetchCinemasRecords:(NSManagedObjectContext *)moc;

@end
