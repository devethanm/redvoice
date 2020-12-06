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
	
	let manager = UDM.manager
	
	init(userSymbols: [String]) {
		self.symbols = userSymbols
		self.returnText = ""
	}
	
	init() {
		symbols = ["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "ok!", "slatt", "!"]
		returnText = ""
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
