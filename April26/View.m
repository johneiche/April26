//
//  View.m
//  April26
//
//  Created by John Eiche on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

@synthesize button;
@synthesize buttonVideo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        //center the button in the view
        CGRect b = self.bounds;
        NSString *string = @"Chinese sound effect";
        
        
        //CGSize s = [string sizeWithFont:[UIFont systemFontOfSize: 16]];
        CGSize s = [string sizeWithFont:[UIFont systemFontOfSize:[UIFont buttonFontSize]]];        
        
        // CGSize s = CGSizeMake(200, 40); //size of button
        
        button.frame = CGRectMake(b.origin.x + (b.size.width - s.width) / 2, 
                                  b.origin.y + (b.size.height - s.height) / 2,
                                  s.width, 
                                  s.height);
        
        [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal]; 
        [button setTitle: string forState: UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed: 1.0 green:0.0 blue: 0.0 alpha: 0.5] forState: UIControlStateDisabled];
        
        [button addTarget: [UIApplication sharedApplication].delegate
                   action: @selector(touchUpInside:)
         forControlEvents: UIControlEventTouchUpInside ];
        
        [self addSubview: button];
        
        
        // button for video
         
         buttonVideo = [UIButton buttonWithType: UIButtonTypeRoundedRect];
         
         //Center the button in the view.
         //CGSize s = CGSizeMake(200, 40);	//size of button
         NSString *stringVideo = @"Fred Ott's Sneeze";
         //[buttonVideo setTitle: @"Fred Ott’s Sneeze"
         CGSize sVideo = [stringVideo sizeWithFont:[UIFont systemFontOfSize:[UIFont buttonFontSize]]];
         //CGRect b = self.bounds;
         
         buttonVideo.frame = CGRectMake(
         b.origin.x + (b.size.width - sVideo.width) / 2,
         b.origin.y + (b.size.height - sVideo.height) / 2 + s.height + 5,
         sVideo.width,
         sVideo.height
         );
         
         [buttonVideo setTitleColor: [UIColor redColor]
         forState: UIControlStateNormal];
         
         [buttonVideo setTitle: @"Fred Ott’s Sneeze"
         forState: UIControlStateNormal];
         
         [buttonVideo setTitleColor:[UIColor colorWithRed: 1.0 green:0.0 blue: 0.0 alpha: 0.5] 
         forState: UIControlStateDisabled];
         
         [buttonVideo addTarget: [UIApplication sharedApplication].delegate
         action: @selector(touchUpInsideVideo:)
         forControlEvents: UIControlEventTouchUpInside
         ];
         
         [self addSubview: buttonVideo];
        
       // */
    }
    return self;
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
