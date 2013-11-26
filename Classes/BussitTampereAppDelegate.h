//
//  BussitTampereAppDelegate.h
//  BussitTampere
//
//  Created by Mikko Junnila on 26/01/2011.
//

#import <UIKit/UIKit.h>

@class BussitTampereViewController;

@interface BussitTampereAppDelegate : NSObject <UIApplicationDelegate>
{
    BussitTampereViewController *mapViewController;
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BussitTampereViewController *mapViewController;

@end

