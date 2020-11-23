//
//  SettingsViewController.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 10/15/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

	var algorithms = ["*^!", "original", "no words", "halloween","*^!", "original", "no words", "halloween","*^!", "original", "no words", "halloween","*^!", "original", "no words", "halloween","*^!", "original", "no words", "halloween"]

	@IBOutlet weak var exitButton: UIImageView!
	@IBOutlet weak var verticalStack: UIStackView!
	
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
	
	func configureStackView() {
		//verticalStack.distribution = .fillEqually
		//verticalStack.spacing = 0
		//verticalStack.alignment = UIStackView.Alignment .fill
	}
	
	func addStackViewElements() {
		
		for i in 0...algorithms.count-1 {
			let button = UIButton(type: UIButton.ButtonType.system)
			button.setTitle(algorithms[i], for: .normal)
			button.isUserInteractionEnabled = true
			//button.textAlignment = NSTextAlignment .center
			verticalStack.addArrangedSubview(button)
		}
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		// setup settingsButton gesture recognizer
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		exitButton.isUserInteractionEnabled = true
		exitButton.addGestureRecognizer(tapGestureRecognizer)
		
		configureStackView()
		addStackViewElements()
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
