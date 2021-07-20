//
//  ViewController.m
//  RSSchool_T8
//
//  Created by Katya Railian on 18.07.2021.
//

#import "ViewController.h"
#import "RSSchool_T8-Swift.h"
#import <QuartzCore/QuartzCore.h>
#import "Button.h"
#import "ArtistView.h"
#import "Lineart.h"
#import "PViewController.h"

@interface ViewController () <EventsDelegate, TimerDelegate, DrawingDelegate>

@property (nonatomic, strong) Button *drawButton;
@property (nonatomic, strong) Button *shareButton;
@property (nonatomic, strong) Button *openTimerButton;
@property (nonatomic, strong) Button *openPaletteButton;
@property (nonatomic, strong) Button *resetButton;
@property (nonatomic, strong) ArtistView *canvas;
@property (nonatomic, strong) PViewController *paletteViewController;
@property (nonatomic, strong) DrawingsViewController *drawinsViewController;
@property (nonatomic, strong) TimerViewController *timeVCSWIFT;
@property (nonatomic, strong) NSTimer *timer;
@property float seconds;
@property float animationDuration;
@property int imageNumber;
@property (nonatomic, strong) UIImage *imageVC;
@property (nonatomic, strong) Button *saveButton;
@property (nonatomic, strong) UIColor *firstColor;
@property (nonatomic, strong) UIColor *secondColor;
@property (nonatomic, strong) UIColor *thirdColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPropertiesAndUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.toolbarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)setPropertiesAndUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.firstColor = [UIColor colorNamed:@"Black"];
    self.secondColor = [UIColor colorNamed:@"Black"];
    self.thirdColor = [UIColor colorNamed:@"Black"];
    self.animationDuration = 1.0;
    self.imageNumber = 1;
    
    self.navigationItem.title = @"Artist";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Drawings" style:UIBarButtonItemStylePlain target:self action:@selector(nextScreen:)];

    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Montserrat-Regular" size:17], NSFontAttributeName, [UIColor colorNamed:@"Black"], NSForegroundColorAttributeName, nil] ];

    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Montserrat-Regular" size:17], NSFontAttributeName,
        [UIColor colorNamed:@"Light Green Sea"], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    self.resetButton = [[Button alloc] initWithFrame:CGRectMake(243, 452, 91, 32)];
    [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [self.resetButton addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
    self.resetButton.hidden = YES;
    self.drawButton = [[Button alloc] initWithFrame:CGRectMake(243, 452, 91, 32)];
    [self.drawButton setTitle:@"Draw" forState:UIControlStateNormal];
    [self.drawButton addTarget:self action:@selector(draw:) forControlEvents:UIControlEventTouchUpInside];
    
    self.openPaletteButton = [[Button alloc] initWithFrame:CGRectMake(20, 452, 163, 32)];
    [self.openPaletteButton setTitle:@"Open Palette" forState:UIControlStateNormal];
    [self.openPaletteButton addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
    
    self.openTimerButton = [[Button alloc] initWithFrame:CGRectMake(20, 504, 151, 32)];
    [self.openTimerButton setTitle:@"Open Timer" forState:UIControlStateNormal];
    [self.openTimerButton addTarget:self action:@selector(openTimer:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareButton = [[Button alloc] initWithFrame:CGRectMake(239, 504, 95, 32)];
    [self.shareButton setTitle:@"Share" forState:UIControlStateNormal];
    self.shareButton.enabled = NO;
    self.shareButton.layer.opacity = 0.5;
    [self.shareButton addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];

    NSArray *buttons = [[NSArray alloc] initWithObjects: self.drawButton, self.openPaletteButton, self.openTimerButton, self.shareButton, self.resetButton, nil];
    for (Button *button in buttons) {
        [button setupComponent];
        [self.view addSubview: button];
    }
    self.canvas = [[ArtistView alloc] initWithFrame:CGRectMake(38, 102, 300, 300)];
    [self.canvas setupComponent];
    [self.view addSubview: self.canvas];

    self.paletteViewController = [PViewController new];
    [self addChildViewController:self.paletteViewController];
    self.paletteViewController.delegate = self;
    [self.paletteViewController setUpController];

    self.saveButton = [[Button alloc] initWithFrame:CGRectMake(250, 20, 85, 32)];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(hidePalette) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setupComponent];

    self.timeVCSWIFT = [TimerViewController new];
    [self addChildViewController:self.timeVCSWIFT];
    self.timeVCSWIFT.delegate = self;
    [self.timeVCSWIFT setUp];

    self.drawinsViewController = [DrawingsViewController new];
    self.drawinsViewController.delegate = self;
}

- (void)nextScreen:(id) sender {
    [self.navigationController pushViewController:self.drawinsViewController animated:YES];
}

- (void)shareImage:(id)sender {
    self.imageVC = [self.canvas setImage];

    NSArray *images = @[self.imageVC];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:images applicationActivities:nil];
    activityVC.excludedActivityTypes = @[];
    activityVC.popoverPresentationController.sourceView = self.view;
    activityVC.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, 0, 0);
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)draw:(id) sender {
    self.openPaletteButton.layer.opacity = 0.5;
    self.openTimerButton.layer.opacity = 0.5;
    self.drawButton.layer.opacity = 0.5;
    self.drawButton.enabled = NO;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01  target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    self.seconds = self.animationDuration;

    self.openPaletteButton.enabled = NO;
    self.openTimerButton.enabled = NO;
    
    switch (self.imageNumber) {
        case 0:
            [self.canvas planetLineart:self.firstColor.CGColor secondColor:self.secondColor.CGColor thirdColor:self.thirdColor.CGColor lineWidth:1 duration:self.animationDuration];
            break;
        case 1:
            [self.canvas headLineart:self.firstColor.CGColor secondColor:self.secondColor.CGColor thirdColor:self.thirdColor.CGColor lineWidth:1 duration:self.animationDuration];
            break;
        case 2:
            [self.canvas treeLineart:self.firstColor.CGColor secondColor:self.secondColor.CGColor thirdColor:self.thirdColor.CGColor lineWidth:1 duration:self.animationDuration];
            break;
        case 3:
            [self.canvas landscapeLineart:self.firstColor.CGColor secondColor:self.secondColor.CGColor thirdColor:self.thirdColor.CGColor lineWidth:1 duration:self.animationDuration];
            break;
        default:
            break;
    }
}

- (void)updateTimer:(NSTimer *)drawingTimer {
    if (self.seconds > 0) {
        self.seconds -= 0.01;
    } else {
        [self.timer invalidate];

        self.drawButton.hidden = YES;
        self.resetButton.hidden = NO;
        self.shareButton.layer.opacity = 1;
        self.shareButton.enabled = YES;
    }
}

- (void)reset:(id)sender {
    self.openPaletteButton.layer.opacity = 1;
    self.openTimerButton.layer.opacity = 1;
    self.drawButton.layer.opacity = 1;
    self.shareButton.layer.opacity = 0.5;
    
    self.openPaletteButton.enabled = YES;
    self.openTimerButton.enabled = YES;
    self.drawButton.hidden = NO;
    self.resetButton.hidden = YES;
    self.shareButton.enabled = NO;
    self.drawButton.enabled = YES;

    [self.canvas.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (void)selectColor:(id)sender {
    [self.view addSubview:self.paletteViewController.view];
    [self.paletteViewController didMoveToParentViewController:self];
    [self.paletteViewController.view addSubview:self.saveButton];
}

- (void)setColors:(UIColor *)firstColor second:(UIColor *)secondColor third:(UIColor *)thirdColor {
    self.firstColor = firstColor;
    self.secondColor = secondColor;
    self.thirdColor = thirdColor;
}

- (void)openTimer:(id) sender {
    [self.view addSubview:self.timeVCSWIFT.view];
    [self.timeVCSWIFT didMoveToParentViewController:self];
    [self.saveButton addTarget:self action:@selector(hideTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.timeVCSWIFT.view addSubview:self.saveButton];
}

- (void)hidePalette {
    [self.paletteViewController hideContentController];
}

- (void)hideTimer {
    [self.timeVCSWIFT onSaveButtonTap];
    [self.timeVCSWIFT hideContentController];
}

- (void)setTime:(float) time {
    self.animationDuration = time;
}

- (void)setDrawingPath:(int) pathIndex {
    self.imageNumber = pathIndex;
}

@end
