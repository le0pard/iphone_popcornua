//
//  Cinema.h
//  Popcornua
//
//  Created by Alex on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSStringUtil.h"

@class Afisha;

@interface Cinema : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * call_phone;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * ext_id;
@property (nonatomic, retain) NSSet *afishas;

+ (Cinema *)cinemaExistForId:(NSNumber *)extId withContext:(NSManagedObjectContext *)moc;
+ (Cinema *)createOrReplaceFromDictionary:(NSDictionary *)cinemaInfo withContext:(NSManagedObjectContext *)moc;


@end
