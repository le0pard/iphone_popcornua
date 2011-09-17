//
//  MovieCell.m
//  Popcornua
//
//  Created by Alex on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

@synthesize title, originalTitle;

- (void)setCellByMovie:(Movie *)movie{
    self.title.text = movie.title;
    self.originalTitle.text = movie.orig_title;
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
