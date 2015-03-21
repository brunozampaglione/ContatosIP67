//
//  ContatoDao.h
//  ContatosIP67
//
//  Created by ios5034 on 10/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"
#import <CoreData/CoreData.h>

@interface ContatoDao : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;
-(Contato *) novoContato;

@property (readonly) NSMutableArray *contatos;

-(void) adicionarContato: (Contato*) contato;
+(id) contatoDaoInstance;

-(NSInteger) getCount;
-(Contato *) contatoNaPosicao:(NSInteger)posicao;
-(void) excluiContatoNaPosicao:(NSInteger)posicao;
-(NSInteger) buscaPosicaoContato:(Contato*)contato;
@end
