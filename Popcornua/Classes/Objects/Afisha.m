//
//  Afisha.m
//  Popcornua
//
//  Created by Alex on 9/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Afisha.h"
#import "Cinema.h"
#import "Movie.h"


@implementation Afisha
@dynamic data_begin;
@dynamic data_end;
@dynamic prices;
@dynamic times;
@dynamic zal_title;
@dynamic ext_id;
@dynamic cinema;
@dynamic movie;

+ (Afisha *)newAfishaObject:(NSManagedObjectContext *)moc {
    Afisha *afisha = [[[Afisha alloc] initWithEntity:[NSEntityDescription entityForName:@"Afisha"
                                                              inManagedObjectContext:moc]
                   insertIntoManagedObjectContext:moc] autorelease];
    return afisha;
}

+ (Afisha *)afishaExistForId:(NSNumber *)extId withContext:(NSManagedObjectContext *)moc{
    Afisha *afisha = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Movie"
                                        inManagedObjectContext:moc]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"ext_id = %@", extId]];
    [fetchRequest setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release]; fetchRequest = nil;
    if (results && ([results count] > 0)) {
        afisha = [results objectAtIndex:0];
    }
    return afisha;
}

+ (BOOL)createOrReplaceFromDictionary:(NSDictionary *)afishaInfo withContext:(NSManagedObjectContext *)moc {
    Afisha *afisha = nil;
    NSNumber *extId = nil;
    if ([[afishaInfo objectForKey:@"id"] isKindOfClass:[NSString class]]) {
        extId = [[afishaInfo objectForKey:@"id"] numericValue];
    } else {
        extId = [afishaInfo objectForKey:@"id"];
    }
    
    afisha = [self afishaExistForId:extId withContext:moc];
    
    if (nil == afisha) {
        afisha = [Afisha newAfishaObject:moc];
        afisha.ext_id = extId;
    }
    
    if (![[afishaInfo objectForKey:@"zal_title"] isKindOfClass:[NSNull class]]){
        afisha.zal_title = [afishaInfo objectForKey:@"zal_title"];
    }
    if (![[afishaInfo objectForKey:@"times"] isKindOfClass:[NSNull class]]){
        afisha.times = [afishaInfo objectForKey:@"times"];
    }
    if (![[afishaInfo objectForKey:@"prices"] isKindOfClass:[NSNull class]]){
        afisha.prices = [afishaInfo objectForKey:@"prices"];
    }
        
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (![[afishaInfo objectForKey:@"date_begin"] isKindOfClass:[NSNull class]]){
        afisha.data_begin = [dateFormat dateFromString:[afishaInfo objectForKey:@"date_begin"]];
    }
    if (![[afishaInfo objectForKey:@"date_end"] isKindOfClass:[NSNull class]]){
        afisha.data_end = [dateFormat dateFromString:[afishaInfo objectForKey:@"date_end"]];
    }
    
    [dateFormat release];
    
    if (![[afishaInfo objectForKey:@"theater_id"] isKindOfClass:[NSNull class]]){
        NSNumber *theater_id = nil;
        if ([[afishaInfo objectForKey:@"theater_id"] isKindOfClass:[NSString class]]) {
            theater_id = [[afishaInfo objectForKey:@"theater_id"] numericValue];
        } else {
            theater_id = [afishaInfo objectForKey:@"theater_id"];
        }
        Movie *movie = [Movie movieExistForId:theater_id withContext:moc];
        if (nil != movie){
            afisha.movie = movie;
        }
    }
    
    if (![[afishaInfo objectForKey:@"cinema_id"] isKindOfClass:[NSNull class]]){
        NSNumber *cinema_id = nil;
        if ([[afishaInfo objectForKey:@"cinema_id"] isKindOfClass:[NSString class]]) {
            cinema_id = [[afishaInfo objectForKey:@"cinema_id"] numericValue];
        } else {
            cinema_id = [afishaInfo objectForKey:@"cinema_id"];
        }
        Cinema *cinema = [Cinema cinemaExistForId:cinema_id withContext:moc];
        if (nil != cinema){
            afisha.cinema = cinema;
        }
    }

    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Error save to database : %@", [error userInfo]);
        return false;
    }
    
    return true;
}

@end
