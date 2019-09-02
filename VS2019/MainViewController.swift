//
//  MainViewController.swift
//  VS2019
//
//  Created by Quân Đinh on 02.09.19.
//  Copyright © 2019 Quân Đinh. All rights reserved.
//

import UIKit
import JTMaterialTransition

class MainViewController: UIViewController {
    
    @IBOutlet weak var q1Button: UIButton!
    @IBOutlet weak var q2Button: UIButton!
    @IBOutlet weak var q3Button: UIButton!
    var transition1: JTMaterialTransition?
    var transition2: JTMaterialTransition?
    var transition3: JTMaterialTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transition1 = JTMaterialTransition(animatedView: q1Button)
        self.transition2 = JTMaterialTransition(animatedView: q2Button)
        self.transition3 = JTMaterialTransition(animatedView: q3Button)
        q1Button.addTarget(self, action: #selector(presentQ1), for: .touchUpInside)
        q2Button.addTarget(self, action: #selector(presentQ2), for: .touchUpInside)
        q3Button.addTarget(self, action: #selector(presentQ3), for: .touchUpInside)
    }
    
    @objc func presentQ1 () {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "q1") as! ViewController
        
        destination.modalPresentationStyle = .custom
        destination.transitioningDelegate = self.transition1
        
        self.present(destination, animated: true, completion: nil)
    }
    
    @objc func presentQ2 () {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "q2") as! ViewController1
        
        destination.modalPresentationStyle = .custom
        destination.transitioningDelegate = self.transition2
        
        self.present(destination, animated: true, completion: nil)
    }
    
    @objc func presentQ3 () {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "q3") as! ViewController2
        
        destination.modalPresentationStyle = .custom
        destination.transitioningDelegate = self.transition3
        
        self.present(destination, animated: true, completion: nil)
    }

}
