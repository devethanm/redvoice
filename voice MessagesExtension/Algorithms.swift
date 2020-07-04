//
//  Algorithms.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 7/2/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import Foundation

public class Algorithm {
	
	func originalGen() -> ( String ) {
		
		let symbols = ["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "**", "++", "*+", "🦋🦋🦋" ]
		
		let randSymbol1 = symbols.randomElement();
		let randSymbol2 = symbols.randomElement();
		let randSymbol3 = symbols.randomElement();
		let randSymbol4 = symbols.randomElement();
		
		let randNum = Int.random( in: 1...2 )
		
		if randNum == 1 {
			
			let randNum2 = Int.random( in: 1...3 )
			
			if randNum2 == 1{
				return randSymbol1 ?? " "
			}
			else if randNum2 == 2{
				let randCollection = randSymbol1! + randSymbol2!
				return randCollection
			}
			else if randNum2 == 3{
				let randCollection = randSymbol1! + randSymbol2! + randSymbol3!
				return randCollection
			}
			
		}
			
		else {
			
			let randNum2 = Int.random(in:2...4)
			
			if randNum2 == 2 {
				let randCollection = randSymbol1! + randSymbol2!
				return randCollection
			}
			else if randNum2 == 3 {
				let randCollection = randSymbol1! + randSymbol2! + randSymbol3!
				return randCollection
			}
			else if randNum2 == 4 {
				let randCollection = randSymbol1! + randSymbol2! + randSymbol3! + randSymbol4!
				return randCollection
			}
			
		}
		
		return " "
	}
	
	func endGen() -> String {
		
		var symbolstr = " "
		let symbols = ["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "ok!", "slatt", "!"]
		
		let randsym1 = symbols.randomElement()
		let randsym2 = symbols.randomElement()
		
		let firstrand = Int.random(in:1...2)
		
		if firstrand == 1 {
			symbolstr = randsym1!
			return symbolstr
		}
		else if firstrand == 2 {
			symbolstr = randsym1! + randsym2!
			return symbolstr
		}
		
		return " "
	}
	
}
