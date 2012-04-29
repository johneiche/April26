//
//  April26AppDelegate.h
//  April26
//
//  Created by John Eiche on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>  //needed for SystemSoundID
#import <MediaPlayer/MediaPlayer.h>	//needed for MPMoviePlayerController
@class View;

@interface April26AppDelegate : UIResponder <UIApplicationDelegate> {
    MPMoviePlayerController *controller;
    SystemSoundID sid;
    View *view;
    UIWindow *_window;
}

- (void) touchUpInside: (id) sender;

@property (strong, nonatomic) UIWindow *window;

@end
