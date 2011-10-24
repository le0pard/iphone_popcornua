//
//  MoviesViewController.h
//  Popcornua
//
//  Created by Alex on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MovieViewController.h"
#import "PopcornuaAppDelegate.h"
#import "NSString+HTML.h"

@interface MoviesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITableView *rootTableView;
    NSMutableArray *moviesArray;
    PopcornuaAppDelegate *mainDelegate;
}

@property (nonatomic, retain) IBOutlet UITableView *rootTableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *moviesArray;

-(void)fetchMoviesTodayRecords:(NSManagedObjectContext *)moc;


@end
