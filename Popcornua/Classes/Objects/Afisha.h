//
//  Afisha.h
//  Popcornua
//
//  Created by Alex on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cinema, Movie;

@interface Afisha : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * data_begin;
@property (nonatomic, retain) NSDate * data_end;
@property (nonatomic, retain) NSString * prices;
@property (nonatomic, retain) NSString * times;
@property (nonatomic, retain) NSString * zal_title;
@property (nonatomic, retain) NSNumber * ext_id;
@property (nonatomic, retain) Cinema *cinema;
@property (nonatomic, retain) Movie *movie;

+ (Afisha *)afishaExistForId:(NSNumber *)extId withContext:(NSManagedObjectContext *)moc;
+ (BOOL)createOrReplaceFromDictionary:(NSDictionary *)movieInfo withContext:(NSManagedObjectContext *)moc;
+ (NSMutableArray *)getAfishaTodayList:(NSManagedObjectContext *)moc;
+ (NSMutableArray *)getAfishaTodayListByCinema:(Cinema *)cinema withContext:(NSManagedObjectContext *)moc;

@end
