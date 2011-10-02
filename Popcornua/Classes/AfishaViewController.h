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
#import "MovieViewController.h"
#import "CinemaViewController.h"
#import "IASKSettingsReader.h"

@interface AfishaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    Afisha *afishaMain;
    UITableView *rootTableView;
}

@property (nonatomic, retain) IBOutlet Afisha *afishaMain;
@property (nonatomic, retain) IBOutlet UITableView *rootTableView;

@end
