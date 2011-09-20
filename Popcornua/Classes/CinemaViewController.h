//
//  CinemaViewController.h
//  Popcornua
//
//  Created by Alex on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"
#import "Movie.h"
#import "Afisha.h"
#import "MovieCell.h"
#import "PCUSharedManager.h"


@interface CinemaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    Cinema *cinemaMain;
    UITableView *rootTableView;
    NSMutableArray *afishasArray;
}

@property (nonatomic, retain) IBOutlet Cinema *cinemaMain;
@property (nonatomic, retain) IBOutlet UITableView *rootTableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *afishasArray;


@end
