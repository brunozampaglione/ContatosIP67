//
//  ViewController.h
//  ContatosIP67
//
//  Created by ios5034 on 09/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"
#import <CoreLocation/CoreLocation.h>

@protocol FormularioContatoViewControllerDelegate<NSObject>
-(void)contatoAdicionado:(Contato *)contato;
-(void)contatoAtualizado:(Contato *)contato;
@end

@interface FormularioContatoViewController : UIViewController<UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UIButton *pictureBt;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (strong) Contato *contato;
@property (strong) ContatoDao *dao;
@property id<FormularioContatoViewControllerDelegate> delegate;

@end

