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


@interface CinemaViewController : UIViewController{
    Cinema *cinemaMain;
}

@property (nonatomic, retain) IBOutlet Cinema *cinemaMain;

@end
