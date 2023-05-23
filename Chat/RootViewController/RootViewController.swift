//
//  ViewController.swift
//  Chat
//
//  Created by Pavel Shymanski on 17.05.23.
//

import UIKit

class RootViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
           
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func SignInButtonPressed(_ sender: UIButton) {
        let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
