//
//  PViewController.h
//  RSSchool_T8
//
//  Created by Katya Railian on 19.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// MARK: Protocols

@protocol EventsDelegate
@optional

- (void)setColors:(UIColor *)firstColor second:(UIColor *)secondColor third:(UIColor*)thirdColor;

@end

@protocol TimerDelegate
@optional

- (void)setTime:(float) time;

@end

@protocol DrawingDelegate
@optional

- (void)setDrawingPath:(int) imageNumber;

@end

// MARK: Interface

@interface PViewController : UIViewController

@property (weak, nonatomic) id<EventsDelegate> delegate;

- (void)setUpController;
- (void)hideContentController;

@end

NS_ASSUME_NONNULL_END
