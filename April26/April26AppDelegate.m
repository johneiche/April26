//
//  April26AppDelegate.m
//  April26
//
//  Created by John Eiche on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "April26AppDelegate.h"
#import "View.h"

//Called when the sound has finished playing.

static void complete(SystemSoundID sid, void *p)
{
	UIButton *button = (__bridge UIButton *)p;
	button.enabled = YES;
}


@implementation April26AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NSBundle *bundle = [NSBundle mainBundle];
    NSLog(@"bundle.bundlePath == \"%@\"", bundle.bundlePath);
    
    NSString *filename = [bundle pathForResource: @"chinese"  ofType: @"mp3"];
    NSLog(@"filename == \"%@\"", filename);
    
    NSURL *url = [NSURL fileURLWithPath: filename isDirectory: NO];
    NSLog(@"url == \"%@\"", url);
    
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &sid);
	if (error != kAudioServicesNoError) {
		NSLog(@"AudioServicesCreateSystemSoundID error == %ld", error);
	}  
   
    NSString *filenameVideo = [bundle pathForResource: @"sneeze" ofType: @"m4v"];
	if (filenameVideo == nil) {
		NSLog(@"could not find file sneeze.m4v");
		return YES;
	}
    
	NSURL *urlVideo = [NSURL fileURLWithPath: filenameVideo];
	if (urlVideo == nil) {
		NSLog(@"could not create URL for file %@", filenameVideo);
		return YES;
	}
    
	controller = [[MPMoviePlayerController alloc] init];
	if (controller == nil) {
		NSLog(@"could not create MPMoviePlayerController");
		return YES;
	}
    
	controller.shouldAutoplay = NO; //don't start spontaneously
	controller.scalingMode = MPMovieScalingModeNone;
	controller.controlStyle = MPMovieControlStyleFullscreen;
	controller.movieSourceType = MPMovieSourceTypeFile; //vs. stream
	[controller setContentURL: url];
    
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	
	[center
     addObserver: self
     selector: @selector(playbackDidFinish:)
     name: MPMoviePlayerPlaybackDidFinishNotification
     object: controller
     ];
    
    UIScreen *screen = [UIScreen mainScreen];
    view = [[View alloc] initWithFrame: screen.applicationFrame];
    self.window = [[UIWindow alloc] initWithFrame: screen.bounds];
    
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window addSubview: view];
    
    
    error = AudioServicesAddSystemSoundCompletion(
                                                  sid, NULL, NULL, complete,
                                                  (__bridge void *)view.button);
    
    if (error != kAudioServicesNoError) {
        NSLog(@"AudioServicesAddSystemSoundCompletion error == %ld",
              error);
        return YES;
    }
    return YES;
}

    
    - (void) touchUpInside:(id)sender {
        // the sender is the button that was pressed
        
        NSLog(@"the \"%@\" button was pressed.", 
              [sender titleForState: UIControlStateNormal ]);   
        
        ((UIButton *)sender).enabled = NO;
        //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(sid);
        
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Application delegate is target of button.

- (void) touchUpInsideVideo: (id) sender {
	//sender is the button.
	controller.view.frame = view.frame;
	[view removeFromSuperview];
	[self.window addSubview: controller.view];
	[controller play];
}

#pragma mark -
#pragma mark Application delegate is observer of MPMoviePlayerController.

- (void) playbackDidFinish: (NSNotification *) notification {
	//notification.object is the movie player controller.
	[controller.view removeFromSuperview];
	[UIApplication sharedApplication].statusBarHidden = NO;
	[self.window addSubview: view];
}

@end
