//
//  ViewController.swift
//  CustomKeyboard
//
//  Created by Manish Kumar on 10/09/15.
//  Copyright (c) 2015 Innofied Solutions Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView2: MKCutomTextView!
    @IBOutlet weak var textView: MKCutomTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.delegate = self
        textView.textColor = UIColor.whiteColor()
        textView.inputView = MKKeyboard(type:.KeyBoradTypeTextPad)
        
        textView2.delegate = self
        textView2.textColor = UIColor.whiteColor()
        textView2.inputView = MKKeyboard(type: .KeyboardTypeNumberPad)
        
        
        var textView3 : MKCutomTextView = MKCutomTextView(frame: CGRectMake(0, 233.0, view.frame.size.width, 50.0), textContainer: nil, type: .KeyBoradTypeTextPad)
        textView3.backgroundColor = UIColor.redColor()
        textView3.delegate = self
        textView3.tag = 3
        textView3.textColor = UIColor.whiteColor()
        view.addSubview(textView3)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        textView.reloadInputViews()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        println("textview.tag : \(textView.tag)")
        return true
    }
}
