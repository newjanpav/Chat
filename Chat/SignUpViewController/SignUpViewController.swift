//
//  SignUpViewController.swift
//  Chat
//
//  Created by Pavel Shymanski on 17.05.23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        if  let email = emailTextField.text,
            let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error as NSError? {
                    print("Error code: \(error.code)")
                    print("Error description: \(error.localizedDescription)")
                }else{
                    let vc = ChatViewController(nibName: "ChatViewController", bundle: nil)
                    self?.navigationController?.pushViewController(vc, animated: true)
                   
                }
            }
        }
    }
}
