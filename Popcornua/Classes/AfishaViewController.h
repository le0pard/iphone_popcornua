//
//  AfishaViewController.h
//  Popcornua
//
//  Created by Alex on 9/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"
#import "Movie.h"
#import "Afisha.h"
#import "PCUSharedManager.h"

@interface AfishaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    Cinema *cinemaMain;
    Movie *movieMain;
    UITableView *rootTableView;
}

@property (nonatomic, retain) IBOutlet Cinema *cinemaMain;
@property (nonatomic, retain) IBOutlet Movie *movieMain;
@property (nonatomic, retain) IBOutlet UITableView *rootTableView;

@end
