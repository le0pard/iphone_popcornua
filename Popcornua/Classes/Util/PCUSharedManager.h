//
//  PCUSharedManager.h
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCUSharedManager : NSObject{
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, assign) NSManagedObjectContext *managedObjectContext;

+ (id)sharedManager;

@end
