//
//  MoviesViewController.h
//  Popcornua
//
//  Created by Alex on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCUSharedManager.h"
#import "Movie.h"
#import "PopcornuaAppDelegate.h"

@interface MoviesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITableView *rootTableView;
    NSMutableArray *moviesArray;
}

@property (nonatomic, retain) IBOutlet UITableView *rootTableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *moviesArray;

-(void)fetchMoviesTodayRecords;


@end
