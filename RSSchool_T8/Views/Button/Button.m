//
//  Button.m
//  RSSchool_T8
//
//  Created by Katya Railian on 18.07.2021.
//

#import "Button.h"

@implementation Button

- (void)setupComponent {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:18];
    [self setTitleColor:[UIColor colorNamed:@"Light Green Sea"] forState:UIControlStateNormal];
    
    [self setDefault];
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.masksToBounds = NO;
}

- (void)setDefault {
    self.layer.shadowColor = [[UIColor colorNamed:@"Black"] CGColor];
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 0.25f;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.layer.shadowColor = [UIColor colorNamed:@"Light Green Sea"].CGColor;
        self.layer.shadowRadius = 4.0;
        self.layer.shadowOpacity = 1;
    } else {
        [self setDefault];
    }
}

@end
