//
//  AppDelegate.m
//  RSSchool_T8
//
//  Created by Katya Railian on 18.07.2021.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RSSchool_T8-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIView appearance].tintColor = [UIColor colorNamed:@"Light Green Sea"];
    UIWindow *window = [UIWindow new];
    UIViewController *VC = [ViewController new];
    
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:VC];
            
    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
