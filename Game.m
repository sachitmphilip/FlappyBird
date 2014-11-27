//
//  Game.m
//  FlappyBird
//
//  Created by enterpi on 7/23/14.
//  Copyright (c) 2014 enterpi. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game
{
      AVAudioPlayer *avPlayer;
}


-(void)GameOver
{
    gameOverLabel.hidden = NO;
    if (ScoreNumber > HighScoreNumber)
    {
        [[NSUserDefaults standardUserDefaults]setInteger:ScoreNumber forKey:@"HighScoreSaved"];
    }
    
    
    [TunnelMovement invalidate];
    [BirdMovement invalidate];
    
    Exit.hidden = NO;
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    Bird.hidden = YES;
    [avPlayer stop];
}
-(void)Score
{
    ScoreNumber= ScoreNumber + 1;
    ScoreLabel.text = [NSString stringWithFormat:@"%i",ScoreNumber];
}


-(IBAction)StartGame:(id)sender
{
    gameOverLabel.hidden = YES;
    TunnelTop.hidden = NO;
    TunnelBottom.hidden = NO;
    startGame.hidden = YES;
    
    BirdMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BirdMoving) userInfo:nil repeats:YES];
    
    [self PlaceTunnels];
    TunnelMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(TunnelMoving) userInfo:nil repeats:YES];
    
    
    
}
-(void)TunnelMoving
{
    TunnelTop.center = CGPointMake(TunnelTop.center.x - 1, TunnelTop.center.y);
    TunnelBottom.center = CGPointMake(TunnelBottom.center.x - 1, TunnelBottom.center.y);
    
    if (TunnelTop.center.x < -28)
    {
        [self PlaceTunnels];
    }
    if (TunnelTop.center.x == 30)
    {
        [self Score];
    }
    
    
    
    if (CGRectIntersectsRect(Bird.frame, TunnelTop.frame))
    {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Bird.frame, TunnelBottom.frame))
    {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Bird.frame, Top.frame))
    {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Bird.frame, Bottom.frame))
    {
        [self GameOver];
    }
    
    
    
}

-(void)PlaceTunnels
{
    RandomTopTunnelPosition = arc4random() %350;
    RandomTopTunnelPosition = RandomTopTunnelPosition - 220;
    RandomBottomTunnelPosition = RandomTopTunnelPosition + 655;
    
    TunnelTop.center = CGPointMake(340, RandomTopTunnelPosition);
    TunnelBottom.center = CGPointMake(340, RandomBottomTunnelPosition);
    
}
-(void)BirdMoving
{
    
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFlight);
    BirdFlight = BirdFlight -5;
    
    if (BirdFlight < -15)
    {
        BirdFlight = -15;
    }
    
    if (BirdFlight > 0)
    {
        Bird.image = [UIImage imageNamed:@"Bird Up.png"];
    }
    if (BirdFlight < 0)
    {
        Bird.image = [UIImage imageNamed:@"Bird Down.png"];
    }
    
    
    
    
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
       BirdFlight = 25;
    
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"boeing-boeing-35" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    NSError *error;
    
    avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [avPlayer play];
    avPlayer.numberOfLoops = 1;
    gameOverLabel.hidden = YES;
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    
    Exit.hidden = YES;
    ScoreNumber = 0;
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"HighScoreSaved"];
    
    
    
    [super viewDidLoad];
    
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
