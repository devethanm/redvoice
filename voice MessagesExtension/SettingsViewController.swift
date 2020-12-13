//
//  SettingsViewController.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 10/15/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import UIKit
import Messages

class SettingsViewController: MSMessagesAppViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	let manager = UDM.manager
	
	let defaultAlgorithms = ["*^!", "RED", "no words", "halloween"]
	
	var masterAlgorithms = [String]()
	var selectedAlgorithm = 0
	

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
	
	
	
	// handles press on the exit button / picture
	@IBAction func exitButtonPressed() {
		dismiss(animated:true, completion: nil)
	}
	
	@IBAction func editButtonPressed(_ sender: Any) {
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
		
		// TODO: Make it so that it actually used the correct algorithm symbols, it errors out if you select alg 6 or any higher number
		for n in 0...symbols.count - 2{
			editTextField.text! += symbols[n] + " "
		}
		editTextField.text! += symbols[symbols.count-1]
		
		editView.isHidden = false
	}
	
	@IBAction func caseChangingSliderChanged(_ sender: Any) {
		
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
		//manager.defaults.setValue(tempArr, forKey: algString)
		
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
		
		// TODO: Make it so that it actually used the correct algorithm symbols, it errors out if you select alg 6 or any higher number
		for n in 0...symbols.count - 2{
			editTextField.text! += symbols[n] + " "
		}
		editTextField.text! += symbols[symbols.count-1]
		
		editChangeFrequency.value = frequency
		editFrequency.text = String(Int(frequency))
		editCaseChanging.isOn = caseChanging
	}
	
	@IBAction func editingFinished(_ sender: Any) {
		//done BUTTON
		requestPresentationStyle(.compact)
		editView.isHidden = true
	}
	
	
	@IBAction func removeButtonPressed(_ sender: Any) {
		
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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		algPickerView.delegate = self
		algPickerView.dataSource = self
		
		// setup settingsButton gesture recognizer
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		exitButton.isUserInteractionEnabled = true
		exitButton.addGestureRecognizer(tapGestureRecognizer)
		
		
		masterAlgorithms = manager.defaults.stringArray(forKey: "algorithms")!
		
			
		
		editView.isHidden = true
		
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
