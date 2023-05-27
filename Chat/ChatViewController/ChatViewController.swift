//
//  ChatViewController.swift
//  Chat
//
//  Created by Pavel Shymanski on 17.05.23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ChatViewController: UIViewController {
    
    var fireStoreCollectionName = "message"
    var senderField = "sender"
    var bodyField = "body"
    var dataField = "date"
    var messages = [Message]()
    
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.estimatedRowHeight = 44.0
        chatTableView.rowHeight = UITableView.automaticDimension
        
        title = " Chat"
        navigationItem.hidesBackButton = true
        chatTableView.dataSource = self
        
        chatTableView.register(UINib.init(nibName: "MessageTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "Message")
        loadMessages()
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    @IBAction func sendMessagebuttonPressed(_ sender: UIButton) {
        
        if let message = messageTextField.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(fireStoreCollectionName).addDocument(data: [senderField : messageSender,
                                                                         bodyField:message,
                                                                         dataField:Date().timeIntervalSince1970 ])
            { error in
                if let e = error {
                    print("There was an issue saving data to firestore,\(e)")
                }else{
                    DispatchQueue.main.async{
                        self.messageTextField.text = " "
                    }
                }
            }
        }
    }
    
    func loadMessages(){
        
        db.collection(fireStoreCollectionName).order(by: dataField).addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore.\(e)")
            }else{
                if let snapShotDocuments = querySnapshot?.documents {
                    for doc in snapShotDocuments {
                        let data = doc.data()
                        if let messageSender = data[self.senderField] as? String, let messageBody = data[self.bodyField] as? String {
                            let safeMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(safeMessage)
                            
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                                let indexPatch = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPatch, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "Message", for: indexPath) as! MessageTableViewCell
        cell.textMessage.text = message.body
        cell.selectionStyle = .none
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.avatarOne.isHidden = false
            cell.avatarTwo.isHidden = true
            cell.textMessage.backgroundColor = UIColor.systemMint
            cell.textMessage.textColor = .white
        }else{
            cell.avatarTwo.isHidden = false
            cell.avatarOne.isHidden = true
            cell.textMessage.backgroundColor = UIColor.white
            cell.textMessage.textColor = .black
        }
        return cell
    }
}


