//
//  SettingsViewController.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 10/15/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import UIKit
import Messages

class SettingsViewController: MSMessagesAppViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
	
	
	var mainVC: MessagesViewController!
	
	let manager = UDM.manager
	
	var masterAlgorithms = [String]()
	var selectedAlgorithm = 0
	var alert = 0
	
	// var mainVC: MessagesViewController!

	@IBOutlet weak var exitButton: UIImageView!
	@IBOutlet weak var algPickerView: UIPickerView!
	@IBOutlet weak var editButton: UIButton!
	@IBOutlet weak var removeButton: UIButton!
	@IBOutlet weak var defaultsButton: UIButton!
	@IBOutlet weak var createButton: UIButton!
	
	@IBOutlet weak var editView: UIView!
	@IBOutlet weak var editLabel: UILabel!
	@IBOutlet weak var editTextField: UITextField!
	@IBOutlet weak var editFrequency: UILabel!
	@IBOutlet weak var editCaseChanging: UISwitch!
	@IBOutlet weak var editChangeFrequency: UIStepper!
	
	@IBOutlet weak var alertView: UIView!
	@IBOutlet weak var alertLabel: UILabel!
	@IBOutlet weak var alertYes: UIButton!
	@IBOutlet weak var alertNo: UIButton!
	
	@IBOutlet weak var createView: UIView!
	@IBOutlet weak var algNameTextField: UITextField!
	@IBOutlet weak var createSymbolsTextField: UITextField!
	@IBOutlet weak var createStepper: UIStepper!
	@IBOutlet weak var createFrequencyNumber: UILabel!
	@IBOutlet weak var createSwitch: UISwitch!
	
	// handles press on the exit button / picture
	@IBAction func exitButtonPressed() {
		mainVC.algorithms = manager.defaults.stringArray(forKey: "algorithms")!
		mainVC.pickerView.reloadAllComponents()
		requestPresentationStyle(.compact)
		dismiss(animated:true, completion: nil)
	}
	
	@IBAction func createButtonPressed(_ sender: Any) {
		requestPresentationStyle(.expanded)
		createStepper.value = 1.0
		createFrequencyNumber.text = String(1)
		createSwitch.isOn = false
		createSymbolsTextField.text = ("")
		algNameTextField.text = ("Enter Alg Name Here")
		createButton.isHidden = true
		defaultsButton.isHidden = true
		exitButton.isHidden = true
		createView.isHidden = false
	}
	
	@IBAction func createStepperChanged(_ sender: Any) {
		if createStepper.value >= 5.0 {
			createStepper.value = 5.0
		}
		if createStepper.value <= 1.0 {
			createStepper.value = 1.0
		}
		createFrequencyNumber.text = String(Int(createStepper.value))
	}
	
	@IBAction func finishedCreating(_ sender: Any) {
		requestPresentationStyle(.compact)
		masterAlgorithms = manager.defaults.stringArray(forKey: "algorithms")!
		algPickerView.reloadAllComponents()
		createView.isHidden = true
		createButton.isHidden = false
		defaultsButton.isHidden = false
		exitButton.isHidden = false
	}
	
	@IBAction func saveAlgorithmPressed(_ sender: Any) {
		
		if algNameTextField.text == "" || createSymbolsTextField.text == "" {
			
		}
		else {
			let algorithms = manager.defaults.stringArray(forKey: "algorithms")
			let allSymbols = manager.defaults.array(forKey: "algSymbols")!
			let allCC = manager.defaults.array(forKey: "algCCs")
			let allFreq = manager.defaults.array(forKey: "algFreqs")
			
			var tempAlgs = algorithms
			tempAlgs!.append(algNameTextField.text ?? "")
			manager.defaults.setValue(tempAlgs, forKey: "algorithms")
			
			
			var tempSymbols = allSymbols
			let tempArr = createSymbolsTextField.text?.components(separatedBy: " ")
			tempSymbols.append(tempArr!)
			manager.defaults.setValue(tempSymbols, forKey: "algSymbols")
			
			var tempCC = allCC
			if createSwitch.isOn {
				tempCC!.append(true)
			}
			else {
				tempCC!.append(false)
			}
			manager.defaults.setValue(tempCC, forKey: "algCCs")
			
			var tempFreq = allFreq
			tempFreq!.append(Int(createStepper.value))
			manager.defaults.setValue(tempFreq, forKey: "algFreqs")
			
			createStepper.value = 1.0
			createFrequencyNumber.text = String(1)
			createSwitch.isOn = false
			createSymbolsTextField.text = ("")
			algNameTextField.text = ("Enter Alg Name Here")
		}
	}
	
	@IBAction func discardAlgorithmPressed(_ sender: Any) {
		createStepper.value = 1.0
		createFrequencyNumber.text = String(1)
		createSwitch.isOn = false
		createSymbolsTextField.text = ("")
		algNameTextField.text = ("Enter Alg Name Here")
	}
	
	@IBAction func editButtonPressed(_ sender: Any) {
		if masterAlgorithms.count > 0 {
			requestPresentationStyle(.expanded)
			editTextField.text = ""
			editLabel.text = "EDITING " + "\"" + masterAlgorithms[selectedAlgorithm] + "\""
			
			
			let allSymbols = manager.defaults.array(forKey: "algSymbols")!
			let symbols = allSymbols[selectedAlgorithm] as! [String]
			
			let allCC = manager.defaults.array(forKey: "algCCs")
			let caseChanging = allCC![selectedAlgorithm] as! Bool
			
			let allFreq = manager.defaults.array(forKey: "algFreqs")
			let frequency = allFreq![selectedAlgorithm] as! Double
			
			editFrequency.text = String(Int(frequency))
			editCaseChanging.isOn = caseChanging
			editChangeFrequency.value = frequency
			
			if symbols.count > 1 {
				for n in 0...symbols.count - 2{
					editTextField.text! += symbols[n] + " "
				}
				editTextField.text! += symbols[symbols.count-1]
			}
			else if symbols.count == 1 {
				editTextField.text = symbols[0]
			}
			
			createButton.isHidden = true
			defaultsButton.isHidden = true
			exitButton.isHidden = true
			editView.isHidden = false
		}
		
	}
	
	@IBAction func editFrequencyChanged(_ sender: Any) {
		if editChangeFrequency.value >= 5.0 {
			editChangeFrequency.value = 5.0
		}
		if editChangeFrequency.value <= 1.0 {
			editChangeFrequency.value = 1.0
		}
		editFrequency.text = String(Int(editChangeFrequency.value))
	}
	
	@IBAction func saveChangesPressed(_ sender: Any) {
		let allSymbols = manager.defaults.array(forKey: "algSymbols")!
		let allCC = manager.defaults.array(forKey: "algCCs")
		let allFreq = manager.defaults.array(forKey: "algFreqs")
		let tempArr = editTextField.text?.components(separatedBy: " ")
		
		var tempFreq = allFreq
		tempFreq![selectedAlgorithm] = editChangeFrequency.value
		manager.defaults.setValue(tempFreq, forKey: "algFreqs")
		//manager.defaults.setValue(editChangeFrequency.value, forKey: algFreqString)
		
		var tempSymbols = allSymbols
		tempSymbols[selectedAlgorithm] = tempArr!
		manager.defaults.setValue(tempSymbols, forKey: "algSymbols")
		
		var tempCC = allCC
		if editCaseChanging.isOn {
			tempCC![selectedAlgorithm] = true
			manager.defaults.setValue(tempCC, forKey: "algCCs")
		}
		else {
			tempCC![selectedAlgorithm] = false
			manager.defaults.setValue(tempCC, forKey: "algCCs")
		}
	}
	
	@IBAction func discardChangesPressed(_ sender: Any) {
		let allSymbols = manager.defaults.array(forKey: "algSymbols")!
		let symbols = allSymbols[selectedAlgorithm] as! [String]
		
		let allCC = manager.defaults.array(forKey: "algCCs")
		let caseChanging = allCC![selectedAlgorithm] as! Bool
		
		let allFreq = manager.defaults.array(forKey: "algFreqs")
		let frequency = allFreq![selectedAlgorithm] as! Double

		if symbols.count > 1 {
			for n in 0...symbols.count - 2{
				editTextField.text! += symbols[n] + " "
			}
			editTextField.text! += symbols[symbols.count-1]
		}
		else if symbols.count == 1 {
			editTextField.text = symbols[0]
		}
		
		editChangeFrequency.value = frequency
		editFrequency.text = String(Int(frequency))
		editCaseChanging.isOn = caseChanging
	}
	
	@IBAction func editingFinished(_ sender: Any) {
		//done BUTTON
		requestPresentationStyle(.compact)
		editView.isHidden = true
		createButton.isHidden = false
		defaultsButton.isHidden = false
		exitButton.isHidden = false
	}
	
	
	@IBAction func removeButtonPressed(_ sender: Any) {
		alert = 0
		if masterAlgorithms.count > 0 {
		alertLabel.text = "REMOVE " + "\"" + masterAlgorithms[selectedAlgorithm] + "\"" + " ?"
			createButton.isHidden = true
			defaultsButton.isHidden = true
			exitButton.isHidden = true
			alertView.isHidden = false
		}
	}
	
	@IBAction func yesPressed(_ sender: Any) {
		if alert == 0 {
			let algorithms = manager.defaults.stringArray(forKey: "algorithms")
			
			let allSymbols = manager.defaults.array(forKey: "algSymbols")!
			let allCC = manager.defaults.array(forKey: "algCCs")
			let allFreq = manager.defaults.array(forKey: "algFreqs")
			
			var tempAlgs = algorithms
			tempAlgs!.remove(at: selectedAlgorithm)
			manager.defaults.setValue(tempAlgs, forKey: "algorithms")
			
			var tempSymbols = allSymbols
			tempSymbols.remove(at: selectedAlgorithm)
			manager.defaults.setValue(tempSymbols, forKey: "algSymbols")
			
			var tempCC = allCC
			tempCC!.remove(at: selectedAlgorithm)
			manager.defaults.setValue(tempCC, forKey: "algCCs")
			
			var tempFreq = allFreq
			tempFreq!.remove(at: selectedAlgorithm)
			manager.defaults.setValue(tempFreq, forKey: "algFreqs")
			
			var temp = algorithms!.count
			temp -= 1
			if selectedAlgorithm == temp {
				selectedAlgorithm -= 1
			}
			
			if selectedAlgorithm < 0 {
				selectedAlgorithm = 0
			}
		}
		else if alert == 1 {
			manager.defaults.setValue(["*^!", "RED", "no words", "halloween"], forKey: "algorithms")
			
			manager.defaults.setValue([
				
			["!", "*^!", "*", "^", "*^", "! +", "+", "! +:)", ". x", "_", "!!", "*+_", "*!+:)", ":)", "*+", "++", "**"],
			["🖤", "🧛🏿‍♂️", "💋", "!", "<3"],
			["🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "!"],
			["👻","🎃","🕸","😨","🧡","🍁"]
				
			], forKey: "algSymbols")
			
			manager.defaults.setValue([3.0, 3.0, 3.0, 3.0], forKey: "algFreqs")
			
			manager.defaults.setValue([true, true, false, false], forKey: "algCCs")
			
		}
		
		masterAlgorithms = manager.defaults.stringArray(forKey: "algorithms")!
		algPickerView.reloadAllComponents()
		alertView.isHidden = true
		createButton.isHidden = false
		defaultsButton.isHidden = false
		exitButton.isHidden = false
	}
	
	@IBAction func noPressed(_ sender: Any) {
		alertView.isHidden = true
		createButton.isHidden = false
		defaultsButton.isHidden = false
		exitButton.isHidden = false
	}
	
	
	@IBAction func defaultsPressed(_ sender: Any) {
		alert = 1
		alertLabel.text = "RESTORE DEFAULTS?"
		createButton.isHidden = true
		defaultsButton.isHidden = true
		exitButton.isHidden = true
		alertView.isHidden = false
	}
	

	
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		// variable to indicate which image was tapped
		let tappedImage = tapGestureRecognizer.view as! UIImageView
		// if the settings button is tapped we call this method
		if tappedImage == exitButton {
			exitButtonPressed()
		}
	}
	
	func numberOfComponents( in pickerView: UIPickerView ) -> Int {
			return 1 //keep this as 1
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return masterAlgorithms[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return masterAlgorithms.count
	}
	
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 30
	}
	
	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		return 100
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedAlgorithm = row
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		
		let view = UIView()
		//let view = UIView( frame: CGRect( x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 60 ) )
		view.frame = CGRect(x: 0,y: 0,width: 100,height: 20)
		
		let label = UILabel()
		//let label = UILabel( frame: CGRect( x: 0, y: 0, width: view.bounds.width, height: view.bounds.height ) )
		
		label.frame = CGRect(x: 0,y: 0,width: 100,height: 20)
		label.text = masterAlgorithms[row]
		label.textColor = .white
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 16, weight: .bold)
		view.addSubview( label )

		return view
	}
	
	
	//edit text field methods:
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		//requestPresentationStyle(.compact)
		return true
	}

	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		requestPresentationStyle(.expanded)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		algPickerView.delegate = self
		algPickerView.dataSource = self
		
		editTextField.delegate = self
		
		createSymbolsTextField.delegate = self
		algNameTextField.delegate = self
		
		// setup settingsButton gesture recognizer
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		exitButton.isUserInteractionEnabled = true
		exitButton.addGestureRecognizer(tapGestureRecognizer)
		
		masterAlgorithms = manager.defaults.stringArray(forKey: "algorithms")!
		
		selectedAlgorithm = 0
		
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
