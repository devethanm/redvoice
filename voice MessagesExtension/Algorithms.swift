//
//  Algorithms.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 7/2/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import Foundation

public class Generate {
	
	var symbols: [String]
	var returnText: String
	
	init() {
		symbols = ["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "ok!", "slatt", "!"]
		returnText = ""
	}
	
	func generate(algorithm: String, text:String) -> String {
		
		let textarray = text.split(separator: " ")
		returnText = "";
		
		if algorithm == "original" {
			
			symbols = ["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "ok!", "slatt", "!"]
			
			returnText += symbols.randomElement() ?? " "
			returnText += " "
			for word in textarray {
				returnText += (word + " " + symbols.randomElement()! + " ")
			}
			returnText += " " + symbols.randomElement()!
			
			return returnText
		}
		else if algorithm == "no words" {
			
			symbols = ["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "!"]
			
			returnText += symbols.randomElement() ?? " "
			returnText += " "
			for word in textarray {
				returnText += (word + " " + symbols.randomElement()! + " ")
			}
			returnText += " " + symbols.randomElement()!
			
			return returnText
			
		}
		else if algorithm == "halloween" {
			
			symbols = ["👻","🎃","🕸","😨","🧡","🍁"]
			
			returnText += symbols.randomElement() ?? " "
			returnText += " "
			for word in textarray {
				returnText += (word + " " + symbols.randomElement()! + " ")
			}
			returnText += " " + symbols.randomElement()!
			
			return returnText
			
		}
		else { return returnText }
		
	}

}
