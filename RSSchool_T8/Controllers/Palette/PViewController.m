//
//  PViewController.m
//  RSSchool_T8
//
//  Created by Katya Railian on 19.07.2021.
//

#import "ViewController.h"
#import "PViewController.h"
#import "Button.h"

@interface PViewController ()

@property (nonatomic, strong) Button *saveButton;
@property (nonatomic, strong) NSMutableArray<Button *> *selectedColors;

@property (nonatomic, strong) NSArray<UIColor *> *colors;
@property (nonatomic, strong) UIColor *firstColor;
@property (nonatomic, strong) UIColor *secondColor;
@property (nonatomic, strong) UIColor *thirdColor;
@property (nonatomic, strong) UIColor *blackColor;

@property (nonatomic, strong) NSTimer *timer;
@property int counter;

@end


@implementation PViewController

- (void)setUpController {
    self.view.frame = CGRectMake(0, 333, 375, 383.5);
    self.view.backgroundColor = [UIColor whiteColor];
    
    CATransition *transition = [CATransition animation];
    
    transition.duration = 1;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.view.layer addAnimation:transition forKey:nil];
    
    self.view.layer.cornerRadius = 40;
    self.view.layer.masksToBounds = NO;
    self.view.layer.shadowColor = [UIColor colorNamed:@"Black"].CGColor;
    self.view.layer.shadowOpacity = 0.25f;
    self.view.layer.shadowRadius = 2.0;
    self.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.counter = 0;
    self.selectedColors = [NSMutableArray arrayWithCapacity:3];

    self.blackColor = [UIColor colorNamed:@"Black"];
    
    self.firstColor = self.blackColor;
    self.secondColor = self.blackColor;
    self.thirdColor = self.blackColor;
    
    self.colors = @[
        [UIColor colorNamed:@"Red"],
        [UIColor colorNamed:@"DarkPurple"],
        [UIColor colorNamed:@"Green"],
        [UIColor colorNamed:@"Grey"],
        [UIColor colorNamed:@"Purple"],
        [UIColor colorNamed:@"Orange"],
        [UIColor colorNamed:@"Yellow"],
        [UIColor colorNamed:@"Sky"],
        [UIColor colorNamed:@"Pink"],
        [UIColor colorNamed:@"DarkGrey"],
        [UIColor colorNamed:@"DarkGreen"],
        [UIColor colorNamed:@"Brown"]];
    
    [self createShaders];
}

- (void)createShaders {
    int margin = 0;
    int side = 40;
    
    for (int i = 0; i < 12; i++) {
        Button *colorButton;
        
        if (i == 6) {
            margin = 0;
        }
        
        if (i < 6) {
            colorButton = [[Button alloc] initWithFrame:CGRectMake(17 + margin, 92, side, side)];
        } else {
            colorButton = [[Button alloc] initWithFrame:CGRectMake(17 + margin, 152, side, side)];
        }
    
        [colorButton setupComponent];
    
        UIView *innerColorView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, 24, 24)];
    
        innerColorView.backgroundColor = self.colors[i];
        innerColorView.layer.cornerRadius = 6;
        innerColorView.userInteractionEnabled = NO;
    
        colorButton.tag = i;
    
        [colorButton addSubview:innerColorView];
        [self.view addSubview:colorButton];
        [colorButton addTarget:self action:@selector(pickColor:) forControlEvents:UIControlEventTouchUpInside];
    
        margin += 60;
    }
}

- (void)pickColor:(Button*)sender {
    if ([self.selectedColors containsObject:sender]) {
        self.counter--;
        sender.subviews[1].frame = CGRectMake(8, 8, 24, 24);
        
        if (self.firstColor == self.colors[sender.tag]) {
            self.firstColor = self.blackColor;
        
        } else if (self.secondColor == self.colors[sender.tag]) {
            self.secondColor = self.blackColor;

        } else {
            self.thirdColor = self.blackColor;
        }
            
        [self.selectedColors removeObject:sender];
        
    } else {
        self.counter++;
        
        switch (self.counter) {
            case 1:
                if (self.selectedColors.count > 1) {
                    self.selectedColors[0].subviews[1].frame = CGRectMake(8, 8, 24, 24);
                    [self.selectedColors removeObjectAtIndex:0];
                }
                
                self.firstColor = self.colors[sender.tag];
                sender.subviews[1].frame = CGRectMake(2, 2, 36, 36);

                self.view.backgroundColor = self.colors[sender.tag];
                
                if (self.timer.isValid) [self.timer invalidate];
                            
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setDefaultBackgroundColor) userInfo:nil repeats:NO];
                
                [self.selectedColors insertObject:sender atIndex:0];
                break;
                
            case 2:
                if (self.selectedColors.count > 1) {
                    self.selectedColors[1].subviews[1].frame = CGRectMake(8, 8, 24, 24);
                    [self.selectedColors removeObjectAtIndex:1];
                }
                
                self.secondColor = self.colors[sender.tag];
                sender.subviews[1].frame = CGRectMake(2, 2, 36, 36);

                self.view.backgroundColor = self.colors[sender.tag];
                
                if (self.timer.isValid) [self.timer invalidate];
                            
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setDefaultBackgroundColor) userInfo:nil repeats:NO];
                
                [self.selectedColors insertObject:sender atIndex:1];
                break;
                
            case 3:
                if (self.selectedColors.count > 2) {
                    self.selectedColors[2].subviews[1].frame = CGRectMake(8, 8, 24, 24);
                    [self.selectedColors removeObjectAtIndex:2];
                }
                
                self.thirdColor = self.colors[sender.tag];
                sender.subviews[1].frame = CGRectMake(2, 2, 36, 36);
                
                self.view.backgroundColor = self.colors[sender.tag];
                
                if (self.timer.isValid) [self.timer invalidate];
                    
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setDefaultBackgroundColor) userInfo:nil repeats:NO];
                
                [self.selectedColors insertObject:sender atIndex:2];
                self.counter = 0;
                
                break;
            default:
                self.counter = 0;
                break;
        }
    }
    
}

- (void)setDefaultBackgroundColor {
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)hideContentController {
    [self.delegate setColors: self.firstColor second:self.secondColor third:self.thirdColor];
   
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
