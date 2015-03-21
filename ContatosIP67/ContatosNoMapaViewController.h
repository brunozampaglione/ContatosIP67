//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by ios5034 on 17/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ContatoDao.h"

@interface ContatosNoMapaViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapinha;
@property (strong) CLLocationManager *locManager;
@property (strong) ContatoDao *dao;
@end
