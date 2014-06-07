//
//  ViewController.m
//  Mandolin
//
//  Created by Ariel Elkin on 28/12/2013.
//  Copyright (c) 2013 Bellpipe. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import "Mandolin.h"
#import "AEBlockChannel.h"

@implementation ViewController {
    AEBlockChannel *myMandolinChannel;
    stk::Mandolin *myMandolin;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSError *errorAudioSetup = NULL;
    BOOL result = [[appDelegate audioController] start:&errorAudioSetup];
    if ( !result ) {
        NSLog(@"Error starting audio engine: %@", errorAudioSetup.localizedDescription);
    }

    stk::Stk::setRawwavePath([[[NSBundle mainBundle] pathForResource:@"rawwaves" ofType:@"bundle"] UTF8String]);

    myMandolin = new stk::Mandolin(400);
    myMandolin->setFrequency(400);

    myMandolinChannel = [AEBlockChannel channelWithBlock:^(const AudioTimeStamp  *time,
                                                           UInt32 frames,
                                                           AudioBufferList *audio) {
        for ( int i=0; i<frames; i++ ) {

            ((float*)audio->mBuffers[0].mData)[i] =
            ((float*)audio->mBuffers[1].mData)[i] = myMandolin->tick();

        }
    }];

    [[appDelegate audioController] addChannels:@[myMandolinChannel]];
}

- (IBAction)pluckMyMandolin {
    myMandolin->pluck(1);
}

- (IBAction)changeFrequency:(UISlider *)sender {
    myMandolin->setFrequency(sender.value);
}

@end
