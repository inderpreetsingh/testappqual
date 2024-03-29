//
//  ZSYPopoverListView.m


#import "ZSYPopoverListView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "UITableView+Placeholder.h"
static const CGFloat ZSYCustomButtonHeight = 45;

static const char * const kZSYPopoverListButtonClickForCancel = "kZSYPopoverListButtonClickForCancel";

static const char * const kZSYPopoverListButtonClickForDone = "kZSYPopoverListButtonClickForDone";

@interface ZSYPopoverListView ()
@property (nonatomic, retain) UITableView *mainPopoverListView;
@property (nonatomic, retain) UIButton *doneButton;
@property (nonatomic, retain) UIButton *cancelButton;
@property (nonatomic, retain) UIControl *controlForDismiss;

- (void)initTheInterface;


- (void)animatedIn;


- (void)animatedOut;


- (void)show;


- (void)dismiss;

@end

@implementation ZSYPopoverListView
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;
@synthesize mainPopoverListView = _mainPopoverListView;
@synthesize doneButton = _doneButton;
@synthesize cancelButton = _cancelButton;
@synthesize titleName = _titleName;
@synthesize controlForDismiss = _controlForDismiss;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTheInterface];
    }
    return self;
}

- (void)initTheInterface
{

    self.frame=CGRectMake(0,64, self.bounds.size.width, self.bounds.size.height-64.0f);
    self.backgroundColor=[UIColor whiteColor];
    //self.layer.borderColor = [[UIColor clearColor] CGColor];
    //self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 3.0f;
    self.clipsToBounds = TRUE;
    _titleName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleName.font = [UIFont boldSystemFontOfSize:18];
    self.titleName.backgroundColor =[UIColor whiteColor];
    
   
    self.titleName.textAlignment = NSTextAlignmentCenter;
    self.titleName.textColor = [UIColor blackColor];
    CGFloat xWidth = self.bounds.size.width;
    self.titleName.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleName.frame = CGRectMake(0, 0, xWidth, 45.0f);
     [self addSubview:self.titleName];
    UILabel *lblSeprator2=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.titleName.frame), self.titleName.frame.size.width, 0.6)];
    lblSeprator2.text=@"";
    lblSeprator2.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:lblSeprator2];
 
    CGRect tableFrame = CGRectMake(0,CGRectGetMaxY(lblSeprator2.frame), xWidth, self.bounds.size.height- 90);
    _mainPopoverListView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    self.mainPopoverListView.dataSource = self;
    self.mainPopoverListView.delegate = self;
    _mainPopoverListView.backgroundColor=[UIColor whiteColor];
    _mainPopoverListView.separatorColor=[UIColor clearColor];
    self.mainPopoverListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self bringSubviewToFront:lblSeprator2];
    [self addSubview:self.mainPopoverListView];
//   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonWasPressed:) name:NCNamedZSYDismissPopup object:nil];
}

