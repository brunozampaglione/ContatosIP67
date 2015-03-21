//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5034 on 09/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import "FormularioContatoViewController.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// BAZ: Sobrescrever evento/metodo viewDidLoad
-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.dao = [ContatoDao contatoDaoInstance];
    
    [self exibeDadosFormulario];
    
    if(_contato){
        UIBarButtonItem *update = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStylePlain target:self action:@selector(saveContato)];
        self.navigationItem.rightBarButtonItem = update;
    }
    else{
        UIBarButtonItem *cadastro = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar" style:UIBarButtonItemStylePlain target:self action:@selector(addContactNavigation)];
        self.navigationItem.rightBarButtonItem = cadastro;
    }
    
    if(self.contato.picture){
        [self.pictureBt setTitle:nil forState:UIControlStateNormal];
        [self.pictureBt setBackgroundImage:self.contato.picture forState:UIControlStateNormal];
    }   
}

// BAZ: Se quisermos podemos checar o singleton direto no inicializador do viewcontroller
// BAZ: Nesse caso não usamos o init puro, pois essa view esta serializada pelo storyboard, ou seja ele
// BAZ: precisa passar o objeto serializado da view
-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder: aDecoder];
    if(self){
        self.navigationItem.title = @"Add Contatos";
        self.dao = [ContatoDao contatoDaoInstance];
    }
    return self;
}

// BAZ: Retorna o contato preenchido no formulário
-(Contato *) pegaDadosFormulario{
    
    if(!self.contato){
        self.contato = [self.dao novoContato];
    }
    
    self.contato .nome = self.nome.text;
    self.contato .telefone = self.telefone.text;
    self.contato .email = self.email.text;
    self.contato .endereco = self.endereco.text;
    self.contato .latitude = [NSNumber numberWithFloat:[self.latitude.text floatValue]];
    self.contato .longitude = [NSNumber numberWithFloat:[self.longitude.text floatValue]];
    self.contato .site = self.site.text;
    
    if([self.pictureBt backgroundImageForState:UIControlStateNormal])
    {
        self.contato.picture = [self.pictureBt backgroundImageForState:UIControlStateNormal];
    }
    
    return self.contato ;
}

-(void) exibeDadosFormulario{
    if(self.contato){
        self.nome.text = _contato.nome;
        self.telefone.text = _contato.telefone;
        self.email.text = _contato.email;
        self.endereco.text = _contato.endereco;
        self.latitude.text = [_contato.latitude stringValue];
        self.longitude.text = [_contato.longitude stringValue];
        self.site.text = _contato.site;
    }
}

// BAZ: Metodo para atividades do exercicio - adicionar contato chamando pelo navigation bar
- (void)addContactNavigation{
   
    // Contatos é um array instanciado na viewDidLoad
    [self.dao adicionarContato:[self pegaDadosFormulario]];
    
    // Classe que implmentou o protocolo ----  classe que foi delegada
    if(self.delegate){
        [self.delegate contatoAdicionado:self.contato];
    }
    
    // Limpar o forumlário
    [self clearForm:self];
    
    // Volta um step no fluxo do navigation controller
    [self.navigationController popViewControllerAnimated:true];
}

- (void)saveContato{
    self.contato = [self pegaDadosFormulario];
    
    // Limpar o forumlário
    [self clearForm:self];
    
    // Classe que implmentou o protocolo ----  classe que foi delegada
    if(self.delegate){
        [self.delegate contatoAtualizado:self.contato];
    }
    
    // Volta um step no fluxo do navigation controller
    [self.navigationController popViewControllerAnimated:true];
}

// BAZ: Metodo para atividades do exercicio - adicionar contato - chamando pelo botao no meio da view
- (IBAction)addContact{
    
    Contato *contato = [Contato new];
    
    contato.nome = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    NSLog(@"%@", contato.description);
    
    // Contatos é um array instanciado na viewDidLoad
    [self.dao adicionarContato:contato];
    
    [self clearForm:self];
}

// BAZ: Metodo com diversos exemplos de utilizaçao do x-code
- (IBAction) pegaDadosDoFormularioOld{

    NSString *nome = [self.nome text];
    NSString *telefone = [self.telefone text];
    NSString *email = [self.email text];
    NSString *endereco = [self.endereco text];
    NSString *site = [self.site text];
    
    NSLog(@"Nome: %@, Telefone: %@, Email: %@, Endereço: %@, Site: %@", nome, telefone, email, endereco, site);
    
    NSString *nomeEmail = [NSString stringWithFormat:@"Nome %@ e Email %@", nome, email];
    
    NSLog(@"Concatena nome e email %@", nomeEmail);
    
    Contato *contato = [Contato new];
    
    contato.nome = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    NSLog(@"Contato nome: %@, telefone: %@, email: %@, endereço: %@, site: %@", contato.nome, contato.telefone, contato.email, contato.endereco, contato.site);
    
    NSLog(@"Descrição do contato %@", contato.description);
    
    Contato *contato2 = [[Contato alloc] initWithName:@"Bruno" andEmail:@"bruno@bol.com.br"];
    
    NSLog(@"Contato 2 %@, Email %@", contato2.nome, contato2.email);
    
}

// BAZ: Limpa textboxes do formulário
- (IBAction) clearForm:(id)sender {
    _nome.text = @"";
    _telefone.text = @"";
    _email.text = @"";
    _endereco.text = @"";
    _site.text = @"";
    
    [_nome becomeFirstResponder];
    [self.view resignFirstResponder];
}

// BAZ: Checa array de lista de contatos
- (IBAction)checarListaContatos:(id)sender {
    NSLog(@"%@", self.dao.description);
}

// BAZ: Botão para selecionar Foto
- (IBAction)selecionaFoto:(id)sender {
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self abreGaleria];
    }
    else{
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:self.contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Abrir Camera", @"Abrir Galeria", nil];
        [opcoes showInView:self.view];
    }
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self abreCamera];
            break;
        case 1:
            [self abreGaleria];
            break;
        default:
            break;
    }
}
-(void) abreGaleria{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = true;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:true completion:nil];
}
-(void) abreCamera{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = true;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:true completion:nil];
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.pictureBt setTitle:nil forState:UIControlStateNormal];
    [self.pictureBt setBackgroundImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)pegaEndereco:(UIButton*)sender {
    CLGeocoder *geoCoder = [CLGeocoder new];
    sender.hidden = true;
    [self.loading startAnimating];
    [geoCoder geocodeAddressString:self.endereco.text completionHandler:^ (NSArray *resultados, NSError *error){
        if(error==nil && [resultados count] > 0){
            CLPlacemark *res = resultados[0];
            CLLocationCoordinate2D coord = res.location.coordinate; // não tem * pois é struct do C
            self.latitude.text = [NSString stringWithFormat:@"%f", coord.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f", coord.longitude];
        }
        [self.loading stopAnimating];
        sender.hidden = false;
    }];
    
}
@end
