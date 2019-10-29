//
//  CellHorizontalScroll.m
//  PUCalender
//
//  Created by c196 on 08/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "CellHorizontalScroll.h"
#import "Matches.h"

@implementation CellHorizontalScroll

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setUpCellWithArray:(NSArray *)array
{
    CGFloat xbase = 50;
    CGFloat width = 70;
    [self.scroll setScrollEnabled:YES];
    [self.scroll setShowsHorizontalScrollIndicator:NO];
    
  if(array.count > 0)
  {
      UIView *custom = [self createCustomView:array withLoadName:@""];
      [self.scroll addSubview:custom];
      [custom setFrame:[self formulawidthStartTime:[array objectAtIndex:0] andEndTime:[array objectAtIndex:1]]];
      xbase += 50 + width;  
  }
}
-(void)setUpCellWithDIcArr:(NSMutableDictionary *)dic :(NSArray *)arr2
{
    CGFloat xbase = 50;
    CGFloat width = 70;
    [self.scroll setScrollEnabled:YES];
    [self.scroll setShowsHorizontalScrollIndicator:NO];
    [[self.scroll subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(dic.count>0)
    {
        for(int i=0;i<arr2.count;i++)
        {
            NSArray *arr=[dic valueForKey:[NSString stringWithFormat:@"%@",[arr2 objectAtIndex:i]]];
            UIView *custom = [self createCustomView:arr withLoadName:@""];
            [custom setFrame:[self formulawidthStartTime:[arr objectAtIndex:0] andEndTime:[arr objectAtIndex:1]]];
            [UIView transitionWithView:self.scroll
                              duration:0.8
                               options:UIViewAnimationOptionTransitionCrossDissolve //any animation
                            animations:^ {
                                [self.scroll addSubview:custom];
                            }
                            completion:nil];
            xbase += 50 + width;
        }  
    }
  
    
    
    //[self.scroll setContentSize:CGSizeMake(xbase, self.scroll.frame.size.height)];
    // self.scroll.delegate = self;
}
-(void)setUpCellWithDIcDriver:(NSMutableDictionary *)dic :(MyNetwork *)equi
{
    CGFloat xbase = 50;
    CGFloat width = 70;
    [self.scroll setScrollEnabled:YES];
    [self.scroll setShowsHorizontalScrollIndicator:NO];
    [[self.scroll subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(dic.count >0)
    {
        for(Matches *objm in equi.matches)
        {
            NSArray *arr=[dic valueForKey:[NSString stringWithFormat:@"%@",objm.orderLoadid]];
            UIView *custom = [self createCustomView:arr withLoadName:@""];
            [custom setFrame:[self formulawidthStartTime:[arr objectAtIndex:0] andEndTime:[arr objectAtIndex:1]]];
            custom.tag=[objm.orderLoadid intValue];
            custom.accessibilityLabel=[arr lastObject];
            [UIView transitionWithView:self.scroll
                              duration:0.8
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^ {
                                [self.scroll addSubview:custom];
                            }
                            completion:^(BOOL finished) {
                                UITapGestureRecognizer *singleFingerTap =
                                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handleSingleTap_driver:)];
                                [custom addGestureRecognizer:singleFingerTap];
                            }];
            xbase += 50 + width;
        }
    }
}
-(void)setUpCellWithDIcLoad:(NSMutableDictionary *)dic :(Loads *)equi
{
    CGFloat xbase = 50;
    CGFloat width = 70;
    
    [self.scroll setScrollEnabled:YES];
    [self.scroll setShowsHorizontalScrollIndicator:NO];
    [[self.scroll subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (dic.count > 0)
    {
        for(Matches *objm in equi.matches)
        {
            NSArray *arr=[dic valueForKey:[NSString stringWithFormat:@"%@",objm.orderLoadid]];
            UIView *custom = [self createCustomView:arr withLoadName:equi.loadName];
            
            [custom setFrame:[self formulawidthStartTime:[arr objectAtIndex:0] andEndTime:[arr objectAtIndex:1]]];
            custom.tag=[objm.orderLoadid intValue];
            custom.accessibilityLabel=[arr lastObject];
            [UIView transitionWithView:self.scroll
                              duration:0.8
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^ {
                                [self.scroll addSubview:custom];
                            }
                            completion:^(BOOL finished) {
                                UITapGestureRecognizer *singleFingerTap =
                                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handleSingleTap_load:)];
                                [custom addGestureRecognizer:singleFingerTap];
                            }];
            xbase += 50 + width;
        }
    }
}

- (void)setUpCellWithDIc:(NSMutableDictionary *)dic :(Equipments *)equi :(NSString *)vwname
{
    CGFloat xbase = 50;
    CGFloat width = 70;
    [self.scroll setScrollEnabled:YES];
    [self.scroll setShowsHorizontalScrollIndicator:NO];
   [[self.scroll subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(dic.count >0)
    {
        for(Matches *objm in equi.matches)
        {
            NSArray *arr=[dic valueForKey:[NSString stringWithFormat:@"%@",objm.orderLoadid]];
            UIView *custom = [self createCustomView:arr withLoadName:@""];
            [custom setFrame:[self formulawidthStartTime:[arr objectAtIndex:0] andEndTime:[arr objectAtIndex:1]]];
            custom.tag=[objm.orderLoadid intValue];
             custom.accessibilityLabel=[arr lastObject];
            [UIView transitionWithView:self.scroll
                              duration:0.8
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^ {
                                [self.scroll addSubview:custom];
                            }
                            completion:^(BOOL finished) 
                            {
                                
                                UITapGestureRecognizer *singleFingerTap =
                                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handleSingleTap_equi:)];
                                singleFingerTap.accessibilityLabel=vwname;
                                [custom addGestureRecognizer:singleFingerTap];
                            }];
            xbase += 50 + width;
        }
    }
}
-(CGRect)formulawidthStartTime:(NSString*)t1 andEndTime:(NSString*)t2
{
    t1 = [t1 stringByReplacingOccurrencesOfString:@":"
                                         withString:@"."];
    NSArray *arr=[t1 componentsSeparatedByString:@"."];
    int s1=[[arr objectAtIndex:0] intValue];
    int s3=[[arr objectAtIndex:1] intValue];
    t2 = [t2 stringByReplacingOccurrencesOfString:@":"
                                       withString:@"."];
    NSArray *arr2=[t2 componentsSeparatedByString:@"."];
    int s2=[[arr2 objectAtIndex:0] intValue];
    int s4=[[arr2 objectAtIndex:1] intValue];
    CGFloat porigin,zorigin;
   
    if(s3==0)
    {
        porigin =((s1-1)*60);
    }
    else
    {
//      porigin =((s1*60)-(60-s3));
        //SK CHANGES
        porigin = ((s1 *60) + s3);
    }
//    if(s2==24)
//    {
//        zorigin =(s2*60);
//    }
//    else
   // {
    
    if(s4 == 59 && s2 == 24){
         zorigin =((s2*60)-(60-s4));
        //SK CHANGES
        
    }
    else{
        
        zorigin =((s2*60)+s4);
    }
    
    if(s1==s2 && s3==s4)
    {
        porigin=0;
        zorigin=1;
    }
    int width=abs((int)zorigin-(int)porigin);
    
    return CGRectMake(porigin, 0, width, 70);
}

- (UIView *)createCustomView:(NSArray *)array withLoadName:(NSString *)strLoadName
{
    UIView *custom = [[UIView alloc] initWithFrame:[self formulawidthStartTime:[array objectAtIndex:0] andEndTime:[array objectAtIndex:1]]];
    
    UILabel *lblleft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, custom.frame.size.width, 10)];
    UILabel *lblright = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, custom.frame.size.width, 10)];
    UILabel *lblname = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, custom.frame.size.width, 50)];
    
    lblleft.textColor = [UIColor whiteColor];
    lblright.textColor = [UIColor whiteColor];
    lblname.textColor = [UIColor whiteColor];
    
    lblname.numberOfLines = 3;
    
    lblleft.textAlignment=NSTextAlignmentLeft;
    lblright.textAlignment=NSTextAlignmentRight;
    lblname.textAlignment = NSTextAlignmentCenter;

