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
#import "Afisha.h"
#import "NSStringUtil.h"
#import "ImageLoadingOperation.h"
#import "NSString+HTML.h"
#import "NSStringUtil.h"

@interface MovieCell : UITableViewCell {
    UILabel *title;
    UILabel *originalTitle;
    UILabel *yearLabel;
    UILabel *year;
    UILabel *zalLabel;
    UILabel *zal;
    UILabel *priceLabel;
    UILabel *price;
    UIImageView *poster;
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *originalTitle;
@property (nonatomic, retain) IBOutlet UILabel *yearLabel;
@property (nonatomic, retain) IBOutlet UILabel *year;
@property (nonatomic, retain) IBOutlet UILabel *zalLabel;
@property (nonatomic, retain) IBOutlet UILabel *zal;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *price;
@property (nonatomic, retain) IBOutlet UIImageView *poster;

- (void)setCellByAfisha:(Afisha *)afisha;

@end
