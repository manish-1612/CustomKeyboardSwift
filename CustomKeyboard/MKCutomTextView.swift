//
//  MKCutomTextView.swift
//  CustomKeyboard
//
//  Created by Manish Kumar on 11/09/15.
//  Copyright (c) 2015 Innofied Solutions Pvt. Ltd. All rights reserved.
//

import UIKit

class MKCutomTextView: UITextView , UITextViewDelegate{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    init(frame : CGRect , textContainer : NSTextContainer!, type :KeyboardType){
        super.init(frame: frame, textContainer: textContainer)
        self.inputView = Keyboard(type: type)
        implementTextView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        implementTextView()
    }
    
    private func implementTextView(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "insertTextInTextView:", name: UITextViewTextDidBeginEditingNotification, object: self)
    }
    
    
    func insertTextInTextView(notification : NSNotification){
        Keyboard.sharedInstance.currentInputField = self
    }
}
