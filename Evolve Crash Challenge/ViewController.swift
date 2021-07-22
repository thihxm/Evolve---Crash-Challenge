//
//  ViewController.swift
//  Evolve Crash Challenge
//
//  Created by Thiago Medeiros on 21/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 300))
//        label.text = "Você está em lugar escuro. Consciente, mas não sabe onde está. Você escolhe:"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        view.addSubview(label)
    }


}

