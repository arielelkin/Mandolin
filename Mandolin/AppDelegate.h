//
//  AppDelegate.h
//  Mandolin
//
//  Created by Ariel Elkin on 28/12/2013.
//  Copyright (c) 2013 Bellpipe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEAudioController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) AEAudioController *audioController;

@end
