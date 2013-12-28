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

@interface ViewController ()
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
