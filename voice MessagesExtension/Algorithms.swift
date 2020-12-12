//
//  algNums.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 7/2/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import Foundation

public class Generator {
	
	var symbols: [String]
	var returnText: String
	var caseChanging: Bool
	var frequency: Int
	let manager = UDM.manager
	
	init() {
		symbols = ["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "ok!", "slatt", "!"]
		returnText = ""
		caseChanging = false
		frequency = 1
	}
	
	func generate(algNum: Int, text: String) -> String {
		returnText = ""
		let textArray = text.split(separator: " ")
		let selectedAlgorithmString = String(algNum)
		let algSymbolsString = "alg" + selectedAlgorithmString + "Symbols"
		let algCCString = "alg" + selectedAlgorithmString + "CC"
		let algFreqString = "alg" + selectedAlgorithmString + "Freq"
		
		symbols = manager.defaults.stringArray(forKey: algSymbolsString)!
		caseChanging = manager.defaults.bool(forKey: algCCString)
		frequency = manager.defaults.integer(forKey: algFreqString)
		
		if Int.random(in: 1...frequency) != 1 {
			returnText += symbols.randomElement() ?? " "
			returnText += " "
		}
		
		if caseChanging {
			for word in textArray {
				if Int.random(in: 1...frequency) != 1 {
					returnText += (caseChange(word: String(word)) + " " + symbols.randomElement()! + " ")
				}
				else {
					returnText += (caseChange(word: String(word)) + " ")
				}
			}
		}
		else  {
			for word in textArray {
				if Int.random(in: 1...frequency) != 1 {
					returnText += (word + " " + symbols.randomElement()! + " ")
				}
				else {
					returnText += (word + " ")
				}
			}
		}
		
		return returnText
	}
	
	func caseChange(word: String) -> String {
		var caseChangedWord = ""
		
		for letter in word {
			let randNum = Int.random(in: 1...2)
			if randNum == 1 {
				caseChangedWord += letter.uppercased()
			}
			else {
				caseChangedWord += letter.lowercased()
			}
		}
		
		return caseChangedWord
	}

}



















	
	/*
	func returnSymbols(algNum: Int) -> [String] {
		
		if algNum == 0 {
			return ["!", "*^!", "*", "^", "*^", "! +", "+", "! +:)", ". x", "_", "!!", "*+_", "*!+:)", ":)", "*+", "++", "**"]
		}
		else if algNum == 1 {
			return ["💔", "🖤", "🧛🏿‍♂️", "💋", "!"]
		}
		else if algNum == 2 {
			return ["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "!"]
		}
		else if algNum == 3 {
			return ["👻","🎃","🕸","😨","🧡","🍁"]
		}
		else {
			return self.symbols
		}
	}
	*/
	/*
	func generate(algNum: Int, text:String) -> String {
		
		let textarray = text.split(separator: " ")
		returnText = "";
		
		if algNum == 0 {
			
			symbols = manager.defaults.stringArray(forKey: "alg0Symbols") ?? ["hello"]
			
			returnText += symbols.randomElement() ?? " "
			returnText += " "
			for word in textarray {
				returnText += (word + " " + symbols.randomElement()! + " ")
			}
			
			return returnText
		}
		else if algNum == 1 {
			
			symbols = manager.defaults.stringArray(forKey: "alg1Symbols")!
			
			returnText += symbols.randomElement() ?? " "
			returnText += " "
			for word in textarray {
				returnText += (word + " " + symbols.randomElement()! + " ")
			}
			
			return returnText
		}
		else if algNum == 2 {
			
			symbols = manager.defaults.stringArray(forKey: "alg2Symbols")!
			
			returnText += symbols.randomElement() ?? " "
			returnText += " "
			for word in textarray {
				returnText += (word + " " + symbols.randomElement()! + " ")
			}
			
			return returnText
			
		}
		else if algNum == 3 {
			
			symbols = manager.defaults.stringArray(forKey: "alg3Symbols")!
			
			returnText += symbols.randomElement() ?? " "
			returnText += " "
			for word in textarray {
				returnText += (word + " " + symbols.randomElement()! + " ")
			}
			
			return returnText
			
		}
		else { return returnText }
		
	}

}
*/
