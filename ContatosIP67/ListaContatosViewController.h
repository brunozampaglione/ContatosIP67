//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios5034 on 11/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormularioContatoViewController.h"
#import "GerenciadorAcoes.h"

@interface ListaContatosViewController : UITableViewController<FormularioContatoViewControllerDelegate>
@property (strong) ContatoDao *dao;
@property (strong) Contato *contatoselecionado;
@property (readonly, strong) GerenciadorAcoes *gerenciador;

-(void)contatoAdicionado:(Contato *)contato;
-(void)contatoAtualizado:(Contato *)contato;

@property NSInteger linhaDestaque;
@end
