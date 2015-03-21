//
//  Contato.m
//  ContatosIP67
//
//  Created by ios5034 on 09/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import "Contato.h"

@implementation Contato
@dynamic nome, telefone, email, endereco, site, latitude, longitude, picture;

-(id)init{
    self = [super init];
    if (self) {
        self.email = @"Email não informado";
    }
    return self;
}
-(id) initWithName:(NSString *) name{
    self = [super init];
    if (self) {
        self.nome = name;
    }
    return self;
}

-(id) initWithName:(NSString *) name andEmail: (NSString *) email{
    self = [super init];
    if (self) {
        self.nome = name;
        self.email = email;
        // comments to test something
    }
    return self;
}
-(NSString *) description{
    return [NSString stringWithFormat:@"Nome %@, Telefone %@, Email %@, Endereço %@, Latitude %@, Longitude %@, Site %@", self.nome, self.telefone, self.email, self.endereco, self.latitude, self.longitude, self.site];
}

-(NSString *)title{
    return self.nome;
}

-(NSString *)subtitle{
    return self.endereco;
}

-(CLLocationCoordinate2D) coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}
@end
