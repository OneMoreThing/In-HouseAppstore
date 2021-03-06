//
//  AppDelegate.m
//  In-HouseAppstore
//
//  Created by Charles Burgess on 8/22/12.
//  Copyright (c) 2012 SquareOne Apps. All rights reserved.
//

#import "AppDelegate.h"
#define IS_IPAD   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //Fetch the .plist that has all of your store data in it... see sample.plist for an example
    NSString *path = @"http://yoursite.com/apps/store.plist";
    NSURL *url = [NSURL URLWithString:path];
    
    _storeData = [[NSDictionary alloc] initWithContentsOfURL:url];
    NSMutableArray *mapps = [[NSMutableArray alloc] initWithArray:[_storeData objectForKey:@"apps"]];
    
    NSString *deviceToRemove = @"";
    if (IS_IPAD)
    {
        deviceToRemove = @"iPhone";
    }
    else
    {
        deviceToRemove = @"iPad";
    }
    
    int i = 0;
    while (i<[mapps count])
    {
        if ([[[mapps objectAtIndex:i] objectForKey:@"device"] isEqualToString:deviceToRemove])
        {
            [mapps removeObjectAtIndex:i];
        }
        else
        {
            i++;
        }
    }
    
    [self setApps:mapps];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
