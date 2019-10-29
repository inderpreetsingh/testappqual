#import "UITableView+Placeholder.h"

@implementation UITableView (Placeholder)

int kplaceholderRightPadding = 30;
int kplaceholderleftPadding = 30;
int kplaceholdertopPadding = 30;
int kplaceholderbottomPadding = 30;


- (void) tableFloatingFromBootomAnimation
{
    [self reloadData];
    
    NSArray * cells = self.visibleCells;
    CGFloat tableHeight = self.bounds.size.height;
    
    for (UITableViewCell *cell in cells) {
        cell.transform = CGAffineTransformMakeTranslation(0, tableHeight);
    }
    
    int index = 0;
    
    for (UITableViewCell *cell in cells) {
        
        [UIView animateWithDuration:1.5 delay:0.05 * (index) usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            cell.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
        index += 1;
    }
}

- (void) tableFloatingFromTopAnimation
{
    [self reloadData];
    
    NSArray * cells = self.visibleCells;
    CGFloat tableHeight = -self.bounds.size.height;
    
    for (UITableViewCell *cell in cells) {
        cell.transform = CGAffineTransformMakeTranslation(0, tableHeight);
    }
    
    int index = 0;
    
    for (UITableViewCell *cell in cells) {
        
        [UIView animateWithDuration:1.5 delay:0.05 * (index) usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            cell.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
        index += 1;
    }
}

- (void) setLoaderAnimationWithText: (NSString*)string
{
    UILabel *blankMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinX(self.frame)+50, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2)];
    blankMessageLabel.numberOfLines = 10;
    blankMessageLabel.text = string;
    blankMessageLabel.textAlignment = NSTextAlignmentCenter;
    blankMessageLabel.textColor = [UIColor lightGrayColor];
    blankMessageLabel.font =  [UIFont fontWithName:@"Helvetica" size:22.0];
    
    UIView *animDots = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)/2 - 30), CGRectGetHeight(self.frame) - 260, 60, 30)];
    animDots.center=self.center;
    [self setupThreeBounceAnimationInLayer:animDots.layer
                                  withSize:animDots.frame.size
                                     color:[UIColor blackColor]];
    
    UIView *tblBackGroundView = [[UIView alloc] initWithFrame:self.frame];
    [tblBackGroundView addSubview:blankMessageLabel];
    [tblBackGroundView addSubview:animDots];
    
    [self setBackgroundView:tblBackGroundView];
    
//    tblBackGroundView.transform = CGAffineTransformMakeScale(2, 2);
//    tblBackGroundView.alpha = 0;
//    [UIView animateKeyframesWithDuration:.6 delay:0 options:0 animations:^{
//        
//        tblBackGroundView.transform = CGAffineTransformMakeScale(1, 1);
//        tblBackGroundView.alpha = 1;
//    } completion:^(BOOL finished) {
//        
//    }];
    
}

