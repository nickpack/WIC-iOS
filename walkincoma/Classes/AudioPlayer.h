//
//  AudioPlayer.h
//  Walk in Coma
//
//  Created by Nikki Pack on 01/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@class AudioStreamer;

@interface AudioPlayer : UIViewController
{
	IBOutlet UIButton *button;
	NSTimer *levelMeterUpdateTimer;
	TTImageView *imageView;
    AudioStreamer *streamer;
}
@property (nonatomic,retain) TTImageView* imageView;

- (IBAction)buttonPressed:(id)sender;
- (void)spinButton;

@end

