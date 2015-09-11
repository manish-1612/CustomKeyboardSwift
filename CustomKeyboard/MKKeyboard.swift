//
//  MKKeyboard.swift
//  CustomKeyboard
//
//  Created by Manish Kumar on 11/09/15.
//  Copyright (c) 2015 Innofied Solutions Pvt. Ltd. All rights reserved.
//

import UIKit


enum KeyboardType {
    case KeyboardTypeNumberPad
    case KeyBoradTypeTextPad
}


class MKKeyboard: UIView, UITextViewDelegate {

    var viewforKeyBoard: UIView?
    var iskeyBoardUp: Bool?
    //Number pad constant values
    let keyboardBackGroundColorForNumberPad = UIColor.whiteColor()
    let buttonBorderColorForNumberPad = UIColor.clearColor()
    let buttonTitleColorForNumberPad : UIColor = UIColor(red: 0.0/255.0, green: 161.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    let buttonBackgroundColorForNumberPad : UIColor = UIColor.whiteColor()
    let buttonCornerRadiusForNumberPad : CGFloat = 0.0
    let numberPadButtons : [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "⇍", "A"]
    
    
    //Number pad constant values
    let keyboardBackGroundColorForTextPad = UIColor.whiteColor()
    let buttonBorderColorForTextPad = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    let buttonTitleColorForTextPad : UIColor = UIColor(red: 0.0/255.0, green: 161.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    let buttonBackgroundColorForTextPad : UIColor = UIColor.whiteColor()
    let buttonCornerRadiusForTextPad : CGFloat = 5.0
    
    
    //get instance of current text view or field
    var currentInputField : AnyObject?
    
    static var sharedInstance = MKKeyboard(type:.KeyboardTypeNumberPad)
    
    init(type : KeyboardType){
        super.init(frame: CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, 216.0))
        iskeyBoardUp = false
        drawInitialViewForKeyboard(type)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func drawInitialViewForKeyboard(type : KeyboardType){
        //creating view for keyboard
        viewforKeyBoard = UIView(frame: CGRectMake(0.0, 0.0, UIScreen.mainScreen().bounds.size.width, 216.0))
        viewforKeyBoard?.backgroundColor = keyboardBackGroundColorForNumberPad
        self.addSubview(viewforKeyBoard!)
        
        if type == .KeyboardTypeNumberPad{
            drawNumberPadKeyBoard()
        }else{
            drawTextPadKeyBoard()
        }
    }
    
    
    func showKeyBoard(type : KeyboardType){
        
        if iskeyBoardUp == false{
            if type == KeyboardType.KeyboardTypeNumberPad {
                drawNumberPadKeyBoard()
            }else{
                drawTextPadKeyBoard()
            }
        }
    }
    
    
    private func drawNumberPadKeyBoard(){
        
        var buttonCounter : CGFloat = 0.0
        
        for button in numberPadButtons{
            var xOrigin = (buttonCounter % 3) * viewforKeyBoard!.frame.size.width/3
            
            var yOriginFactor = Int(buttonCounter / 3)
            var floatYOriginFactor = CGFloat(yOriginFactor)
            var yOrigin = floatYOriginFactor * viewforKeyBoard!.frame.size.height/5
            var width = viewforKeyBoard!.frame.size.width/3
            var height =  viewforKeyBoard!.frame.size.height/5
            
            var buttonToBeShown = UIButton()
            buttonToBeShown.frame = CGRectMake(xOrigin, yOrigin, width, height)
            buttonToBeShown.backgroundColor = buttonBackgroundColorForNumberPad
            buttonToBeShown.setTitle(button, forState:.Normal)
            buttonToBeShown.titleLabel?.font = UIFont(name: "Arial", size: 25.0)
            buttonToBeShown.setBackgroundImage(getImageWithColor(buttonTitleColorForNumberPad, size: buttonToBeShown.frame.size), forState: .Highlighted)
            buttonToBeShown.setTitleColor(buttonTitleColorForNumberPad, forState: .Normal)
            buttonToBeShown.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            buttonToBeShown.layer.cornerRadius = buttonCornerRadiusForNumberPad
            buttonToBeShown.layer.borderColor = buttonBorderColorForNumberPad.CGColor
            buttonToBeShown.layer.borderWidth = 1.0
            buttonToBeShown.clipsToBounds = true
            buttonToBeShown.addTarget(self, action: "keyPressedInNumberPad:", forControlEvents: .TouchUpInside)
            viewforKeyBoard?.addSubview(buttonToBeShown)
            
            buttonCounter += 1
        }
        
        
        if iskeyBoardUp == false{
            UIView.animateWithDuration(0.4, delay: 0.0, options: .BeginFromCurrentState, animations: { () -> Void in
                self.frame = CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height - 216.0, UIScreen.mainScreen().bounds.size.width, 216.0)
                
                }) { (value : Bool) -> Void in
                    self.iskeyBoardUp = true
            }
        }
    }
    
    
    
    private func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    func keyPressedInNumberPad(sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.titleForState(.Normal)
        
        var dataDict = Dictionary<String, String>()
        dataDict["key"] = title
        
        if let newcurrentInputField:AnyObject = MKKeyboard.sharedInstance.currentInputField {
            if newcurrentInputField.isKindOfClass(MKCutomTextView){
                
                var textView : MKCutomTextView = newcurrentInputField as! MKCutomTextView
                if title == "⇍" && count(textView.text) > 0 {
                    textView.text = textView.text.substringToIndex(textView.text.endIndex.predecessor())
                    
                } else if title != "⇍"{
                    
                    if title == "A"{
                        //keyboard switching code
                        for subview in viewforKeyBoard!.subviews{
                            if subview.isKindOfClass(UIButton){
                                subview.removeFromSuperview()
                            }
                        }

                        drawTextPadKeyBoard()
                    }else{
                        textView.text = "\(textView.text)\(title!)"
                    }
                }
                
            }else{
                //do nothing
            }
        }else{
            //do nothing
        }
    }
    
    
    
    
    func keyPressedInTextPad(sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.titleForState(.Normal)
        
        var dataDict = Dictionary<String, String>()
        dataDict["key"] = title
        
        if let newcurrentInputField:AnyObject = MKKeyboard.sharedInstance.currentInputField {
            if newcurrentInputField.isKindOfClass(MKCutomTextView){
                
                var textView : MKCutomTextView = newcurrentInputField as! MKCutomTextView
                if title == "⇍" && count(textView.text) > 0 {
                    textView.text = textView.text.substringToIndex(textView.text.endIndex.predecessor())
                    
                } else if title != "⇍"{
                   
                    if title == "⇧"{
                        //keyboard switching code
                        for subview in viewforKeyBoard!.subviews{
                            if subview.isKindOfClass(UIButton){
                                var button = subview as? UIButton
                                var title = subview.titleForState(.Normal)
                            }
                        }
                    }else if title == "123"{
                        //keyboard switching code
                        for subview in viewforKeyBoard!.subviews{
                            if subview.isKindOfClass(UIButton){
                                subview.removeFromSuperview()
                            }
                        }
                        
                        drawNumberPadKeyBoard()
                        
                    }else if title == "SPACE" && count(textView.text) > 0{
                        //space generation code
                        let space : String = " "
                        textView.text = "\(textView.text) "
                        
                    }else if title == "↵" && count(textView.text) > 0{
                        //enter generation code
                        let enter : String = "\n"
                        textView.text = "\(textView.text)\n"
                        
                    }else if title == "Done"{
                        //done button to hide keyboard
                        if (MKKeyboard.sharedInstance.currentInputField?.isKindOfClass(MKCutomTextView) != nil){
                            var inputField = MKKeyboard.sharedInstance.currentInputField as? MKCutomTextView
                            inputField?.resignFirstResponder()
                        }
                    }else{
                        textView.text = "\(textView.text)\(title!)"
                    }
                }
                
            }else{
                //do nothing
            }
        }else{
            //do nothing
        }
    }

    
    private func drawTextPadKeyBoard(){
        
        let firstTextRowElemnts : [String] = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
        let secondTextRowElemnts : [String] = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
        let thirdTextRowElemnts : [String] = ["⇧", "Z", "X", "C", "V", "B", "N", "M", "⇍"]
        let fourthRowElement : [String] = ["123", "SPACE", "↵", "Done"]
        
        var buttonCounter : CGFloat = 0.0
        
        for button in firstTextRowElemnts{
            
            var count = CGFloat (firstTextRowElemnts.count)
            var xOrigin = (buttonCounter % count) * viewforKeyBoard!.frame.size.width/count + 2.50
            var yOrigin = 0 * viewforKeyBoard!.frame.size.height/4 + 2.50
            var width = viewforKeyBoard!.frame.size.width/count - 5.0
            var height =  viewforKeyBoard!.frame.size.height/4 - 5.0
            
            var buttonToBeShown = UIButton()
            buttonToBeShown.frame = CGRectMake(xOrigin, yOrigin, width, height)
            buttonToBeShown.backgroundColor = buttonBackgroundColorForTextPad
            buttonToBeShown.setTitle(button, forState:.Normal)
            buttonToBeShown.titleLabel?.font = UIFont(name: "Arial", size: 17.0)
            buttonToBeShown.setBackgroundImage(getImageWithColor(buttonTitleColorForTextPad, size: buttonToBeShown.frame.size), forState: .Highlighted)
            buttonToBeShown.setTitleColor(buttonTitleColorForTextPad, forState: .Normal)
            buttonToBeShown.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            buttonToBeShown.layer.cornerRadius = buttonCornerRadiusForTextPad
            buttonToBeShown.layer.borderColor = buttonBorderColorForTextPad.CGColor
            buttonToBeShown.layer.borderWidth = 1.0
            buttonToBeShown.clipsToBounds = true
            buttonToBeShown.addTarget(self, action: "keyPressedInTextPad:", forControlEvents: .TouchUpInside)
            viewforKeyBoard?.addSubview(buttonToBeShown)
            
            buttonCounter += 1
        }
        
        buttonCounter = 0.0
        
        for button in secondTextRowElemnts{
            
            var count = CGFloat (secondTextRowElemnts.count)
            var xOrigin = (buttonCounter % count) * viewforKeyBoard!.frame.size.width/count + 2.50
            var yOrigin = viewforKeyBoard!.frame.size.height/4 + 2.50
            var width = viewforKeyBoard!.frame.size.width/count - 5.0
            var height =  viewforKeyBoard!.frame.size.height/4 - 5.0
            
            var buttonToBeShown = UIButton()
            buttonToBeShown.frame = CGRectMake(xOrigin, yOrigin, width, height)
            buttonToBeShown.backgroundColor = buttonBackgroundColorForTextPad
            buttonToBeShown.setTitle(button, forState:.Normal)
            buttonToBeShown.titleLabel?.font = UIFont(name: "Arial", size: 17.0)
            buttonToBeShown.setBackgroundImage(getImageWithColor(buttonTitleColorForTextPad, size: buttonToBeShown.frame.size), forState: .Highlighted)
            buttonToBeShown.setTitleColor(buttonTitleColorForTextPad, forState: .Normal)
            buttonToBeShown.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            buttonToBeShown.layer.cornerRadius = buttonCornerRadiusForTextPad
            buttonToBeShown.layer.borderColor = buttonBorderColorForTextPad.CGColor
            buttonToBeShown.layer.borderWidth = 1.0
            buttonToBeShown.clipsToBounds = true
            buttonToBeShown.addTarget(self, action: "keyPressedInTextPad:", forControlEvents: .TouchUpInside)
            viewforKeyBoard?.addSubview(buttonToBeShown)
            
            buttonCounter += 1
        }
        
        
        buttonCounter = 0.0
        
        for button in thirdTextRowElemnts{
            
            var count = CGFloat (thirdTextRowElemnts.count)
            var xOrigin = (buttonCounter % count) * viewforKeyBoard!.frame.size.width/count + 2.50
            var yOrigin = 2 * viewforKeyBoard!.frame.size.height/4 + 2.50
            var width = viewforKeyBoard!.frame.size.width/count - 5.0
            var height =  viewforKeyBoard!.frame.size.height/4 - 5.0
            
            var buttonToBeShown = UIButton()
            buttonToBeShown.frame = CGRectMake(xOrigin, yOrigin, width, height)
            buttonToBeShown.backgroundColor = buttonBackgroundColorForTextPad
            buttonToBeShown.setTitle(button, forState:.Normal)
            buttonToBeShown.titleLabel?.font = UIFont(name: "Arial", size: 17.0)
            buttonToBeShown.setBackgroundImage(getImageWithColor(buttonTitleColorForTextPad, size: buttonToBeShown.frame.size), forState: .Highlighted)
            buttonToBeShown.setTitleColor(buttonTitleColorForTextPad, forState: .Normal)
            buttonToBeShown.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            buttonToBeShown.layer.cornerRadius = buttonCornerRadiusForTextPad
            buttonToBeShown.layer.borderColor = buttonBorderColorForTextPad.CGColor
            buttonToBeShown.layer.borderWidth = 1.0
            buttonToBeShown.clipsToBounds = true
            buttonToBeShown.addTarget(self, action: "keyPressedInTextPad:", forControlEvents: .TouchUpInside)
            viewforKeyBoard?.addSubview(buttonToBeShown)
            
            buttonCounter += 1
        }
        
        
        buttonCounter = 0.0
        
        for button in fourthRowElement{
            
            var count = CGFloat (fourthRowElement.count)
            var xOrigin = (buttonCounter % count) * viewforKeyBoard!.frame.size.width/count + 2.50
            var yOrigin = 3 * viewforKeyBoard!.frame.size.height/4 + 2.50
            var width = viewforKeyBoard!.frame.size.width/count - 5.0
            var height =  viewforKeyBoard!.frame.size.height/4 - 5.0
            
            var buttonToBeShown = UIButton()
            buttonToBeShown.frame = CGRectMake(xOrigin, yOrigin, width, height)
            buttonToBeShown.backgroundColor = buttonBackgroundColorForTextPad
            buttonToBeShown.setTitle(button, forState:.Normal)
            buttonToBeShown.titleLabel?.font = UIFont(name: "Arial", size: 17.0)
            buttonToBeShown.setBackgroundImage(getImageWithColor(buttonTitleColorForTextPad, size: buttonToBeShown.frame.size), forState: .Highlighted)
            buttonToBeShown.setTitleColor(buttonTitleColorForTextPad, forState: .Normal)
            buttonToBeShown.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            buttonToBeShown.layer.cornerRadius = buttonCornerRadiusForTextPad
            buttonToBeShown.layer.borderColor = buttonBorderColorForTextPad.CGColor
            buttonToBeShown.layer.borderWidth = 1.0
            buttonToBeShown.clipsToBounds = true
            buttonToBeShown.addTarget(self, action: "keyPressedInTextPad:", forControlEvents: .TouchUpInside)
            viewforKeyBoard?.addSubview(buttonToBeShown)
            
            buttonCounter += 1
        }
        
        if iskeyBoardUp == false {
            UIView.animateWithDuration(0.4, delay: 0.0, options: .BeginFromCurrentState, animations: { () -> Void in
                self.frame = CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height - 216.0, UIScreen.mainScreen().bounds.size.width, 216.0)
                
                }) { (value : Bool) -> Void in
                    self.iskeyBoardUp = true
            }
        }
    }
    
//    
//    func hideKeyBoard(){
//        if iskeyBoardUp == true {
//            UIView.animateWithDuration(0.4, delay: 0.0, options: .BeginFromCurrentState, animations: { () -> Void in
//                self.frame = CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, 216.0)
//                
//                }) { (value : Bool) -> Void in
//                    self.iskeyBoardUp = false
//                    self.removeFromSuperview()
//            }
//        }
//    }
}
