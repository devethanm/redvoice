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
		//let algSymbolsString = "alg" + selectedAlgorithmString + "Symbols"
		//let algCCString = "alg" + selectedAlgorithmString + "CC"
		//let algFreqString = "alg" + selectedAlgorithmString + "Freq"
		
		let allSymbols = manager.defaults.array(forKey: "algSymbols")!
		
		symbols = allSymbols[algNum] as! [String]
		
		let allCC = manager.defaults.array(forKey: "algCCs")
		caseChanging = allCC![algNum] as! Bool
		
		let allFreq = manager.defaults.array(forKey: "algFreqs")
		frequency = allFreq![algNum] as! Int
		
		if frequency <= 1 {
			frequency = 2
		}
		
		if Int.random(in: 1...frequency) != 1 {
			returnText += symbols.randomElement() ?? " "
			returnText += " "
		}
		
		if caseChanging {
			for word in textArray {
				//if frequency == 1{ frequency = 2 }
				
				if Int.random(in: 1...frequency) != 1 {
					if Int.random(in: 1...frequency) != 1 {
						returnText += (caseChange(word: String(word)) + " " + symbols.randomElement()! + " ")
					}
					else {
						returnText += (caseChange(word: String(word)) + " ")
					}
				}
				else {
					returnText += (caseChange(word: String(word)) + " ")
				}
			}
		}
		else  {
			for word in textArray {
				if frequency == 1{ frequency = 2 }
				if Int.random(in: 1...frequency) != 1 {
					if Int.random(in: 1...frequency) != 1 {
						returnText += (word + " " + symbols.randomElement()! + " ")
					}
					else {
						returnText += (word + " ")
					}
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