//    if([[array objectAtIndex:0] isEqualToString:@"1:00"])
//    {
//         lblleft.text=[NSString stringWithFormat:@" %@", [array objectAtIndex:4]];
//    }
//    else
//    {
//        lblleft.text=[NSString stringWithFormat:@" %@", [GlobalFunction stringDate:[array objectAtIndex:0] fromFormat:@"HH:mm" toFormat:@"hh:mm a"]];
//    }
    
    lblleft.text = [NSString stringWithFormat:@" %@", [array objectAtIndex:4]];
    lblright.text = [NSString stringWithFormat:@"%@", [array objectAtIndex:5]];
    
//   if([[array objectAtIndex:1] isEqualToString:@"24:59"])
//   {
//       lblright.text=[NSString stringWithFormat:@"%@", [array objectAtIndex:5]];
//   }
//    else
//    {
//        lblright.text=[NSString stringWithFormat:@"%@", [GlobalFunction stringDate:[array objectAtIndex:1] fromFormat:@"HH:mm" toFormat:@"hh:mm a"]];
//    }
    
    NSString *strCurLoadName = @"";
    
    if (strLoadName.length > 0)
    {
        strCurLoadName = [NSString stringWithFormat:@"%@\n", strLoadName];
    }
    
    lblname.text = [NSString stringWithFormat:@"%@%@", strCurLoadName, [array objectAtIndex:2]];
    
    if (custom.frame.size.width <= 80 && custom.frame.size.width > 40)
    {
        lblleft.font = [UIFont systemFontOfSize:5];
        lblright.font = [UIFont systemFontOfSize:5];
        lblright.frame = CGRectMake(0, 0, custom.frame.size.width, 10);
        lblname.frame = CGRectMake(0, 12, custom.frame.size.width, 50);
    }
    else if (custom.frame.size.width <= 40)
    {
        lblleft.font = [UIFont systemFontOfSize:5];
        lblright.font = [UIFont systemFontOfSize:5];
        lblright.frame = CGRectMake(0, 10, custom.frame.size.width, 10);
        lblname.frame = CGRectMake(0, 22, custom.frame.size.width, 50);
//        lblname.text = [array objectAtIndex:2];
    }
    else
    {
        lblleft.font = [UIFont systemFontOfSize:8];
        lblright.font = [UIFont systemFontOfSize:8];
//        lblname.text = [array objectAtIndex:2];
        lblright.frame = CGRectMake(0, 0, custom.frame.size.width, 10);
        lblname.frame = CGRectMake(0, 12, custom.frame.size.width, 50);
    }
    
    lblname.adjustsFontSizeToFitWidth = YES;
    [custom addSubview:lblleft];
    [custom addSubview:lblright];
    [custom addSubview:lblname];
    switch ([[array objectAtIndex:3] intValue]) {
        case 1:
        {
            [custom setBackgroundColor:RGBColor(0,140,255,0.8)];
        }
        break;
        case 2:
        {
             [custom setBackgroundColor:RGBColor(105,161,64,0.8)];
        }
        break;
        case 3:
        {
              [custom setBackgroundColor:RGBColor(255,33,1,0.8)];
        }
            break;
        case 4:
        {
             [custom setBackgroundColor:RGBColor(105,161,64,0.8)];
        }
        case 5:
        {
            [custom setBackgroundColor:GreenButtonColor];
        }
        break;
            
        default:
            break;
    }
    return custom;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}
- (void)handleSingleTap_load:(UITapGestureRecognizer *)recognizer 
{
    NSLog(@"clicked1");
    
  //  UIView *selectedView = (UIView *)recognizer.view;
    if([_cellDelegate respondsToSelector:@selector(cellSelected_load:)])
        [_cellDelegate cellSelected_load:recognizer];
}
- (void)handleSingleTap_equi:(UITapGestureRecognizer *)recognizer 
{
    if([_cellDelegate respondsToSelector:@selector(cellSelected_equi:)])
        [_cellDelegate cellSelected_equi:recognizer];
}
- (void)handleSingleTap_driver:(UITapGestureRecognizer *)recognizer 
{
    NSLog(@"clicked3");
    
    //  UIView *selectedView = (UIView *)recognizer.view;
    if([_cellDelegate respondsToSelector:@selector(cellSelected_driver:)])
        [_cellDelegate cellSelected_driver:recognizer];
}
@end
