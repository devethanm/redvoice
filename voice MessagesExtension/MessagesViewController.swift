//
//  MessagesViewController.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 7/1/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import UIKit
import SwiftUI
import Messages

extension UIColor {
	// hex color converter
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}


class MessagesViewController: MSMessagesAppViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
	var manager = UDM.manager
	let generator = Generator()
	
	@IBOutlet var mainView: UIView!
	@IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
	@IBOutlet weak var writeTextHereLabel: UILabel!
	@IBOutlet weak var writeTextView: UITextView!
	@IBOutlet weak var previewTextView: UITextView!
	@IBOutlet weak var clearButton: UIButton!
	@IBOutlet weak var genButton: UIButton!
	@IBOutlet weak var sendButton: UIButton!
	// these two "buttons" are actually UIImageViews
	// using gesture recognizer to handle taps
	// gesture recognizers are added in viewDidLoad()
	@IBOutlet weak var settingsButton: UIImageView!
	@IBOutlet weak var infoButton: UIImageView!
	
	// rotation angle for the horizontal picker view
    var rotationAngle: CGFloat!
	var selectedAlgorithm = 0

	@IBAction func clearButtonPressed(_ sender: Any) {
		writeTextView.text = ""
		previewTextView.text = ""
	}
	
	@IBAction func genButtonPressed(_ sender: Any) {
		previewTextView.text = ""
		previewTextView.text = generator.generate( algNum:selectedAlgorithm, text:writeTextView.text )
	}
	
	@IBAction func sendButtonPressed(_ sender: Any) {
		if previewTextView.text != "" {
			self.activeConversation?.insertText(previewTextView.text)
		}
		else {
			self.activeConversation?.insertText(generator.generate(algNum:selectedAlgorithm,text:writeTextView.text))
		}
	}
	
	// handles press on the settings button / picture
	@IBAction func settingsButtonPressed() {
		let vc = storyboard?.instantiateViewController(withIdentifier: "settings")
		vc?.modalPresentationStyle = .fullScreen
		present(vc!,animated: true)
	}
	
	// handles press on the info button / picture
	@IBAction func infoButtonPressed() {
		let vc = storyboard?.instantiateViewController(withIdentifier: "info")
		vc?.modalPresentationStyle = .fullScreen
		present(vc!,animated: true)
	}
	
	
	// var declaration because users will be able to
    // add their own algorithms
	var algorithms = [String]()
    
    func numberOfComponents( in pickerView: UIPickerView ) -> Int {
            return 1 //keep this as 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return algorithms[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return algorithms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		
        let view = UIView()
		//let view = UIView( frame: CGRect( x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 60 ) )
        view.frame = CGRect(x: 0,y: 30,width: 100,height: 100)
		
        let label = UILabel()
		//let label = UILabel( frame: CGRect( x: 0, y: 0, width: view.bounds.width, height: view.bounds.height ) )
		
        label.frame = CGRect(x: 0,y: 30,width: 100,height: 100)
		label.text = algorithms[row]
		label.textColor = .white
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 16, weight: .bold)
		view.addSubview( label )
		
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
		return view
    }
	
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedAlgorithm = row
    }
	
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		// variable to indicate which image was tapped
		let tappedImage = tapGestureRecognizer.view as! UIImageView
		// if the settings button is tapped we call this method
		if tappedImage == settingsButton {
			settingsButtonPressed()
		}
		else if tappedImage == infoButton {
			infoButtonPressed()
		}
	}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		/*TODO:
			On load append all algorithms from settings to the algorithms array
		*/
		
		pickerView.delegate = self
		pickerView.dataSource = self
		writeTextView.delegate = self
		
		// setup settingsButton gesture recognizer
		let settingsTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		
		let infoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		
		infoButton.isUserInteractionEnabled = true
		infoButton.addGestureRecognizer(infoTapGestureRecognizer)
		settingsButton.isUserInteractionEnabled = true
		settingsButton.addGestureRecognizer(settingsTapGestureRecognizer)
	
		// add done button to dismiss keyboard
		//self.writeTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
		
		//writeTextView.alwaysBounceVertical = true
        /*
         STYLING
		*/
		pickerView.frame = CGRect(x: 0, y: 30, width: 100, height: 100)
		pickerView.center = self.view.center
		//pickerView.layer.borderColor = UIColor.purple.cgColor
        //pickerView.layer.borderWidth = 1.0
        rotationAngle = -90 * (.pi/180)
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
		
		let gold = UIColor(hex: "#ffe700ff")
		writeTextView.layer.borderColor = gold?.cgColor
		writeTextView.layer.borderWidth = 2.0
		
		previewTextView.layer.borderColor = UIColor.blue.cgColor
		previewTextView.layer.borderWidth = 2.0

		
		/* DEFAULTS */
		if manager.defaults.integer(forKey: "runNum") == 0 {
			manager.defaults.setValue(0, forKey: "runNum")
			
			manager.defaults.setValue(["*^!", "RED", "no words", "halloween"], forKey: "algorithms")
			
			manager.defaults.setValue(["!", "*^!", "*", "^", "*^", "! +", "+", "! +:)", ". x", "_", "!!", "*+_", "*!+:)", ":)", "*+", "++", "**"], forKey: "alg0Symbols")
			
			manager.defaults.setValue(["💔", "🖤", "🧛🏿‍♂️", "💋", "!"], forKey: "alg1Symbols")
			
			manager.defaults.setValue(["💔", "🖤", "💕", "💞", "💖", "🦋", "*", "()", "_", ":)", ":(", "+", "^", "$", "!"], forKey: "alg2Symbols")
			
			manager.defaults.setValue(["👻","🎃","🕸","😨","🧡","🍁"], forKey: "alg3Symbols")
			
			manager.defaults.setValue(2.0, forKey: "alg0Freq")
			manager.defaults.setValue(2.0, forKey: "alg1Freq")
			manager.defaults.setValue(2.0, forKey: "alg2Freq")
			manager.defaults.setValue(2.0, forKey: "alg3Freq")
			
			//CC stands for case changing
			manager.defaults.setValue(true, forKey: "alg0CC")
			manager.defaults.setValue(true, forKey: "alg1CC")
			manager.defaults.setValue(false, forKey: "alg2CC")
			manager.defaults.setValue(false, forKey: "alg3CC")
			
			algorithms = manager.defaults.stringArray(forKey: "algorithms")!
			/* DEFAULTS */
		}
		else {
			algorithms = manager.defaults.stringArray(forKey: "algorithms")!
		}
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        //requestPresentationStyle(.expanded)
		writeTextHereLabel.isHidden = true
		requestPresentationStyle(.expanded)
    }
    
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if text == "\n" {
			writeTextView.resignFirstResponder()
			requestPresentationStyle(.compact)
			return false
		}
		
		return true
	}
	
	@objc func tapDone(sender: Any) {
		
        //requestPresentationStyle(.compact)
		//writeTextView.outlet.resignFirstResponder()
        //if presentationStyle == .compact {
            
		//}
		//else if presentationStyle == .expanded {
		//	self.view.endEditing(true)

		//}
		
	}
	
	
    
    // MARK: - Conversation Handling
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
		
		let tempNum = manager.defaults.integer(forKey: "runNum")

		if tempNum < 2 {
			manager.defaults.setValue(tempNum + 1, forKey: "runNum")
		}
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
	

    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
		
		if (presentationStyle == .expanded) {
            
		}
		
		if (presentationStyle == .compact) {
			// this presentation style is default
			
            
		}
		
    }
	
	
    
    //send message function
    func sendMessage(_ message: MSMessage,
                     completionHandler: ((Error?) -> Void)? = nil) {
        
    }

}
