//
//  MovieCell.m
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

@synthesize title, originalTitle, poster, yearLabel, year;

#pragma mark -
#pragma mark Cached Image Loading

- (UIImage *)cachedImageForURL:(NSString *)posterString
{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:POPCORN_MOVIES_POSTER_URL, posterString]]];
    return [UIImage imageWithData:imageData];
}

- (void)setCellByMovie:(Movie *)movie{
    self.title.text = movie.title;
    self.originalTitle.text = movie.orig_title;
    self.yearLabel.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"Year", @"")];
    if (movie.year != nil && ![movie.year isEqualToString:@"0"]){
        self.year.text = movie.year;
    } else {
        self.year.text = NSLocalizedString(@"Not set", @"");
    }
    
    self.poster.layer.borderColor = [[UIColor blackColor] CGColor];
    self.poster.layer.borderWidth = 1.0;
    if (movie.poster != nil){
        self.poster.image = [self cachedImageForURL:movie.poster];
    }
    
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


- (void)dealloc {
	[super dealloc];
}



@end
