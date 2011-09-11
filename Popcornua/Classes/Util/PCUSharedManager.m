//
//  PCUSharedManager.m
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PCUSharedManager.h"

static PCUSharedManager *sharedPCUManager = nil;

@implementation PCUSharedManager

@synthesize managedObjectContext;

#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if(sharedPCUManager == nil)
            sharedPCUManager = [[super allocWithZone:NULL] init];
    }
    return sharedPCUManager;
}
+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}
- (oneway void)release {
    // never release
}
- (id)autorelease {
    return self;
}
- (id)init {
    if (self = [super init]) {
        //
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [managedObjectContext release];
    [super dealloc];
}



@end
