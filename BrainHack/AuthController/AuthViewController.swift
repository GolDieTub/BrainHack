//
//  AuthViewController.swift
//  BrainHack
//
//  Created by Uladzimir on 18.05.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class AuthViewController: UIViewController{
    
    var signup = true{
        willSet{
            if newValue{
                titleLabel.text = "Регистрация"
                infoLabel.text = "У вас есть аккаунт?"
                nameField.isHidden = false
                enterButton.setTitle("Войти", for: .normal)
            } else {
                titleLabel.text = "Вход"
                infoLabel.text = "Хотите зарегистрироваться?"
                nameField.isHidden = true
                enterButton.setTitle("Регистрация", for: .normal)
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        navigationItem.hidesBackButton = true
        
    }
    @IBAction func switchLogin(_ sender: UIButton) {
        signup = !signup
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
extension AuthViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let name = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        
        if (signup){
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty){
                Auth.auth().createUser(withEmail: email, password: password){(result, error) in
                    if error == nil{
                        if let result = result{
                            print(result.user.uid)

                            let ref1 = Firestore.firestore().collection("users")
                            ref1.addDocument(data: ["name" : name, "email" : email])
                            self.dismiss(animated: true, completion: nil)
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            self.show(viewController, sender: self)
                        }
                    } else {
                        self.showAlert(message: "Такой пользователь уже зарегестрирован!")
                    }
                }
            }else{
                showAlert(message: "Заполните все поля!")
            }
        } else {
            if (!email.isEmpty && !password.isEmpty){
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if error == nil{
                        self.dismiss(animated: true, completion: nil)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        self.show(viewController, sender: self)
                    }else{
                        self.showAlert(message: "Неправильный логин или пароль!")
                    }
                }
            }else{
                showAlert(message: "Заполните все поля!")
            }
        }
        
        return true
    }
}
