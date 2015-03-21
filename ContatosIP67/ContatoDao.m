//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by ios5034 on 10/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao
static ContatoDao *defaultDao = nil;
-(id) init{
    self = [super init];
    if(self){
        [self insereDados];
        [self carregaContatos];
        if(!self.contatos){
            _contatos = [NSMutableArray new];
        }
    }
    return self;
}

-(void) adicionarContato: (Contato*) contato{
    [self.contatos addObject:contato];
}

+(id) contatoDaoInstance{
    if(!defaultDao){
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

-(NSInteger) getCount{
    return [self.contatos count];
}

-(Contato *) contatoNaPosicao:(NSInteger)posicao{
    return [self.contatos objectAtIndex:posicao];
}

-(void) excluiContatoNaPosicao:(NSInteger)posicao{
    [self.contatos removeObjectAtIndex:posicao];
}

-(NSInteger) buscaPosicaoContato:(Contato*)contato{
    return [self.contatos indexOfObject:contato];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "br.com.ourcompany.ContatosIP67" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ContatosIP67" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ContatosIP67.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void) insereDados{
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    BOOL dadosInseridos = [config boolForKey:@"dados_inseridos"];
    if(!dadosInseridos){
        Contato *contatoinit = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
        contatoinit.nome = @"Bruno Zampaglione";
        contatoinit.endereco = @"rua professor olimpio da fonseca, 17 vila-valqueire";
        contatoinit.email = @"brunozampaglione@bol.com.br";
        contatoinit.telefone = @"2424-3868";
        contatoinit.site = @"www.bruno.com.br";
        contatoinit.latitude = [NSNumber numberWithDouble:-98.322];
        contatoinit.longitude = [NSNumber numberWithDouble:23.434];
        
        [self saveContext];;
        [config setBool:YES
                 forKey:@"dados_inseridos"];
        [config synchronize];
    }
}

-(Contato *) novoContato{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
}

-(void) carregaContatos{
    // Gera query similar ao select * from...
    NSFetchRequest *query = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    // Adiciona criterios de ordenação
    NSSortDescriptor *ordenaPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:true];
    // Metodo sortDescriptor recebe um array com o objeto de sort
    query.sortDescriptors = @[ordenaPorNome];
    NSArray *result = [self.managedObjectContext executeFetchRequest:query error:nil];
    _contatos = [result mutableCopy];
}

@end
