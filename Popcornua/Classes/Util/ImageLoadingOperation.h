//
//  ImageLoadingOperation.h
//  Popcornua
//
//  Created by Alex on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ImageResultKey;
extern NSString *const URLResultKey;

@interface ImageLoadingOperation : NSOperation {
    NSURL *imageURL;
    id target;
    SEL action;
}

- (id)initWithImageURL:(NSURL *)imageURL target:(id)target action:(SEL)action;

@end