- (void)setBlankPlaceHolderWithString : (NSString*)string
{
    UILabel *blankMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x, 10, SCREEN_WIDTH, 50)];
    blankMessageLabel.numberOfLines = 0;
    blankMessageLabel.text = string;
    blankMessageLabel.textAlignment = NSTextAlignmentCenter;
    blankMessageLabel.textColor = [UIColor darkGrayColor];
    blankMessageLabel.font = [UIFont systemFontOfSize:15];
   // [blankMessageLabel sizeToFit];
   // blankMessageLabel.center=self.center;
    UIView *tblBackGroundView = [[UIView alloc] initWithFrame:self.frame];
    [tblBackGroundView addSubview:blankMessageLabel];    
    [self setBackgroundView:tblBackGroundView];
    tblBackGroundView.transform = CGAffineTransformMakeScale(2, 2);
    tblBackGroundView.alpha = 0;
    [UIView animateKeyframesWithDuration:.6 delay:0 options:0 animations:^{
        
        tblBackGroundView.transform = CGAffineTransformMakeScale(1, 1);
        tblBackGroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)setBlankPlaceHolderWithStringInFrame : (NSString*)string :(CGRect)frame
{
     UILabel *blankMessageLabel = [[UILabel alloc] initWithFrame:frame];
    blankMessageLabel.numberOfLines = 0;
    blankMessageLabel.text = string;
    blankMessageLabel.textAlignment = NSTextAlignmentCenter;
    blankMessageLabel.textColor = ThemeOrangeColor;
    blankMessageLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    [blankMessageLabel sizeToFit];
    blankMessageLabel.center=CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
     UIView *tblBackGroundView = [[UIView alloc] initWithFrame:frame];
    [tblBackGroundView addSubview:blankMessageLabel];    
    [self setBackgroundView:tblBackGroundView];
    tblBackGroundView.transform = CGAffineTransformMakeScale(2, 2);
    tblBackGroundView.alpha = 0;
    [UIView animateKeyframesWithDuration:.6 delay:0 options:0 animations:^{
        
        tblBackGroundView.transform = CGAffineTransformMakeScale(1, 1);
        tblBackGroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)setLoaderWithStringAccordingframe : (NSString*)string :(CGRect)frame
{
    UIView *vwfooter=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.alpha = 1.0;
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.color=[UIColor orangeColor];
    [activityIndicator startAnimating];
    
    activityIndicator.frame=CGRectMake(0,0, SCREEN_WIDTH, 25);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(activityIndicator.frame), SCREEN_WIDTH, 25)];
    label.textColor = [UIColor lightGrayColor];
    label.text = string;
    label.font=[UIFont systemFontOfSize:10.0f];
    label.textAlignment=NSTextAlignmentCenter;
    [vwfooter addSubview:activityIndicator];  
    [vwfooter addSubview:label];  
    vwfooter.backgroundColor=[UIColor clearColor];
    UIView *tblBackGroundView = [[UIView alloc] initWithFrame:frame];
   vwfooter.center=CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    [tblBackGroundView addSubview:vwfooter];    
    [self setBackgroundView:tblBackGroundView];
}
- (void)setLoaderWithString : (NSString*)string
{
   UIView *vwfooter=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
   UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.alpha = 1.0;
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.color=[UIColor orangeColor];
    [activityIndicator startAnimating];
    
    activityIndicator.frame=CGRectMake(0,0, SCREEN_WIDTH, 25);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(activityIndicator.frame), SCREEN_WIDTH, 25)];
    label.textColor = [UIColor lightGrayColor];
    label.text = string;
    label.font=[UIFont systemFontOfSize:10.0f];
    label.textAlignment=NSTextAlignmentCenter;
    [vwfooter addSubview:activityIndicator];  
    [vwfooter addSubview:label];  
    vwfooter.backgroundColor=[UIColor clearColor];
    UIView *tblBackGroundView = [[UIView alloc] initWithFrame:self.frame];
    
    vwfooter.center=tblBackGroundView.center;
    [tblBackGroundView addSubview:vwfooter];    
    [self setBackgroundView:tblBackGroundView];
}
- (void)reloadDataWithPlaceholderString:(NSString *)placeholderString
{
    [self setBackgroundView:nil];
    if ([self numberOfSections] == 0 || ([self numberOfRowsInSection:0] == 0 || [self numberOfRowsInSection:0] == NSNotFound))
    {
        if (placeholderString.length > 0)
        {
            UILabel *lblEmpty = [self getLabel];
            [lblEmpty setText:placeholderString];
            [self setBackgroundView:lblEmpty];
        }
    }
    else{
        [self setBackgroundView:nil];
    }
    [self reloadData];
    
}

- (void)reloadDataWithPlaceholderString:(NSString *)placeholderString lookupsection:(NSInteger)section
{
    [self setBackgroundView:nil];
    if ([self numberOfSections] == 0 && ([self numberOfRowsInSection:section] == 0 || [self numberOfRowsInSection:section] == NSNotFound))
    {
        if (placeholderString.length > 0)
        {
            UILabel *lblEmpty = [self getLabel];
            [lblEmpty setText:placeholderString];
            lblEmpty.textColor  = [UIColor lightGrayColor];
            [self setBackgroundView:lblEmpty];
        }
    }
    else{
        [self setBackgroundView:nil];
    }
    [self reloadData];
    
}

- (void)reloadDataWithPlaceholderString:(NSString *)placeholderString withUIColor:(UIColor *)placeholderColor
{
    [self setBackgroundView:nil];
    
    if ([self numberOfSections] == 0 || ([self numberOfRowsInSection:0] == 0 || [self numberOfRowsInSection:0] == NSNotFound))
    {
        if (placeholderString.length > 0)
        {
            UILabel *lblEmpty = [self getLabel];
            [lblEmpty setText:placeholderString];
            lblEmpty.textColor = placeholderColor;
            [self setBackgroundView:lblEmpty];
        }
    }
    else{
        [self setBackgroundView:nil];
    }
    [self reloadData];
}

- (UILabel *)getLabel
{
    UILabel *lblEmpty = [[UILabel alloc]initWithFrame:CGRectMake(kplaceholderRightPadding, kplaceholdertopPadding, CGRectGetWidth(self.frame)-kplaceholderRightPadding, CGRectGetHeight(self.frame)-kplaceholderbottomPadding) ];
    lblEmpty.numberOfLines = 3;
    lblEmpty.textAlignment = NSTextAlignmentCenter;
    [lblEmpty setLineBreakMode:NSLineBreakByWordWrapping];
    [lblEmpty setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [lblEmpty sizeThatFits:lblEmpty.frame.size];
    return lblEmpty;
}

- (void)reloadDataWithPlaceholderImage:(UIImage *)placeholderImage
{
    [self setBackgroundView:nil];
    
    if ([self numberOfSections] == 0 || ([self numberOfRowsInSection:0] == 0 || [self numberOfRowsInSection:0] == NSNotFound))
    {
        if (placeholderImage != nil)
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:self.frame];
            [img setImage:placeholderImage];
            [img setBackgroundColor:[UIColor clearColor]];
            img.contentMode = UIViewContentModeScaleAspectFit;
            [self setBackgroundView:img];
        }
    }
    else{
        [self setBackgroundView:nil];
    }
    [self reloadData];
}

