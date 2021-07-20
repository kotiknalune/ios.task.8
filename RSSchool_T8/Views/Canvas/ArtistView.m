//
//  ArtistView.m
//  RSSchool_T8
//
//  Created by Katya Railian on 18.07.2021.
//

#import "ArtistView.h"

@implementation ArtistView

- (void)setupComponent {
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [[UIColor colorNamed:@"Chill Sky"] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.25f;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowRadius = 8.0;
}

-(UIImage *)setImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 300), self.opaque, 0.0f);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    
    UIImage *imageFromView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageFromView;
}

@end
