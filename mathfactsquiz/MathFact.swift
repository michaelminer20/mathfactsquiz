//
//  MathFact.swift
//  mathfactsquiz
//
//  Created by Michael Pavkovic on 9/14/17.
//  Copyright © 2017 Michael Pavkovic. All rights reserved.
//

import Foundation

struct MathFact {
	
	public var leftOperand: Int
	public var rightOperand: Int
	public var operation: MathematicalOperation
	public private(set) var answer: Int
	
	private var computeDictionary: [MathematicalOperation : (Int, Int) -> Int] = [:]
	
	init() {
		computeDictionary[.addition] = {$0 + $1}
		computeDictionary[.subtraction] = {$0 - $1}
		computeDictionary[.multiplication] = {$0 * $1}
		computeDictionary[.division] = {$0 / $1}
		
		leftOperand = 22
		rightOperand = 42
		operation = .addition
		answer = computeDictionary[operation]!(leftOperand, rightOperand)
	}
	
}

enum MathematicalOperation: Character {
	case addition = "+"
	case subtraction = "-"
	case multiplication = "×"
	case division = "÷"
}
