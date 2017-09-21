//
//  Extensions.swift
//  mathfactsquiz
//
//  Created by Michael Pavkovic on 9/8/17.
//  Copyright © 2017 Michael Pavkovic. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
		self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
	}
}

extension UIView {
	func addBottomBorder(withColor color: UIColor, height: CGFloat) {
		let border = UIView()

		border.backgroundColor = color
		
		frame.size.height += height
		
		addSubview(border)
		
		border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		border.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		border.heightAnchor.constraint(equalToConstant: height).isActive = true
	}
}

extension UIButton {
	class func bigBlueButtonInContainer(title: String) -> UIButton {
		let view = UIButton(type: .system)
		
		view.backgroundColor = Palette.primary
		view.setTitle(title, for: .normal)
		view.setTitleColor(UIColor.white, for: .normal)
		view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}
}
