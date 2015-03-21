//
//  GerenciadorAcoes.h
//  ContatosIP67
//
//  Created by ios5034 on 16/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Contato.h"
@interface GerenciadorAcoes : NSObject<UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>

@property UIViewController *controller;
@property Contato *contato;

-(id) initWithContato:(Contato*)contato;
-(void) fazAcoesDoController:(UIViewController *)controller;
@end
