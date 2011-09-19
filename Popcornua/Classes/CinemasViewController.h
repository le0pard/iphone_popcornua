//
//  CinemasViewController.h
//  Popcornua
//
//  Created by Alex on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCUSharedManager.h"
#import "Cinema.h"
#import "PopcornuaAppDelegate.h"
#import "CinemaViewController.h"

@interface CinemasViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *rootTableView;
    NSMutableArray *cinemasArray;
}

@property (nonatomic, retain) IBOutlet UITableView *rootTableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *cinemasArray;

-(void)fetchCinemasRecords;

@end
