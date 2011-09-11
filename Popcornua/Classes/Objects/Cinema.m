//
//  Cinema.m
//  Popcornua
//
//  Created by Alex on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Cinema.h"
#import "Afisha.h"


@implementation Cinema
@dynamic address;
@dynamic call_phone;
@dynamic latitude;
@dynamic link;
@dynamic longitude;
@dynamic phone;
@dynamic title;
@dynamic ext_id;
@dynamic afishas;

+ (Cinema *)newCinemaObject:(NSManagedObjectContext *)moc {
    Cinema *cinema = [[[Cinema alloc] initWithEntity:[NSEntityDescription entityForName:@"Cinema"
                                                                 inManagedObjectContext:moc]
                      insertIntoManagedObjectContext:moc] autorelease];
    return cinema;
}

+ (Cinema *)cinemaExistForId:(NSNumber *)extId withContext:(NSManagedObjectContext *)moc{
    Cinema *cinema = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Cinema"
                                        inManagedObjectContext:moc]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"ext_id = %@", extId]];
    [fetchRequest setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release]; fetchRequest = nil;
    if (results && ([results count] > 0)) {
        cinema = [results objectAtIndex:0];
    }
    return cinema;
}

+ (Cinema *)createOrReplaceFromDictionary:(NSDictionary *)cinemaInfo withContext:(NSManagedObjectContext *)moc {
    Cinema *cinema = nil;
    NSNumber *extId = nil;
    if ([[cinemaInfo objectForKey:@"id"] isKindOfClass:[NSString class]]) {
        extId = [[cinemaInfo objectForKey:@"id"] numericValue];
    } else {
        extId = [cinemaInfo objectForKey:@"id"];
    }
    
    cinema = [self cinemaExistForId:extId withContext:moc];
    
    if (nil == cinema) {
        cinema = [[Cinema newCinemaObject:moc] autorelease];
        cinema.ext_id = extId;
    }
    
    cinema.title = [cinemaInfo objectForKey:@"title"];
    cinema.address = [cinemaInfo objectForKey:@"address"];
    cinema.phone = [cinemaInfo objectForKey:@"phone"];
    cinema.link = [cinemaInfo objectForKey:@"link"];
    cinema.latitude = [cinemaInfo objectForKey:@"latitude"];
    cinema.longitude = [cinemaInfo objectForKey:@"longitude"];
    cinema.call_phone = [cinemaInfo objectForKey:@"call_phone"];
    
    return cinema;
}

@end
