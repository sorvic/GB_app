//
//  LoginFormViewController.swift
//  VK_app
//
//  Created by Viktor S on 18.03.2022.
//

import UIKit

class LoginFormViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // В этих методах получим размер клавиатуры и увеличим внутренний размер UIScrollview, получив прокрутку
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {

        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)

        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets }

    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) { // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }

    // Теперь надо подписаться на сообщения из центра уведомлений, которые рассылает клавиатура
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)

        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // от уведомлений надо отписываться, когда они не нужны
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // добавим исчезновение клавиатуры при клике в пустом месте
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    // И добавим жест нажатия к UIScrollView
    override func viewDidLoad() {
        super.viewDidLoad()

        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }

    // Напишем логику авторизации в метод нажатия кнопки
    @IBAction func ClickLoginButton(_ sender: Any) {
        // Получаем текст логина
        let login = loginTextField.text!
        // Получаем текст-пароль
        let password = pswdTextField.text!

        // Проверяем, верны ли они
        if login == "admin" && password == "123456" {
            print("успешная авторизация")
        } else {
            print("неуспешная авторизация")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
