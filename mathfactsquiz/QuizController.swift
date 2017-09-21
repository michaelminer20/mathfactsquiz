//
//  QuizController.swift
//  mathfactsquiz
//
//  Created by Michael Pavkovic on 9/16/17.
//  Copyright © 2017 Michael Pavkovic. All rights reserved.
//

import UIKit

class QuizController: UIViewController {

	let containerView = KeyboardResizedContainerView()
	
	let mathFactView = MathFactView()
	
	let stackViewContainerView: UIView = {
		let view = UIView()
		
		view.layer.cornerRadius = 12
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
	let answerInputContainerStackView: UIStackView = {
		let view = UIStackView()
		
		view.axis = .horizontal
		view.distribution = .fillEqually
		view.alignment = .leading
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
	let clearButton: UIButton = {
		let view = UIButton()
		
		view.backgroundColor = Palette.primary
		view.setTitle("Clear", for: .normal)
		view.setTitleColor(UIColor.white, for: .normal)
		view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
	let answerTextField: UITextField = {
		let view = UITextField()
		
		view.backgroundColor = Palette.textInput
		view.placeholder = "Answer"
		view.tintColor = Palette.accent
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
	let submitButton: UIButton = {
		let view = UIButton()
		
		view.backgroundColor = Palette.primary
		view.setTitle("Submit", for: .normal)
		view.setTitleColor(UIColor.white, for: .normal)
		view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.masksToBounds = true
		
		return view
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = Palette.background
		
		navigationItem.title = "Solve the equation"
		
		edgesForExtendedLayout = .bottom
		
		view.addSubview(containerView)
		containerView.addSubview(stackViewContainerView)
		stackViewContainerView.addSubview(answerInputContainerStackView)
		containerView.addSubview(mathFactView)
		answerInputContainerStackView.addArrangedSubview(clearButton)
		answerInputContainerStackView.addArrangedSubview(answerTextField)
		answerInputContainerStackView.addArrangedSubview(submitButton)

		setupAnswerInputContainerViews()
        setupMathFactView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func setupAnswerInputContainerViews() {
		let heightToFraction = stackViewContainerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1 / 3)
		heightToFraction.priority = 750
		
		let heightToConstant = stackViewContainerView.heightAnchor.constraint(lessThanOrEqualToConstant: 70)
		heightToConstant.priority = 1000
		
		NSLayoutConstraint.activate([heightToFraction, heightToConstant])
		stackViewContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		stackViewContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -Dimensions.screenWidth / 20).isActive = true
		stackViewContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Dimensions.screenWidth / 40).isActive = true
		
		answerInputContainerStackView.leftAnchor.constraint(equalTo: stackViewContainerView.leftAnchor).isActive = true
		answerInputContainerStackView.topAnchor.constraint(equalTo: stackViewContainerView.topAnchor).isActive = true
		answerInputContainerStackView.widthAnchor.constraint(equalTo: stackViewContainerView.widthAnchor).isActive = true
		answerInputContainerStackView.heightAnchor.constraint(equalTo: stackViewContainerView.heightAnchor).isActive = true
		
		clearButton.heightAnchor.constraint(equalTo: answerInputContainerStackView.heightAnchor).isActive = true
		answerTextField.heightAnchor.constraint(equalTo: answerInputContainerStackView.heightAnchor).isActive = true
		submitButton.heightAnchor.constraint(equalTo: answerInputContainerStackView.heightAnchor).isActive = true
	}
	
	func setupMathFactView() {
		mathFactView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		mathFactView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		mathFactView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
		mathFactView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 2 / 3, constant: -Dimensions.screenWidth / 20).isActive = true
		
		mathFactView.setup()
		mathFactView.mathFact = MathFact()
	}

}
