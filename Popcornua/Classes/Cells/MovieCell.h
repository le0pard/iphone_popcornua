//
//  MovieCell.h
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Movie.h"
#import "NSStringUtil.h"
#import "ImageLoadingOperation.h"

#define POPCORN_MOVIES_POSTER_URL @"http://coocoorooza.com/uploads/afisha_films/%@"

@interface MovieCell : UITableViewCell {
    UILabel *title;
    UILabel *originalTitle;
    UILabel *yearLabel;
    UILabel *year;
    UIImageView *poster;
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *originalTitle;
@property (nonatomic, retain) IBOutlet UILabel *yearLabel;
@property (nonatomic, retain) IBOutlet UILabel *year;
@property (nonatomic, retain) IBOutlet UIImageView *poster;

- (void)setCellByMovie:(Movie *)movie;

@end
