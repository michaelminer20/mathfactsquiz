//
//  Pallete.swift
//  mathfactsquiz
//
//  Created by Michael Pavkovic on 9/8/17.
//  Copyright © 2017 Michael Pavkovic. All rights reserved.
//

import Foundation
import UIKit

class Palette {
	static var background: UIColor = UIColor(r: 237, g: 242, b: 243)
	static var buttonText: UIColor = UIColor(r: 32, g: 110, b: 149)
	static var textInput: UIColor = UIColor(r: 212, g: 222, b: 225)
	
	static var primary: UIColor = UIColor(r: 45, g: 172, b: 211)
	static var primaryDark: UIColor = UIColor(r: 32, g: 110, b: 149)
	static var accent: UIColor = UIColor(r: 85, g: 46, b: 84)

}

class Dimensions {
	static var buttonWidth = 128
	static var screenWidth: CGFloat {
		get {
			return min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
		}
	}
}

class Constants {
	static var usernamesKey = "com.mpavkovic.mathfactsquiz.usernames"
}
