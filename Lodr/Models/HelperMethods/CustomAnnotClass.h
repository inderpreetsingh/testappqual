//
//  CustomAnnotClass.h
//  MKMapViewRouteDirectionTutorial
//
//  Created by Maitrayee Ghosh on 14/09/15.
//  Copyright (c) 2015 Maitrayee Ghosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotClass : NSObject<MKAnnotation>
{
@public
    CLLocationCoordinate2D coordinate;
    NSString *markTitle, *markSubTitle;
    NSString *shopImage;
    NSString *shopRating;
    NSString *address;
}
@property (nonatomic, retain) NSString *markTitle, *markSubTitle;
@property (nonatomic, retain) NSString *mImageUrl;

@property (nonatomic, retain) UILabel *lbl;

-(id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate andMarkTitle:(NSString *)theMarkTitle andMarkSubTitle:(NSString *)theMarkSubTitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
