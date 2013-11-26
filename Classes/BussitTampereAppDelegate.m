//
//  BussitTampereAppDelegate.m
//  BussitTampere
//
//  Created by Mikko Junnila on 26/01/2011.
//

#import "BussitTampereAppDelegate.h"
#import "BussitTampereViewController.h"
#import "BussiItem.h"

@implementation BussitTampereAppDelegate

@synthesize window;
@synthesize mapViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window addSubview:mapViewController.view];
    [self.window makeKeyAndVisible];
    [mapViewController mapView:mapViewController.mapView regionDidChangeAnimated:NO];
    
    return YES;
}

- (void)dealloc
{
    [window release];
    [super dealloc];
}


@end
