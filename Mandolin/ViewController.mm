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

@interface ViewController ()
@property (nonatomic) AEBlockChannel *myMandolinChannel;
@property (nonatomic) stk::Mandolin *myMandolin;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSError *errorAudioSetup = NULL;
    BOOL result = [[appDelegate audioController] start:&errorAudioSetup];
    if ( !result ) {
        NSLog(@"Error starting audio engine: %@", errorAudioSetup.localizedDescription);
    }

    stk::Stk::setRawwavePath([[[NSBundle mainBundle] resourcePath] UTF8String]);
    
    self.myMandolin = new stk::Mandolin(400);
    self.myMandolin->setFrequency(400);
    
    self.myMandolinChannel = [AEBlockChannel channelWithBlock:^(const AudioTimeStamp  *time,
                                                                UInt32 frames,
                                                                AudioBufferList *audio) {
        for ( int i=0; i<frames; i++ ) {
            
            ((float*)audio->mBuffers[0].mData)[i] =
            ((float*)audio->mBuffers[1].mData)[i] = self.myMandolin->tick();
            
        }
    }];
    
    [[appDelegate audioController] addChannels:@[self.myMandolinChannel]];

}

-(IBAction)pluckMyMandolin{
    self.myMandolin->pluck(1);
}

-(IBAction)changeFrequency:(UISlider *)sender{
    self.myMandolin->setFrequency(sender.value);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