- (void)refreshTheUserInterface
{
    
    if (self.cancelButton || self.doneButton)
    {
        if([_calledFor isEqualToString:VisibilityTitle] || [_calledFor isEqualToString:AvailablilityTitle] || [_calledFor isEqualToString:MilesPopUpTitle]  || [_calledFor isEqualToString:DriverPopUp]  || [_calledFor isEqualToString:TrailerPopUp]  || [_calledFor isEqualToString:PoweredPopUp]  || [_calledFor isEqualToString:SupportPopUp]  || [_calledFor isEqualToString:AssetTypePopUp] )
        {
            self.mainPopoverListView.frame = CGRectMake(0,CGRectGetMaxY(self.titleName.frame)+0.6, self.mainPopoverListView.frame.size.width, self.mainPopoverListView.frame.size.height+90);
        }
        else
        {
            self.mainPopoverListView.frame = CGRectMake(0,CGRectGetMaxY(self.titleName.frame)+0.6, self.mainPopoverListView.frame.size.width, self.mainPopoverListView.frame.size.height);
            UILabel *lblSeprator=[[UILabel alloc]initWithFrame:CGRectMake(self.mainPopoverListView.frame.origin.x,CGRectGetMaxY(self.mainPopoverListView.frame), self.mainPopoverListView.frame.size.width, 0.6)];
            lblSeprator.text=@"";
            lblSeprator.backgroundColor=[UIColor lightGrayColor];
            [self addSubview:lblSeprator];
            [self bringSubviewToFront:lblSeprator];
        }
    }
    if (self.doneButton && nil == self.cancelButton)
    {
        self.doneButton.frame = CGRectMake(0, self.bounds.size.height - ZSYCustomButtonHeight, self.bounds.size.width, ZSYCustomButtonHeight);
    }
    else if (nil == self.doneButton && self.cancelButton)
    {
       // self.cancelButton.frame = CGRectMake(0, self.bounds.size.height - ZSYCustomButtonHeight, self.bounds.size.width, ZSYCustomButtonHeight);
        self.cancelButton.frame = CGRectMake(self.mainPopoverListView.frame.size.width-40, self.titleName.frame.origin.y+2,60,ZSYCustomButtonHeight);
    }
    else if (self.doneButton && self.cancelButton)
    {
        self.cancelButton.backgroundColor=[UIColor clearColor];
//        self.doneButton.frame = CGRectMake(0, self.titleName.frame.origin.y+2,60,ZSYCustomButtonHeight);
//        
//      self.cancelButton.frame = CGRectMake(self.mainPopoverListView.frame.size.width-65, self.titleName.frame.origin.y+2,60,ZSYCustomButtonHeight);
      
        
        //Done button is this 
        if([_calledFor isEqualToString:DriverPopUp]  || [_calledFor isEqualToString:TrailerPopUp]  || [_calledFor isEqualToString:PoweredPopUp]  || [_calledFor isEqualToString:SupportPopUp] )
        {
              self.doneButton.frame = CGRectMake(0, self.titleName.frame.origin.y+2,60,0);
                self.cancelButton.frame = CGRectMake(0,CGRectGetMaxY(self.mainPopoverListView.frame),self.mainPopoverListView.frame.size.width,0);
        }
        else
        {
              self.doneButton.frame = CGRectMake(0, self.titleName.frame.origin.y+2,60,ZSYCustomButtonHeight);
                self.cancelButton.frame = CGRectMake(0,CGRectGetMaxY(self.mainPopoverListView.frame),self.mainPopoverListView.frame.size.width,ZSYCustomButtonHeight);
        }
    
    }
    if (nil == self.cancelButton && nil == self.doneButton)
    {
        if (nil == _controlForDismiss)
        {
            _controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _controlForDismiss.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
            [_controlForDismiss addTarget:self action:@selector(touchForDismissSelf:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (NSIndexPath *)indexPathForSelectedRow
{
    return [self.mainPopoverListView indexPathForSelectedRow];
}
#pragma mark - UITableViewDatasource
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell     forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(CGFloat)tableView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.datasource popoverListView:tableView heightForRowAtIndexPath:indexPath];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    if (self.datasource && [self.datasource respondsToSelector:@selector(popoverListView:numberOfRowsInSection:)])
    {
        return [self.datasource popoverListView:self numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datasource && [self.datasource respondsToSelector:@selector(popoverListView:cellForRowAtIndexPath:)])
    {
        return [self.datasource popoverListView:self cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListView:didDeselectRowAtIndexPath:)])
    {
        [self.delegate popoverListView:self didDeselectRowAtIndexPath:indexPath];
        //NSLog(@"deselected");
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListView:didSelectRowAtIndexPath:)])
    {
        [self.delegate popoverListView:self didSelectRowAtIndexPath:indexPath];
    //  [self dismiss];
        [tableView reloadData];
//        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        //NSLog(@"selected");
    }
}

#pragma mark - Animated Mthod
- (void)animatedIn
{
     //self.mainPopoverListView setLoaderAnimationWithText:@""
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)animatedOut
{
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(0, 0);
      self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.controlForDismiss)
            {
                [self.controlForDismiss removeFromSuperview];
            }
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - show or hide self
- (void)show
{
    [self refreshTheUserInterface];
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    if (self.controlForDismiss)
    {
        [keywindow addSubview:self.controlForDismiss];
    }
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    
    [self animatedIn];
    
}

- (void)dismiss
{
    [self animatedOut];
}

#pragma mark - Reuse Cycle
- (id)dequeueReusablePopoverCellWithIdentifier:(NSString *)identifier
{
    return [self.mainPopoverListView dequeueReusableCellWithIdentifier:identifier];
}

- (UITableViewCell *)popoverCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.mainPopoverListView cellForRowAtIndexPath:indexPath];
}

