//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios5034 on 17/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

#import "ContatosNoMapaViewController.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MKUserTrackingBarButtonItem *seta = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapinha];
    self.navigationItem.rightBarButtonItem = seta;
    
    // Lembrar de sempre preencher o delegate quando você delegar de aluma classe
    self.mapinha.delegate = self;
    
    self.locManager = [CLLocationManager new];
    [self.locManager requestWhenInUseAuthorization];
}

-(void) viewDidAppear:(BOOL)animated{
    [self.mapinha addAnnotations:[self.dao contatos]];
}

-(void) viewDidDisappear:(BOOL)animated{
    [self.mapinha removeAnnotations:[self.dao contatos]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id) init{
    self = [super init];
    if(self){
        self.navigationItem.title = @"Mapa";
        UIImage *imagemMapa = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imagemMapa tag:0];
        self.tabBarItem = item;
        self.dao = [ContatoDao contatoDaoInstance];
       
    }
    return self;
}

-(MKAnnotationView *) mapView:(MKMapView *) mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass: [MKUserLocation class]]){
        return nil;
    }
    
    // Cria identificador para evitar ficar recriando pinos
    static NSString *identificador = @"pino";
    // Seta o mapa para reutilizar identificadores -- faz o cast pois o metodo retorna o tipo mais generico
    MKPinAnnotationView *pino = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identificador];
    if(!pino){
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identificador];
    }
    else{
        pino.annotation = annotation;
    }
    // Como já sabemos que a annotation no fundo no fundo é um contato, podemos fazer o cast
    Contato *contato = (Contato * ) annotation;
    
    // Ve se o contato tem foto, para colocar no pine
    if(contato.picture){
        // Cria a imagview com o tamanho maximo possivel 32 x 32
        UIImageView *image = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 32, 32))];
        // adiciona a foto do contato no imageview
        image.image = contato.picture;
        // Adciona a imageview no pino
        pino.leftCalloutAccessoryView = image;
        pino.canShowCallout = true;
        pino.pinColor = MKPinAnnotationColorGreen;
    }
    else{
        pino.canShowCallout = true;
        pino.pinColor = MKPinAnnotationColorPurple;
    }
    return pino;
}

@end
