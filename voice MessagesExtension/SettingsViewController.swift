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
		
		let selectedAlgorithmString = String(selectedAlgorithm)
		let algString = "alg" + selectedAlgorithmString + "Symbols"
		let algCCString = "alg" + selectedAlgorithmString + "CC"
		let algFreqString = "alg" + selectedAlgorithmString + "Freq"
		let alg = manager.defaults.stringArray(forKey: algString)!
		
		editFrequency.text = String(manager.defaults.double(forKey: algFreqString))
		editCaseChanging.isOn = manager.defaults.bool(forKey: algCCString)
		editChangeFrequency.value = manager.defaults.double(forKey: algFreqString)
		
		// TODO: Make it so that it actually used the correct algorithm symbols, it errors out if you select alg 6 or any higher number
		for n in 0...alg.count - 2{
			editTextField.text! += alg[n] + " "
		}
		editTextField.text! += alg[alg.count-1]
		
		editView.isHidden = false
	}
	
	@IBAction func caseChangingSliderChanged(_ sender: Any) {
		let selectedAlgorithmString = String(selectedAlgorithm)
		let algString = "alg" + selectedAlgorithmString + "CC"
		
		if editCaseChanging.isOn {
			manager.defaults.setValue(true, forKey: algString)
		}
		else {
			manager.defaults.setValue(false, forKey: algString)
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
		let selectedAlgorithmString = String(selectedAlgorithm)
		let algString = "alg" + selectedAlgorithmString + "Symbols"
		let algFreqString = "alg" + selectedAlgorithmString + "Freq"
		let tempArr = editTextField.text?.components(separatedBy: " ")
		
		manager.defaults.setValue(editChangeFrequency.value, forKey: algFreqString)
		manager.defaults.setValue(tempArr, forKey: algString)
	}
	
	@IBAction func discardChangesPressed(_ sender: Any) {
		editTextField.text = ""
		let selectedAlgorithmString = String(selectedAlgorithm)
		let algString = "alg" + selectedAlgorithmString + "Symbols"
		let algFreqString = "alg" + selectedAlgorithmString + "Freq"
		let alg = manager.defaults.stringArray(forKey: algString)!
		
		// TODO: Make it so that it actually used the correct algorithm symbols, it errors out if you select alg 6 or any higher number
		for n in 0...alg.count - 2{
			editTextField.text! += alg[n] + " "
		}
		editTextField.text! += alg[alg.count-1]
		
		editChangeFrequency.value = manager.defaults.double(forKey: algFreqString)
		editFrequency.text = String(Int(manager.defaults.double(forKey: algFreqString)))
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
