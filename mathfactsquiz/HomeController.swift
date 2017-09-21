//
//  ViewController.swift
//  mathfactsquiz
//
//  Created by Michael Pavkovic on 9/8/17.
//  Copyright © 2017 Michael Pavkovic. All rights reserved.
//

import UIKit
import Toaster

class HomeController: UIViewController {
	
	var usernames: [String] = []
	var selectedUser: String?
	
	let containerView = KeyboardResizedContainerView()
	
	let inputsContainerView: UIView = {
		let view = UIView()
		
		view.backgroundColor = Palette.textInput
		view.layer.cornerRadius = 5
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
	let usernameTextField: UITextField = {
		let view = UITextField()
		
		view.placeholder = "Username"
		view.tintColor = Palette.accent
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
	let newUserButton: UIButton = {
		let view = UIButton(type: .system)
		
		view.backgroundColor = Palette.primary
		view.setTitle("New User", for: .normal)
		view.setTitleColor(UIColor.white, for: .normal)
		view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		view.titleLabel?.textAlignment = .center
		view.addTarget(self, action: #selector(promptNewUser), for: .touchUpInside)
		
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
	let usernamePicker: UIPickerView = {
		let view = UIPickerView()
		
		view.backgroundColor = Palette.textInput
		
		return view
	}()
	
	let logInButton: UIButton = {
		let view = UIButton(type: .system)
		
		view.backgroundColor = Palette.primary
		view.setTitle("Log In", for: .normal)
		view.setTitleColor(UIColor.white, for: .normal)
		view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		view.layer.cornerRadius = 25
		view.addTarget(self, action: #selector(launchDashboard), for: .touchUpInside)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = Palette.background
		
		navigationItem.title = "Math Facts Quiz"
		
		view.addSubview(containerView)
		containerView.addSubview(inputsContainerView)
		containerView.addSubview(logInButton)
		
		setupinputsContainerView()
		setupLogInButton()
		
		usernames = UserDefaults.standard.object(forKey: Constants.usernamesKey) as? [String] ?? [] as! [String]
		
		if usernames.count > 0 {
			usernameTextField.text = usernames[0]
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setupinputsContainerView() {
		inputsContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		inputsContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		inputsContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		// Max width of 400, min width of containerView's width
		
		let widthConstraint = NSLayoutConstraint(item: inputsContainerView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400)
		widthConstraint.priority = 1000
		widthConstraint.isActive = true
		
		let widthConstraint2 = NSLayoutConstraint(item: inputsContainerView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1, constant: -36)
		widthConstraint2.priority = 750
		widthConstraint2.isActive = true
		
		containerView.addConstraints([widthConstraint, widthConstraint2])
		
		inputsContainerView.addSubview(newUserButton)
		
		newUserButton.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
		newUserButton.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
		newUserButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
		newUserButton.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor).isActive = true
		
		inputsContainerView.addSubview(usernameTextField)
		
		usernameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		usernameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
		usernameTextField.rightAnchor.constraint(equalTo: newUserButton.leftAnchor).isActive = true
		usernameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor).isActive = true
		
		usernamePicker.delegate = self
		usernameTextField.delegate = self
		
		usernameTextField.inputView = usernamePicker
		
		if (usernames.count > 0) {
			usernameTextField.text = usernames[0]
		}
	}
	
	func setupLogInButton() {
		logInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		logInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
		logInButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	func launchSettings() {
		
	}
	
	func saveUsernames() {
		UserDefaults.standard.set(usernames, forKey: Constants.usernamesKey)
	}
	
	@objc func launchDashboard() {
		guard let username = usernameTextField.text,
			username.isEmpty == false
			else {
				Toast(text: "Select or create a user first").show()
				return
		}
		
		let dashboardController = DashboardController()
		dashboardController.username = username
		
		// Move selected user to first spot of username list, then select first row
		usernames.remove(at: usernames.index(of: username)!)
		usernames.insert(username, at: 0)
		usernamePicker.selectRow(0, inComponent: 0, animated: false)
		
		saveUsernames()
		
		present(UINavigationController(rootViewController: dashboardController), animated: true, completion: nil)
	}
	
	var alert: UIAlertController?
	@objc func promptNewUser() {
		alert = UIAlertController(title: "New User", message: "Enter your new username below.", preferredStyle: .alert)
		
		let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
			guard let alert = self.alert,
				let textField = alert.textFields?[0],
				let text = textField.text
				else {
					print("[Error] something related to alert is nil in HomeController")
					return
			}
			
			self.usernames.append(text)
			self.usernamePicker.reloadAllComponents()
			self.saveUsernames()
		})
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in })
		
		alert!.addTextField(configurationHandler: {(view: UITextField!) in
			view.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
		})
		alert!.addAction(okAction)
		alert!.addAction(cancelAction)
		
		alert!.actions[0].isEnabled = false	// Start out with OK disabled since text is empty
		self.present(alert!, animated: true, completion: nil)
	}
	
	@objc func textChanged(sender: AnyObject) {
		let textField = sender as! UITextField
		guard let alert = self.alert,
			let text = textField.text
			else {
				print("[Error] something related to alert is nil in HomeController")
				return
		}
		
		// Re-enable OK when text is not empty
		alert.actions[0].isEnabled = !text.isEmpty
	}
	
}

extension HomeController: UIPickerViewDelegate, UIPickerViewDataSource {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return usernames.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return usernames[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		usernameTextField.text = usernames[row]
	}
	
}

extension HomeController: UITextFieldDelegate {
	
	// When the username textfield is tapped, allow editing based on whether or not users are present
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		return usernames.count > 0
	}
	
}

