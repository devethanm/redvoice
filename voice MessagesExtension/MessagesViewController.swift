//
//  MessagesViewController.swift
//  voice MessagesExtension
//
//  Created by Ethan Maestas on 7/1/20.
//  Copyright © 2020 Ethan Maestas. All rights reserved.
//

import UIKit
import Messages

var generator = Generate()

class MessagesViewController: MSMessagesAppViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
	@IBOutlet weak var writeTextView: UITextView!
	@IBOutlet weak var previewTextView: UITextView!
	@IBOutlet weak var clearButton: UIButton!
	@IBOutlet weak var genButton: UIButton!
	@IBOutlet weak var sendButton: UIButton!
	
    var rotationAngle: CGFloat!
	var selectedAlgorithm = "original"

	@IBAction func clearButtonPressed(_ sender: Any) {
		writeTextView.text = ""
		previewTextView.text = ""
	}
	
	@IBAction func genButtonPressed(_ sender: Any) {
		previewTextView.text = ""
		previewTextView.text = generator.generate( algorithm:selectedAlgorithm, text:writeTextView.text )
	}
	
	@IBAction func sendButtonPressed(_ sender: Any) {
		if previewTextView.text != "" {
			self.activeConversation?.insertText(previewTextView.text, completionHandler: { (error: NSError?) in } as? (Error?) -> Void )
		}
		else {
			self.activeConversation?.insertText(generator.generate(algorithm:selectedAlgorithm,text:writeTextView.text), completionHandler: { (error: NSError?) in } as? (Error?) -> Void )
		}
	}
	
	
	// var declaration because users will be able to
    // add their own algorithms
    var algorithms = ["original", "no words", "halloween"]
    
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
        view.frame = CGRect(x: 0,y: 0,width: 100,height: 75)
		
        let label = UILabel()
		//let label = UILabel( frame: CGRect( x: 0, y: 0, width: view.bounds.width, height: view.bounds.height ) )
		
        label.frame = CGRect(x: 0,y: 0,width: 100,height: 100)
		label.text = algorithms[row]
		label.textColor = .white
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 20, weight: .bold)
		view.addSubview( label )
		
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
		return view
    }
	
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedAlgorithm = algorithms[row]
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		pickerView.delegate = self
		pickerView.dataSource = self
		writeTextView.delegate = self

		
		self.writeTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
		
		//writeTextView.alwaysBounceVertical = true
        
        /*
         STYLING
         */
		pickerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		pickerView.center = self.view.center
        pickerView.layer.borderColor = UIColor.purple.cgColor
        pickerView.layer.borderWidth = 1.0
        rotationAngle = -90 * (.pi/180)
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
		
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        requestPresentationStyle(.expanded)
    }
    
	@objc func tapDone(sender: Any) {
		
        requestPresentationStyle(.compact)
        //writeTextView.resignFirstResponder()

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
