//
//  Contato.h
//  ContatosIP67
//
//  Created by ios5034 on 09/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject <MKAnnotation>

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *email;
@property (strong) NSString *endereco;
@property (strong) NSString *site;
@property (strong) UIImage *picture;
@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;

-(id) initWithName: (NSString *) name;
-(id) initWithName: (NSString *) name andEmail: (NSString *) email;

@end
