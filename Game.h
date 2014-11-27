//
//  Game.h
//  FlappyBird
//
//  Created by enterpi on 7/23/14.
//  Copyright (c) 2014 enterpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



int BirdFlight;
int RandomTopTunnelPosition;
int RandomBottomTunnelPosition;
int ScoreNumber;
NSInteger HighScoreNumber;


@interface Game : UIViewController
{
    IBOutlet UIImageView *Bird;
    IBOutlet UIButton *startGame;
    IBOutlet UIImageView *TunnelTop;
    IBOutlet UIImageView *TunnelBottom;
    IBOutlet UIImageView *Top;
    IBOutlet UIImageView *Bottom;
    IBOutlet UIButton *Exit;
    IBOutlet UILabel *ScoreLabel;
    IBOutlet UILabel *gameOverLabel;
    
    
    NSTimer *BirdMovement;
    NSTimer *TunnelMovement;
    
    
}
-(IBAction)StartGame:(id)sender;

-(void)BirdMoving;
-(void)TunnelMoving;
-(void)PlaceTunnels;
-(void)Score;
-(void)GameOver;








































@end
