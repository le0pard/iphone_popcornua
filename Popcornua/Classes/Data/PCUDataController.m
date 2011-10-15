//
//  PCUDataController.m
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PCUDataController.h"
#import <unistd.h>

@implementation PCUDataController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)cleanupData{
    //hudView.labelText = NSLocalizedString(@"Cleanup data", @"");
    PCUSharedManager *myStoreManager = [PCUSharedManager sharedManager];
    NSManagedObjectContext *moc = myStoreManager.managedObjectContext;
    
    NSError * clear_error = nil;
    
    /* cleanup data */
    NSFetchRequest * allAfisha = [[NSFetchRequest alloc] init];
    [allAfisha setEntity:[NSEntityDescription entityForName:@"Afisha" inManagedObjectContext:moc]];
    [allAfisha setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSArray * afishas = [moc executeFetchRequest:allAfisha error:&clear_error];
    [allAfisha release];
    //error handling goes here
    for (Afisha *afisha in afishas) {
        [moc deleteObject:afisha];
    }
    
    /* cleanup data */
    NSFetchRequest * allCinema = [[NSFetchRequest alloc] init];
    [allCinema setEntity:[NSEntityDescription entityForName:@"Cinema" inManagedObjectContext:moc]];
    [allCinema setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSArray * cinemas = [moc executeFetchRequest:allCinema error:&clear_error];
    [allCinema release];
    //error handling goes here
    for (Cinema *cinema in cinemas) {
        [moc deleteObject:cinema];
    }
    
    /* cleanup data */
    NSFetchRequest * allMovies = [[NSFetchRequest alloc] init];
    [allMovies setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:moc]];
    [allMovies setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSArray * movies = [moc executeFetchRequest:allMovies error:&clear_error];
    [allMovies release];
    //error handling goes here
    for (Movie *movie in movies) {
        [moc deleteObject:movie];
    }
}


- (void) syncCoreData{
    PCUSharedManager *myStoreManager = [PCUSharedManager sharedManager];
    NSError *error = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cityId = [defaults stringForKey:@"selectCity"];
    if (!cityId){
        cityId = @"1";
    }
    
    hudView.labelText = NSLocalizedString(@"Updating cinemas", @"");

    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:POPCORN_CINEMAS_URL, cityId, POPCORN_SECRET]]];
	[request setRequestMethod:@"GET"];
    [request addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"iphone-app/%@",@"1.0"]];
    [request setTimeOutSeconds:4];
    [request setNumberOfTimesToRetryOnTimeout:3];
	[request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        //NSLog(@"Data: %@", response);
        NSDictionary *json_data = [response JSONValue];
        NSArray *theaters = [json_data objectForKey:@"theaters"];
        
        for (NSDictionary *theater in theaters) {
            if ([Cinema createOrReplaceFromDictionary:theater withContext:myStoreManager.managedObjectContext]){
                //
            }
        }
        
    }
    
    hudView.labelText = NSLocalizedString(@"Updating movies", @"");
    
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:POPCORN_MOVIES_URL, cityId, POPCORN_SECRET]]];
	[request setRequestMethod:@"GET"];
    [request addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"iphone-app/%@",@"1.0"]];
    [request setTimeOutSeconds:4];
    [request setNumberOfTimesToRetryOnTimeout:3];
	[request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSDictionary *json_data = [response JSONValue];
        NSArray *movies = [json_data objectForKey:@"cinemas"];
        for (NSDictionary *movie in movies) {
            if ([Movie createOrReplaceFromDictionary:movie withContext:myStoreManager.managedObjectContext]){
                //
            }
        }
        NSArray *afishas = [json_data objectForKey:@"afisha"];
        for (NSDictionary *afisha in afishas) {
            if ([Afisha createOrReplaceFromDictionary:afisha withContext:myStoreManager.managedObjectContext]){
                //
            }
        }
    }
    
    hudView.labelText = NSLocalizedString(@"Delete trash", @"");
    
    // Define range of dates
    NSError * clear_error = nil;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];    
    NSDateFormatter *formatterTemp = [[NSDateFormatter alloc] init];
    [formatterTemp setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSData *dataBegin = (NSData *)[formatter dateFromString:[formatterTemp stringFromDate:date]];
    [formatterTemp release];
    [formatter release];
    
    NSFetchRequest * allAfisha = [[NSFetchRequest alloc] init];
    [allAfisha setEntity:[NSEntityDescription entityForName:@"Afisha" inManagedObjectContext:myStoreManager.managedObjectContext]];
    [allAfisha setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    [allAfisha setPredicate:[NSPredicate predicateWithFormat:@"data_end < %@", dataBegin]];
    NSArray * afishas = [myStoreManager.managedObjectContext executeFetchRequest:allAfisha error:&clear_error];
    [allAfisha release];
    //error handling goes here
    for (Afisha *afisha in afishas) {
        [myStoreManager.managedObjectContext deleteObject:afisha];
    }

    
    NSFetchRequest * allMovies = [[NSFetchRequest alloc] init];
    [allMovies setEntity:[NSEntityDescription entityForName:@"Movie" inManagedObjectContext:myStoreManager.managedObjectContext]];
    [allMovies setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSArray * movies = [myStoreManager.managedObjectContext executeFetchRequest:allMovies error:&clear_error];
    [allMovies release];
    //error handling goes here
    for (Movie *movie in movies) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"Afisha"
                                            inManagedObjectContext:myStoreManager.managedObjectContext]];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"movie == %@", movie]];
        NSError *error = nil;
        NSArray *results = [myStoreManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        [fetchRequest release]; 
        fetchRequest = nil;
        if (results && [results count] == 0) {
            [myStoreManager.managedObjectContext deleteObject:movie];
        }
    }
    
    [myStoreManager release];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTableViews" object:self];
}



- (void)startSyncData:(UIWindow *)window{
    mainWindow = window;
    hudView = [[MBProgressHUD alloc] initWithWindow:mainWindow];
	[mainWindow addSubview:hudView];
	hudView.dimBackground = YES;	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
    hudView.delegate = nil;
    hudView.labelText = NSLocalizedString(@"Loading", @"");
    hudView.detailsLabelText = NSLocalizedString(@"updating program data", @"");
    hudView.removeFromSuperViewOnHide = true;
    // Show the HUD while the provided method executes in a new thread
    [hudView showWhileExecuting:@selector(syncCoreData) onTarget:self withObject:nil animated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hudView release];
	hudView = nil;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [super dealloc];
}

@end
