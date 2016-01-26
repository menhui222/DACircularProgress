//
//  DALabeledCircularProgressView.m
//  DACircularProgressExample
//
//  Created by Josh Sklar on 4/8/14.
//  Copyright (c) 2014 Shout Messenger. All rights reserved.
//

#import "DALabeledCircularProgressView.h"

@implementation DALabeledCircularProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeLabel];
        [self addSubview:self.floatView];
        [self setup];
    }
    return self;
}
- (void)setProgress:(CGFloat)progress
{
    [super setProgress:progress];
    [self setup];
}
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [self setProgress:progress animated:animated initialDelay:0.0];
    [self setup];
}
- (void)setup
{
    CGRect rect = self.bounds;
    CGPoint centerPoint = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2.0f;
    
    BOOL clockwise = (self.clockwiseProgress != 0);
    
    CGFloat progress = MIN(self.progress, 1.0f - FLT_EPSILON);
    CGFloat radians = 0;
    if (clockwise) {
        radians = (float)((progress * 2.0f * M_PI) - M_PI_2);
    } else {
        radians = (float)(3 * M_PI_2 - (progress * 2.0f * M_PI));
    }
    
    
    
    if (progress > 0.0f ) {
        CGFloat pathWidth = radius * self.thicknessRatio;
        CGFloat xOffset = radius * (1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * cosf(radians)));
        CGFloat yOffset = radius * (1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * sinf(radians)));
        
        
        CGPoint endPoint = CGPointMake(xOffset, yOffset);
        
        CGRect endEllipseRect = (CGRect) {
            .origin.x = endPoint.x - pathWidth / 2.0f,
            .origin.y = endPoint.y - pathWidth / 2.0f,
            .size.width = pathWidth,
            .size.height = pathWidth
        };
        CGPoint endPoint1 = CGPointMake(endEllipseRect.origin.x + pathWidth/2, endEllipseRect.origin.y +pathWidth/2);
        self.floatView.center = endPoint1;
        self.floatView.bounds = CGRectMake(0, 0, pathWidth+20, pathWidth+20);
        CGFloat p = self.progress;
        self.progressLabel.text = [NSString stringWithFormat:@"%.f%%",(p * 100)];
        
    }
}
#pragma mark - Internal methods

/**
 Creates and initializes
 -[DALabeledCircularProgressView progressLabel].
 */
- (void)initializeLabel
{
    self.progressLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.progressLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressLabel];
}
- (UIImageView *)floatView
{
    if (!_floatView) {
        _floatView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb-kcxq-ys"]];
        
    }
    return _floatView;
    
}

@end
