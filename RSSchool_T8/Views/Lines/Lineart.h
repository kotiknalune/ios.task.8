//
//  Lineart.h
//  RSSchool_T8
//
//  Created by Katya Railian on 19.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(AnimatedLines)

- (void)headLineart:(CGColorRef)lineColor secondColor:(CGColorRef)secondLineColor thirdColor:(CGColorRef)thirdLineColor lineWidth:(CGFloat)lineWidth duration:(CGFloat)duration;

- (void)treeLineart:(CGColorRef)lineColor secondColor:(CGColorRef)secondLineColor thirdColor:(CGColorRef)thirdLineColor lineWidth:(CGFloat)lineWidth duration:(CGFloat)duration;

- (void)landscapeLineart:(CGColorRef)lineColor secondColor:(CGColorRef)secondLineColor thirdColor:(CGColorRef)thirdLineColor lineWidth:(CGFloat)lineWidth duration:(CGFloat)duration;

- (void)planetLineart:(CGColorRef)lineColor secondColor:(CGColorRef)secondLineColor thirdColor:(CGColorRef)thirdLineColor lineWidth:(CGFloat)lineWidth duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
