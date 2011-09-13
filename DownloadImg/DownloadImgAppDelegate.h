//
//  DownloadImgAppDelegate.h
//  DownloadImg
//
//  Created by Dominic Chang on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownloadImgViewController;

@interface DownloadImgAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet DownloadImgViewController *viewController;

@end
