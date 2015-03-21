//
//  GerenciadorAcoes.m
//  ContatosIP67
//
//  Created by ios5034 on 16/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import "GerenciadorAcoes.h"

@implementation GerenciadorAcoes
-(id) initWithContato:(Contato *)contato{
    self.contato = contato;
    return self;
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self.controller dismissViewControllerAnimated:true completion:nil];
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self ligarContato];
            break;
        case 1:
            [self enviaEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
        default:
            break;
    }
}
-(void) fazAcoesDoController:(UIViewController *)controller{
    UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:self.contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar Email", @"Abrir Site", @"Mostrar Mapa", nil];
    self.controller = controller;
    [opcoes showInView:controller.view];
    
    // commentss
}

-(void) ligarContato{
    
    UIDevice *device = [UIDevice currentDevice];
    if([device.model isEqualToString:@"iPhone"]){
        if(self.contato.telefone){
            NSString *url = [NSString stringWithFormat:@"tel:%@", self.contato.telefone];
            [self abreAplicativoComUrl:url];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Contato não tem telefone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
   else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Dispositivo precisa ser um iphone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }

}
-(void) abrirSite{
    [self abreAplicativoComUrl:self.contato.site];
}
-(void) mostrarMapa{
    NSString *url = [NSString stringWithFormat:@"https://maps.apple.com/?q=%@", self.contato.endereco];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abreAplicativoComUrl:url];
}
-(void) enviaEmail{
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *sendEmail = [MFMailComposeViewController new];
        [sendEmail setToRecipients:@[self.contato.email]];
        [sendEmail setSubject:@"Email de contato"];
        [self.controller presentViewController:sendEmail animated:true completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Configure sua conta de email." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void) abreAplicativoComUrl:(NSString*)url{
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:url]];
}
@end