+ (UIImage *)normalButtonBackgroundImage
{
	const size_t locationCount = 4;
	CGFloat opacity = 1.0;
    CGFloat locations[locationCount] = { 0.0, 0.5, 0.5 + 0.0001, 1.0 };
    CGFloat components[locationCount * 4] = {
		179/255.0, 185/255.0, 199/255.0, opacity,
		121/255.0, 132/255.0, 156/255.0, opacity,
		87/255.0, 100/255.0, 130/255.0, opacity,
		108/255.0, 120/255.0, 146/255.0, opacity,
	};
	return [self glassButtonBackgroundImageWithGradientLocations:locations
													  components:components
												   locationCount:locationCount];
}

+ (UIImage *)cancelButtonBackgroundImage
{
	const size_t locationCount = 4;
	CGFloat opacity = 1.0;
    CGFloat locations[locationCount] = { 0.0, 0.5, 0.5 + 0.0001, 1.0 };
    CGFloat components[locationCount * 4] = {
		164/255.0, 169/255.0, 184/255.0, opacity,
		77/255.0, 87/255.0, 115/255.0, opacity,
		51/255.0, 63/255.0, 95/255.0, opacity,
		78/255.0, 88/255.0, 116/255.0, opacity,
	};
	return [self glassButtonBackgroundImageWithGradientLocations:locations
													  components:components
												   locationCount:locationCount];
}

+ (UIImage *)glassButtonBackgroundImageWithGradientLocations:(CGFloat *)locations
												  components:(CGFloat *)components
											   locationCount:(NSInteger)locationCount
{
	const CGFloat lineWidth = 1;
	const CGFloat cornerRadius = 4;
	UIColor *strokeColor = [UIColor colorWithRed:1/255.0 green:11/255.0 blue:39/255.0 alpha:1.0];
	
	CGRect rect = CGRectMake(0, 0, cornerRadius * 2 + 1, ZSYCustomButtonHeight);
    
	BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(rect.size, opaque, [[UIScreen mainScreen] scale]);
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locationCount);
	
	CGRect strokeRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
	UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:strokeRect cornerRadius:cornerRadius];
	strokePath.lineWidth = lineWidth;
	[strokeColor setStroke];
	[strokePath stroke];
	
	CGRect fillRect = CGRectInset(rect, lineWidth, lineWidth);
	UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:fillRect cornerRadius:cornerRadius];
	[fillPath addClip];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	CGFloat capHeight = floorf(rect.size.height * 0.5);
	return [image resizableImageWithCapInsets:UIEdgeInsetsMake(capHeight, cornerRadius, capHeight, cornerRadius)];
}

#pragma mark - Button Method
- (void)setCancelButtonTitle:(NSString *)aTitle block:(ZSYPopoverListViewButtonBlock)block
{
    if (nil == _cancelButton)
    {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setTintColor:[UIColor orangeColor]];
        [self.cancelButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font =[UIFont boldSystemFontOfSize:17.0];
        [self.cancelButton addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
       
        [self addSubview:self.cancelButton];
    }
    [self.cancelButton setTitle:aTitle forState:UIControlStateNormal];
    objc_setAssociatedObject(self.cancelButton, kZSYPopoverListButtonClickForCancel, [block copy], OBJC_ASSOCIATION_RETAIN);
}

- (void)setDoneButtonWithTitle:(NSString *)aTitle block:(ZSYPopoverListViewButtonBlock)block
{
    if (nil == _doneButton)
    {
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.doneButton setBackgroundImage:[ZSYPopoverListView normalButtonBackgroundImage] forState:UIControlStateNormal];
        [self.doneButton setTintColor:[UIColor orangeColor]];
        self.doneButton.titleLabel.font =[UIFont boldSystemFontOfSize:17.0];
        [self.doneButton addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.doneButton];
        self.doneButton.titleLabel.textColor = [UIColor orangeColor];
    }
    [self.doneButton setTitle:aTitle forState:UIControlStateNormal];
    objc_setAssociatedObject(self.doneButton, kZSYPopoverListButtonClickForDone, [block copy], OBJC_ASSOCIATION_RETAIN);
}
#pragma mark - UIButton Clicke Method
- (void)buttonWasPressed:(id)sender
{
    @try 
    {
        UIButton *button = (UIButton *)sender;
        ZSYPopoverListViewButtonBlock __block block;
        if (button == self.cancelButton)
        {
            block = objc_getAssociatedObject(sender, kZSYPopoverListButtonClickForCancel);
            [self animatedOut];
        }
        else
        {
            block = objc_getAssociatedObject(sender, kZSYPopoverListButtonClickForDone);
            [self animatedOut];
        }
        if (block)
        {
            block();
        }
    } 
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception.description);
    }
}

- (void)touchForDismissSelf:(id)sender
{
    [self animatedOut];
}
@end
