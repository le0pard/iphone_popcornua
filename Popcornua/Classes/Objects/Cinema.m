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
@dynamic geolocation;
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
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"ext_id == %@", extId]];
    [fetchRequest setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release]; 
    fetchRequest = nil;
    if (results && ([results count] > 0)) {
        cinema = [results objectAtIndex:0];
    }
    return cinema;
}

+ (BOOL)saveFromArrayOfDictionaries:(NSArray *)theaters withContext:(NSManagedObjectContext *)moc{
    for (NSDictionary *theater in theaters) {
        [Cinema buildFromDictionary:theater withContext:moc];
    }
    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Error save to database : %@", [error userInfo]);
        return false;
    }
    return true;
}

+ (Cinema *)buildFromDictionary:(NSDictionary *)cinemaInfo withContext:(NSManagedObjectContext *)moc{
    NSNumber *extId = nil;
    if ([[cinemaInfo objectForKey:@"id"] isKindOfClass:[NSString class]]) {
        extId = [[cinemaInfo objectForKey:@"id"] numericValue];
    } else {
        extId = [cinemaInfo objectForKey:@"id"];
    }
    
    Cinema *cinema = [self cinemaExistForId:extId withContext:moc];
    
    if (nil == cinema) {
        cinema = [Cinema newCinemaObject:moc];
        cinema.ext_id = extId;
    }
    
    cinema.title = [cinemaInfo objectForKey:@"title"];
    if (![[cinemaInfo objectForKey:@"address"] isKindOfClass:[NSNull class]]){
        cinema.address = [cinemaInfo objectForKey:@"address"];
    }
    if (![[cinemaInfo objectForKey:@"phone"] isKindOfClass:[NSNull class]]){
        cinema.phone = [cinemaInfo objectForKey:@"phone"];
    }
    if (![[cinemaInfo objectForKey:@"link"] isKindOfClass:[NSNull class]]){
        cinema.link = [cinemaInfo objectForKey:@"link"];
    }
    if (![[cinemaInfo objectForKey:@"call_phone"] isKindOfClass:[NSNull class]]){
        cinema.call_phone = [cinemaInfo objectForKey:@"call_phone"];
    }
    
    if (![[cinemaInfo objectForKey:@"latitude"] isKindOfClass:[NSNull class]] && ![[cinemaInfo objectForKey:@"longitude"] isKindOfClass:[NSNull class]]){
        cinema.latitude = [cinemaInfo objectForKey:@"latitude"];
        cinema.longitude = [cinemaInfo objectForKey:@"longitude"];
        CLLocationCoordinate2D coord;
        coord.latitude = [cinema.latitude doubleValue];
        coord.longitude = [cinema.longitude doubleValue];
        Coordinate *c = [[Coordinate alloc] initWithCoordinate:coord];
        cinema.geolocation = c;
        [c release];
    }
    return cinema;
}

+ (BOOL)createOrReplaceFromDictionary:(NSDictionary *)cinemaInfo withContext:(NSManagedObjectContext *)moc {
    [Cinema buildFromDictionary:cinemaInfo withContext:moc];    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Error save to database : %@", [error userInfo]);
        return false;
    }
    
    return true;
}


+ (NSMutableArray *)getCinemasList:(NSManagedObjectContext *)moc{
    // Define our table/entity to use
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cinema" inManagedObjectContext:moc];
	
	// Setup the fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	
	// Define how we will sort the records
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	
	// Fetch the records and handle an error
	NSError *error;
	NSMutableArray *mutableFetchResults = [[moc executeFetchRequest:request error:&error] mutableCopy];
    [request release];
    
    if (!mutableFetchResults){
        [mutableFetchResults release];
        return nil;
    }
    
    [mutableFetchResults autorelease];
    return mutableFetchResults;
}

@end
