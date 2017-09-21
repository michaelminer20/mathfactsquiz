//
//  KeyboardResizedView.swift
//
//  Created by Michael Pavkovic on 9/9/17.
//
//  This view expands to fill its parent view, and then changes its height depending on whether a keyboard is currently shown
//
//	It's open source!
//  Free to use under the MIT liscense
//

import UIKit

class KeyboardResizedContainerView: UIView {
	private var bottomConstraint: NSLayoutConstraint?
	
	func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		
		if let parentView = superview {
			topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
			leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
			widthAnchor.constraint(equalTo: parentView.widthAnchor).isActive = true
			bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1, constant: 0)
			bottomConstraint?.isActive = true
			parentView.addConstraint(bottomConstraint!)
		}
		
		registerForKeyboardNotifications()
	}
	
	override func didMoveToSuperview() {
		setup()
	}
	
	private func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}
	
	func keyboardWillShow(_ aNotification: Notification) {
		guard let userInfo = aNotification.userInfo,
			let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
			let bottomConstraint = self.bottomConstraint
			
			else {
				print("[Error] Something in KeyboardResizedContainerView went wrong.")
				return
			}

		UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
			bottomConstraint.constant = -keyboardFrame.size.height
			
			self.layoutIfNeeded()
		}, completion: nil)
		
	}
	
	func keyboardWillHide(_ aNotification: Notification) {
		guard let bottomConstraint = self.bottomConstraint
			
			else {
				print("[Error] originalHeight in KeyboardResizedContainerView is nil")
				return
			}
		
		UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
			bottomConstraint.constant = 0
			
			self.layoutIfNeeded()
		}, completion: nil)
	}
	
}
