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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        if  let email = emailTextField.text,
            let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error as NSError? {
                    print("Error code: \(error.code)")
                    print("Error description: \(error.localizedDescription)")
                }else{
                    self?.activityIndicator.stopAnimating()
                    let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                    self?.navigationController?.pushViewController(vc, animated: true)
                   
                }
            }
        }
    }
}
