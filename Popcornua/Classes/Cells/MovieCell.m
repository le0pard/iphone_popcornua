//
//  MovieCell.m
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

@synthesize title, originalTitle, poster, yearLabel, year, zalLabel, zal, priceLabel, price;

#pragma mark -
#pragma mark Cached Image Loading

- (UIImage *)cachedImageForURL:(NSString *)posterString
{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:POPCORN_MOVIES_POSTER_URL, posterString]]];
    return [UIImage imageWithData:imageData];
}

- (void)setCellByAfisha:(Afisha *)afisha{
    self.title.text = [afisha.movie.title stringByConvertingHTMLToPlainText];
    self.originalTitle.text = [afisha.movie.orig_title stringByConvertingHTMLToPlainText];
    self.yearLabel.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"Year", @"")];
    if (afisha.movie.year != nil && ![afisha.movie.year isEqualToString:@"0"]){
        self.year.text = afisha.movie.year;
    } else {
        self.year.text = NSLocalizedString(@"Not set", @"");
    }
    
    self.poster.layer.borderColor = [[UIColor blackColor] CGColor];
    self.poster.layer.borderWidth = 1.0;
    if (afisha.movie.poster != nil){
        if (afisha.movie.cached_poster){
            self.poster.image = [afisha.movie getPosterImage];
        } else {
            self.poster.image = [self cachedImageForURL:afisha.movie.poster];
        }
    }
    
    self.zalLabel.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"Hall", @"")];
    if (afisha.zal_title != nil && ![afisha.zal_title isEqualToString:@""]){
        self.zal.text = afisha.zal_title;
    } else {
        self.zal.text = NSLocalizedString(@"Not set", @"");
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"Price", @"")];
    if (afisha.prices != nil && ![afisha.prices isEqualToString:@""]){
        self.price.text = afisha.prices;
    } else {
        self.price.text = NSLocalizedString(@"Not set", @"");
    }
    /*
    self.timesLabel.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"Times", @"")];
    if (afisha.times != nil && ![afisha.times isEqualToString:@""]){
        self.times.text = afisha.times;
    } else {
        self.times.text = NSLocalizedString(@"Not set", @"");
    }
    */
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{ 
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
	[super setSelected:selected animated:animated];
    
	// Configure the view for the selected state
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (void)dealloc {
	[super dealloc];
}



@end
