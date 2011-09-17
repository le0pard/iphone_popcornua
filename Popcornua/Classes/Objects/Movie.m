//
//  Movie.m
//  Popcornua
//
//  Created by Alex on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Movie.h"
#import "Afisha.h"


@implementation Movie
@dynamic cached_poster;
@dynamic casts;
@dynamic descr;
@dynamic orig_title;
@dynamic poster;
@dynamic title;
@dynamic year;
@dynamic ext_id;
@dynamic afishas;


+ (Movie *)newMovieObject:(NSManagedObjectContext *)moc {
    Movie *movie = [[[Movie alloc] initWithEntity:[NSEntityDescription entityForName:@"Movie"
                                                                 inManagedObjectContext:moc]
                      insertIntoManagedObjectContext:moc] autorelease];
    return movie;
}

+ (Movie *)movieExistForId:(NSNumber *)extId withContext:(NSManagedObjectContext *)moc{
    Movie *movie = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Movie"
                                        inManagedObjectContext:moc]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"ext_id == %@", extId]];
    [fetchRequest setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release]; fetchRequest = nil;
    if (results && ([results count] > 0)) {
        movie = [results objectAtIndex:0];
    }
    return movie;
}

+ (BOOL)createOrReplaceFromDictionary:(NSDictionary *)movieInfo withContext:(NSManagedObjectContext *)moc {
    Movie *movie = nil;
    NSNumber *extId = nil;
    if ([[movieInfo objectForKey:@"id"] isKindOfClass:[NSString class]]) {
        extId = [[movieInfo objectForKey:@"id"] numericValue];
    } else {
        extId = [movieInfo objectForKey:@"id"];
    }
    
    movie = [self movieExistForId:extId withContext:moc];
    
    if (nil == movie) {
        movie = [Movie newMovieObject:moc];
        movie.ext_id = extId;
    }
    
    movie.title = [movieInfo objectForKey:@"title"];
    if (![[movieInfo objectForKey:@"orig_title"] isKindOfClass:[NSNull class]]){
        movie.orig_title = [movieInfo objectForKey:@"orig_title"];
    }
    if (![[movieInfo objectForKey:@"year"] isKindOfClass:[NSNull class]]){
        movie.year = [[movieInfo objectForKey:@"year"] stringValue];
    }
    if (![[movieInfo objectForKey:@"description"] isKindOfClass:[NSNull class]]){
        movie.descr = [movieInfo objectForKey:@"description"];
    }
    if (![[movieInfo objectForKey:@"casts"] isKindOfClass:[NSNull class]]){
        movie.casts = [movieInfo objectForKey:@"casts"];
    }
    if (![[movieInfo objectForKey:@"poster"] isKindOfClass:[NSNull class]]){
        movie.poster = [movieInfo objectForKey:@"poster"];
    }
    
    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Error save to database : %@", [error userInfo]);
        return false;
    }
    
    return true;
}

+ (NSMutableArray *)getMoviesTodayList:(NSManagedObjectContext *)moc{
    // Define our table/entity to use
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Movie" inManagedObjectContext:moc];
	
	// Setup the fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
    
    // find by afisha
    // Define range of dates
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *formatterTemp = [[NSDateFormatter alloc] init];
    
    [formatterTemp setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSData *dataBegin = (NSData *)[formatter dateFromString:[formatterTemp stringFromDate:date]];
    
    [formatterTemp release];
    [formatter release];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(afishas.data_begin <= %@) AND (afishas.data_end >= %@)", dataBegin, dataBegin];
    [request setPredicate:predicate];
     
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
        return nil;
    }
    
    [mutableFetchResults autorelease];
    return mutableFetchResults;
}

@end
