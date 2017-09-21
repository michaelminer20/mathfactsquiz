//
//  MathFactView.swift
//  mathfactsquiz
//
//  Created by Michael Pavkovic on 9/16/17.
//  Copyright © 2017 Michael Pavkovic. All rights reserved.
//

import UIKit

class MathFactView: UIView {

	var mathFact: MathFact {
		get {
			return self.mathFact
		}
		
		set(mathFact) {
			numbersLabel.text = "\(mathFact.leftOperand) \(mathFact.operation.rawValue) \(mathFact.rightOperand) = ?"
		}
	}
	
	private var containerView: UIView = {
		let view = UIView()
		
		view.backgroundColor = Palette.textInput
		view.layer.cornerRadius = Dimensions.screenWidth / 20
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
	
		return view
	}()
	private var numbersLabel = UILabel()
	private var timeRemainingView = UIProgressView()
	
	func setup() {
		translatesAutoresizingMaskIntoConstraints = false
		layer.masksToBounds = true
		
		
		timeRemainingView.translatesAutoresizingMaskIntoConstraints = false
		timeRemainingView.layer.masksToBounds = true
		
		addSubview(timeRemainingView)
		timeRemainingView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		timeRemainingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		timeRemainingView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		
		timeRemainingView.progress = 0.75
	
		
		addSubview(containerView)
		containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		containerView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Dimensions.screenWidth / 20).isActive = true
		containerView.topAnchor.constraint(equalTo: timeRemainingView.bottomAnchor, constant: Dimensions.screenWidth / 40).isActive = true
		containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		
		numbersLabel.font = UIFont(name: "Avenir Next", size: Dimensions.screenWidth / 10)
		numbersLabel.textAlignment = .center
		numbersLabel.numberOfLines = 0
		numbersLabel.textColor = Palette.primary
		
		numbersLabel.translatesAutoresizingMaskIntoConstraints = false
		
		containerView.addSubview(numbersLabel)
		numbersLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		numbersLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
		numbersLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 272).isActive = true
	}
}
