//
//  CustomAnnotClass.m
//  MKMapViewRouteDirectionTutorial
//
//  Created by Maitrayee Ghosh on 14/09/15.
//  Copyright (c) 2015 Maitrayee Ghosh. All rights reserved.
//

#import "CustomAnnotClass.h"

@implementation CustomAnnotClass

-(id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate andMarkTitle:(NSString *)theMarkTitle andMarkSubTitle:(NSString *)theMarkSubTitle
{
    self.coordinate = theCoordinate;
    self.markTitle = theMarkTitle;
    self.markSubTitle = theMarkSubTitle;
    return self;
}
- (NSString *)title
{
    return markTitle;
}

- (NSString *)subtitle
{
    
    return markSubTitle;
}


@end
