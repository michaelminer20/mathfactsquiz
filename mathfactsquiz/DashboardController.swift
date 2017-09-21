//
//  GameControllerViewController.swift
//  mathfactsquiz
//
//  Created by Michael Pavkovic on 9/8/17.
//  Copyright © 2017 Michael Pavkovic. All rights reserved.
//

import UIKit

class DashboardController: UIViewController {
	
	var username: String = ""
	
	let scrollView: UIScrollView = {
		let view = UIScrollView()
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	let containerStackView: UIStackView = {
		let view = UIStackView()
		
		view.axis = .vertical
		view.distribution = .equalSpacing
		view.alignment = .leading
		view.spacing = 12.5
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	let welcomeLabel: UILabel = {
		let view = UILabel()
		
		view.font = UIFont.systemFont(ofSize: 30, weight: 300)
		view.lineBreakMode = .byWordWrapping
		view.numberOfLines = 100
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
		
	}()
	
	let startQuizButton: UIButton = {
		let view = UIButton(type: .system)
		
		view.backgroundColor = Palette.primary
		view.setTitle("Start Quiz", for: .normal)
		view.setTitleColor(UIColor.white, for: .normal)
		view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		view.layer.cornerRadius = 25
		view.addTarget(self, action: #selector(launchQuiz), for: .touchUpInside)
		
		view.layer.masksToBounds = true
		
		return view
	}()
	
	let actionsContainerView: UIView = {
		let view = UIView()
		
		view.layer.cornerRadius = 25
		
		view.layer.masksToBounds = true
		
		view.translatesAutoresizingMaskIntoConstraints = false

		
		return view
	}()
	
	let adjustDifficultyButton = UIButton.bigBlueButtonInContainer(title: "Adjust Difficulty")
	
	let viewProgressButton = UIButton.bigBlueButtonInContainer(title: "View Progress")
	
	let numberAdjustmentStackView: UIStackView = {
		let view = UIStackView()
		
		view.axis = .vertical
		view.distribution = .equalSpacing
		view.alignment = .leading
		view.spacing = 12
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()

	override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = Palette.background
		
		let logOutButton = UIBarButtonItem()
		logOutButton.title = "Log Out"
		logOutButton.target = self
		logOutButton.action = #selector(logOut)
		
		navigationItem.leftBarButtonItem = logOutButton
		navigationItem.title = "Dashboard"
		
		view.addSubview(scrollView)
		scrollView.addSubview(containerStackView)
		containerStackView.addArrangedSubview(welcomeLabel)
		containerStackView.addArrangedSubview(startQuizButton)
		containerStackView.addArrangedSubview(actionsContainerView)
//		containerStackView.addArrangedSubview(numberAdjustmentStackView)
		
		setupScrollView()
		setupContainerStackView()
		setupActionsContainerView()
		
		startQuizButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		startQuizButton.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
		
//		setupNumberAdjustmentStackView()
		
		welcomeLabel.text = "Welcome, \(username)!\n"

	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
		
    }
	
	func setupScrollView() {
		scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive =	true
		scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
		scrollView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
	}
	
	func setupContainerStackView() {
		containerStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
		containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
	}
	
	func setupActionsContainerView() {
		actionsContainerView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
		actionsContainerView.heightAnchor.constraint(equalToConstant: 103).isActive = true
		
		actionsContainerView.addSubview(adjustDifficultyButton)
		actionsContainerView.addSubview(viewProgressButton)
		
		adjustDifficultyButton.leftAnchor.constraint(equalTo: actionsContainerView.leftAnchor).isActive = true
		adjustDifficultyButton.topAnchor.constraint(equalTo: actionsContainerView.topAnchor).isActive = true
		adjustDifficultyButton.widthAnchor.constraint(equalTo: actionsContainerView.widthAnchor).isActive = true
		adjustDifficultyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		viewProgressButton.leftAnchor.constraint(equalTo: actionsContainerView.leftAnchor).isActive = true
		viewProgressButton.topAnchor.constraint(equalTo: adjustDifficultyButton.bottomAnchor, constant: 3).isActive = true
		viewProgressButton.widthAnchor.constraint(equalTo: actionsContainerView.widthAnchor).isActive = true
		viewProgressButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	func setupNumberAdjustmentStackView() {
		numberAdjustmentStackView.addArrangedSubview(assembleNewNumberAdjustmentContainerView(for: .addition))
		numberAdjustmentStackView.addArrangedSubview(assembleNewNumberAdjustmentContainerView(for: .subtraction))
	}
	
	func assembleNewNumberAdjustmentContainerView(for operation: MathematicalOperation) -> UIView {
		let view = UIView()
		
		let operationCharacterLabel: UILabel = {
			let view = UILabel()
			
			view.text = "Multiplication"
			view.textColor = Palette.accent
			view.font = UIFont(name: "Avenir Next", size: 12)
			view.textAlignment = .center
			
			view.layer.cornerRadius = 10
			view.layer.borderWidth = 2
			view.layer.borderColor = Palette.accent.cgColor
			
			view.translatesAutoresizingMaskIntoConstraints = false
			
			
			return view
		}()
		
		view.addSubview(operationCharacterLabel)
		
		operationCharacterLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		operationCharacterLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		operationCharacterLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
		operationCharacterLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
//		view.widthAnchor.constraint(equalToConstant: 50).isActive = true
		view.heightAnchor.constraint(equalToConstant: 50).isActive = true

		
		return view
	}
	
	@objc func launchQuiz() {
		let quizController = QuizController()
		
		present(UINavigationController(rootViewController: quizController), animated: true, completion: nil)
	}
	
	@objc func logOut() {
		dismiss(animated: true, completion: nil)
	}

}
