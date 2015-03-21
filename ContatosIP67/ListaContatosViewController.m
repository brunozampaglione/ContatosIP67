//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios5034 on 11/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import "ListaContatosViewController.h"

@implementation ListaContatosViewController

-(id) init{
    self = [super init];
    if (self) {
        self.dao = [ContatoDao contatoDaoInstance];
        
        NSMutableArray *rightBarButtonItems = [NSMutableArray new];
        UIBarButtonItem *addContato = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario:)];
        [rightBarButtonItems addObject:addContato];
        
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

-(void) tableView:(UITableView *)tableView  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.dao excluiContatoNaPosicao:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:true];
        
        static NSString *viewName = @"Lista Contatos";
        self.navigationItem.title = [NSString stringWithFormat:@"%@ (%ld)", viewName, (long)[self.dao getCount]];
    }
}

-(void) viewDidLoad{
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:gesture];    
}

-(void) exibeMaisAcoes:(UILongPressGestureRecognizer *)gesture{
    if(gesture.state==UIGestureRecognizerStateBegan){
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:ponto];
        self.contatoselecionado = [self.dao contatoNaPosicao:ip.row];
        _gerenciador = [[GerenciadorAcoes alloc] initWithContato:self.contatoselecionado];
        [_gerenciador fazAcoesDoController:self];
    }
}

-(void) viewDidAppear:(BOOL)animated{
    static NSString *viewName = @"Lista Contatos";
    self.navigationItem.title = [NSString stringWithFormat:@"%@ (%ld)", viewName, (long)[self.dao getCount]];
    
    UIImage *imagemLista = [UIImage imageNamed:@"lista-contatos.png"];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Lista" image:imagemLista tag:0];
    self.tabBarItem = item;

    [self.tableView reloadData];
    
    if(self.linhaDestaque)
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:self.linhaDestaque inSection:0];
        [self.tableView selectRowAtIndexPath:ip animated:true scrollPosition:UITableViewScrollPositionTop];
        self.linhaDestaque = 0;
    }
}

-(void) mostraMsgs{
    
    UIAlertView *msg = [UIAlertView new];
    msg.title = @"Titulo da msg";
    msg.message = @"Vai abrir o form";
    
    [msg addButtonWithTitle:@"OK"];
    [msg show];
    
    UIAlertController *msg2 = [UIAlertController alertControllerWithTitle:@"Documento Processado" message:@"Sua despesa foi de R$ 50,00" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Pagar" style:UIAlertActionStyleDefault handler:nil];
    [msg2 addAction:action];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleDefault handler:nil];
    [msg2 addAction:action1];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Enviar para o Gerente" style:UIAlertActionStyleDefault handler:nil];
    [msg2 addAction:action2];
    
    [self.navigationController presentViewController:msg2 animated:true completion: nil];
}

-(void) exibeFormulario: (UIButton *) sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *addForm = [storyboard instantiateViewControllerWithIdentifier:@"FormularioContato"];
    
    if (self.contatoselecionado) {
        addForm.contato = self.contatoselecionado;
        self.contatoselecionado=nil;
    }
    
    addForm.delegate = self;
    [self.navigationController pushViewController:addForm animated:true];
}

// BAZ: Sobrescrevendo os metodos da UITableViewController
// BAZ: Setando quantidiade de seções
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1; // quantidade de seçoes a serem exibidas
}

// BAZ: Setando a quantidade de linhas sempre por seçao
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dao getCount];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellName = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.textLabel.text = [self.dao contatoNaPosicao:indexPath.row].nome;
    cell.detailTextLabel.text = [self.dao contatoNaPosicao:indexPath.row].email;
    return cell;
}

-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.contatoselecionado = [self.dao contatoNaPosicao:indexPath.row];
    [self exibeFormulario: nil];
}

-(void)contatoAdicionado:(Contato *)contato{
    NSLog(@"Contato adicionado - %@", contato.description);
    self.linhaDestaque = [self.dao buscaPosicaoContato:contato];
}

-(void)contatoAtualizado:(Contato *)contato{
    NSLog(@"Contato atualizado - %@", contato.description);
    self.linhaDestaque = [self.dao buscaPosicaoContato:contato];
}

@end
