//
//  SettingsViewController.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 10/15/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	var masterAlgorithms = ["*^!", "original", "no words", "halloween","*^!", "original", "no words", "halloween","*^!", "original", "no words", "halloween","*^!", "original", "no words", "halloween","*^!", "original", "no words", "halloween"]

	@IBOutlet weak var exitButton: UIImageView!
	@IBOutlet weak var algPickerView: UIPickerView!
	@IBOutlet weak var editButton: UIButton!
	@IBOutlet weak var removeButton: UIButton!
	@IBOutlet weak var defaultsButton: UIButton!
	@IBOutlet weak var createButton: UIButton!
	
	// handles press on the exit button / picture
	@IBAction func exitButtonPressed() {
		dismiss(animated:true, completion: nil)
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