- (void)reloadDataAnimateWithWave:(WaveAnimation)animation;
{
    [self setContentOffset:self.contentOffset animated:NO];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [UIView transitionWithView:self
                      duration:.8
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^(void) {
                        [self setHidden:YES];
                        [self reloadData];
                    } completion:^(BOOL finished) {
                        if(finished){
                            [self setHidden:NO];
                            [self visibleRowsBeginAnimation:animation];
                        }
                    }
     ];
}

- (void)visibleRowsBeginAnimation:(WaveAnimation)animation
{
    NSArray *array = [self indexPathsForVisibleRows];
    for (int i=0 ; i < [array count]; i++) {
        NSIndexPath *path = [array objectAtIndex:i];
        UITableViewCell *cell = [self cellForRowAtIndexPath:path];
        cell.frame = [self rectForRowAtIndexPath:path];
        cell.hidden = YES;
        [cell.layer removeAllAnimations];
        NSArray *array = @[path,[NSNumber numberWithInt:animation]];
        [self performSelector:@selector(animationStart:) withObject:array afterDelay:.08*i];
    }
}

- (void)animationStart:(NSArray *)array
{
    NSIndexPath *path = [array objectAtIndex:0];
    float i = [((NSNumber*)[array objectAtIndex:1]) floatValue] ;
    UITableViewCell *cell = [self cellForRowAtIndexPath:path];
    CGPoint originPoint = cell.center;
    CGPoint beginPoint = CGPointMake(cell.frame.size.width*i, originPoint.y);
    CGPoint endBounce1Point = CGPointMake(originPoint.x-i*2*kBOUNCE_DISTANCE, originPoint.y);
    CGPoint endBounce2Point  = CGPointMake(originPoint.x+i*kBOUNCE_DISTANCE, originPoint.y);
    cell.hidden = NO ;
    
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.keyTimes=@[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.8],[NSNumber numberWithFloat:0.9],[NSNumber numberWithFloat:1.]];
    move.values=@[[NSValue valueWithCGPoint:beginPoint],[NSValue valueWithCGPoint:endBounce1Point],[NSValue valueWithCGPoint:endBounce2Point],[NSValue valueWithCGPoint:originPoint]];
    move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    CABasicAnimation *opaAnimation = [CABasicAnimation animationWithKeyPath: @"opacity"];
    opaAnimation.fromValue = @(0.f);
    opaAnimation.toValue = @(1.f);
    opaAnimation.autoreverses = NO;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[move,opaAnimation];
    group.duration = kWAVE_DURATION;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [cell.layer addAnimation:group forKey:nil];
}

- (void)reloadCellwithAnimation:(UITableViewCell *)cell
{
    CGPoint originPoint = cell.center;
    CGPoint beginPoint = CGPointMake(cell.frame.size.width*1, originPoint.y);
    CGPoint endBounce1Point = CGPointMake(originPoint.x*2*kBOUNCE_DISTANCE, originPoint.y);
    CGPoint endBounce2Point  = CGPointMake(originPoint.x*kBOUNCE_DISTANCE, originPoint.y);
    cell.hidden = NO ;
    
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.keyTimes=@[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.8],[NSNumber numberWithFloat:0.9],[NSNumber numberWithFloat:1.]];
    move.values=@[[NSValue valueWithCGPoint:beginPoint],[NSValue valueWithCGPoint:endBounce1Point],[NSValue valueWithCGPoint:endBounce2Point],[NSValue valueWithCGPoint:originPoint]];
    move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    CABasicAnimation *opaAnimation = [CABasicAnimation animationWithKeyPath: @"opacity"];
    opaAnimation.fromValue = @(0.f);
    opaAnimation.toValue = @(1.f);
    opaAnimation.autoreverses = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[move,opaAnimation];
    group.duration = kWAVE_DURATION;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [cell.layer addAnimation:group forKey:nil];
}


#pragma mark - Anim Dots

-(void)setupThreeBounceAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat offset = size.width / 8;
    CGFloat circleSize = offset * 2;
    
    for (NSInteger i=0; i < 3; i+=1) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(i * 3 * offset, size.height / 2, circleSize, circleSize);
        circle.backgroundColor = color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
        circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        anim.removedOnCompletion = NO;
        anim.repeatCount = HUGE_VALF;
        anim.duration = 1.0;
        anim.beginTime = beginTime + (0.25 * i);
        anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
        
        anim.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
        
        anim.values = @[
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
                        ];
        
        [layer addSublayer:circle];
        [circle addAnimation:anim forKey:@"spinkit-anim"];
    }
}

@end
