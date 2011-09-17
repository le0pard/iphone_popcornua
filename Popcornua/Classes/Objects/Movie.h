//
//  Movie.h
//  Popcornua
//
//  Created by Alex on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSStringUtil.h"

@class Afisha;

@interface Movie : NSManagedObject {
@private
}
@property (nonatomic, retain) NSData * cached_poster;
@property (nonatomic, retain) NSString * casts;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * orig_title;
@property (nonatomic, retain) NSString * poster;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSNumber * ext_id;
@property (nonatomic, retain) NSSet *afishas;

+ (Movie *)movieExistForId:(NSNumber *)extId withContext:(NSManagedObjectContext *)moc;
+ (BOOL)createOrReplaceFromDictionary:(NSDictionary *)cinemaInfo withContext:(NSManagedObjectContext *)moc;
+ (NSMutableArray *)getMoviesTodayList:(NSManagedObjectContext *)moc;

@end
