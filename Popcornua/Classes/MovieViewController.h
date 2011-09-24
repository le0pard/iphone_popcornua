//
//  MovieViewController.h
//  Popcornua
//
//  Created by Alex on 9/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Afisha.h"
#import "Movie.h"
#import "Cinema.h"
#import "NSStringUtil.h"
#import "PCUSharedManager.h"
#import "AfishaViewController.h"

#define AFISHA_SELL 3

@interface MovieViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    Movie *movieMain;
    UITableView *rootTableView;
    NSMutableArray *afishasArray;
}

@property (nonatomic, retain) IBOutlet Movie *movieMain;
@property (nonatomic, retain) IBOutlet UITableView *rootTableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *afishasArray;

@end
