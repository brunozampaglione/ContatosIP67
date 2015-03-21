//
//  ContatosNoMapa-swift.swift
//  ContatosIP67
//
//  Created by ios5034 on 20/03/15.
//  Copyright (c) 2015 ios5034. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ContatosNoMapa_swift: UIViewController {
    @IBOutlet weak var mapinha : MKMapView!
    
    var dao : ContatoDao!
    var contatos : Array <AnyObject>!
    var manager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder);
    }
    
    override init (){
        super.init(nibName:"ContatosNoMapaViewController", bundle:nil)
        self.tabBarItem = UITabBarItem(title: "Map Swift", image:UIImage(named:"mapa-contatos"), tag:0)
        self.navigationItem.title = "Mapa Swift"
        self.dao = ContatoDao.contatoDaoInstance() as ContatoDao
        self.contatos = self.dao.contatos
    }
    
    override func viewWillAppear(animated: Bool){
        self.mapinha.addAnnotations(self.contatos);
    }

    override func viewWillDisappear(animated: Bool){
        self.mapinha.removeAnnotations(self.contatos);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
