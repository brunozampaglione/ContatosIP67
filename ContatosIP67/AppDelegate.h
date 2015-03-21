//
//  AppDelegate.h
//  ContatosIP67
//
//  Created by ios5034 on 09/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property ContatoDao *dao;
@end

