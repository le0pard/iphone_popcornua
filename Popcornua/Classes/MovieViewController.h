//
//  MovieViewController.h
//  Popcornua
//
//  Created by Alex on 9/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "Cinema.h"

@interface MovieViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    Cinema *cinemaMain;
    Movie *movieMain;
    UITableView *rootTableView;
    NSMutableArray *afishasArray;
}

@property (nonatomic, retain) IBOutlet Cinema *cinemaMain;
@property (nonatomic, retain) IBOutlet Movie *movieMain;
@property (nonatomic, retain) IBOutlet UITableView *rootTableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *afishasArray;

@end
