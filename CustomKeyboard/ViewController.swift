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
        textView.inputView = Keyboard(type:.KeyBoradTypeTextPad)
        
        textView2.delegate = self
        textView2.textColor = UIColor.whiteColor()
        textView2.inputView = Keyboard(type: .KeyboardTypeNumberPad)
        
//        var textView5 : MKCutomTextView = MKCutomTextView(frame: CGRectMake(0, 0.0, view.frame.size.width, 110.0), textContainer: nil, type: .KeyboardTypeNumberPad)
//        textView5.backgroundColor = UIColor.purpleColor()
//        textView5.delegate = self
//        textView5.tag = 1
//        textView5.textColor = UIColor.whiteColor()
//        view.addSubview(textView5)
//
//        
//        var textView6 : MKCutomTextView = MKCutomTextView(frame: CGRectMake(0, 110.0, view.frame.size.width, 123.0), textContainer: nil, type: .KeyBoradTypeTextPad)
//        textView6.backgroundColor = UIColor.orangeColor()
//        textView6.delegate = self
//        textView6.tag = 1
//        textView6.textColor = UIColor.whiteColor()
//        view.addSubview(textView6)

        
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
