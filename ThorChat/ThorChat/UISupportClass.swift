//
//  UISupportClass.swift
//  ThorChat
//
//  Created by admin on 4/15/21.
//

import Foundation
import UIKit

extension UITextField {
    func showDoneButtonOnKeyboard() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
        
        var toolBarItems = [UIBarButtonItem]()
        toolBarItems.append(flexSpace)
        toolBarItems.append(doneButton)
        
        let doneToolbar = UIToolbar()
        doneToolbar.items = toolBarItems
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
    }
}

extension UIView {

    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }


}





 extension UIView {
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
}

class REView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isCircle{
            layer.cornerRadius = (self.frame.height) / 2
         //   layer.masksToBounds = true
        }
        
        if isBottomShadow{
             layer.shadowColor = setShadowColor.cgColor
            layer.borderColor = UIColor(named: "D3CDCD")?.cgColor
            //layer.cornerRadius = cornerRadius
            layer.shadowOffset = CGSize(width: 1, height: 2)
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 2.0
        }
        if isimgShadow{
            layer.shadowColor = setShadowColor.cgColor
            layer.borderColor = UIColor(named: "D3CDCD")?.cgColor
            //layer.cornerRadius = cornerRadius
            layer.shadowOffset = CGSize(width: 0, height: 5)
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 5.0
            layer.shouldRasterize = true
            layer.masksToBounds = false
        }
        
        
    }
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
           layoutSubviews()
        }
    }
    
    @IBInspectable var setShadowColor: UIColor =  UIColor.red {
        didSet {
            layer.shadowColor = setShadowColor.cgColor
        }
    }
    
    @IBInspectable var isBottomShadow: Bool = false {
        didSet {
            layer.borderColor = UIColor(named: "D3CDCD")?.cgColor
           // layer.cornerRadius = cornerRadius
            layer.shadowOffset = CGSize(width: 3, height: 3)
            layer.shadowOpacity = 5.0
            layer.shadowRadius = 1.0
        }
    }
        @IBInspectable var isimgShadow: Bool = false {
        didSet {
            layer.shadowColor = setShadowColor.cgColor
            layer.borderColor = UIColor(named: "D3CDCD")?.cgColor
            //layer.cornerRadius = cornerRadius
            layer.shadowOffset = CGSize(width: 0, height: 5)
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 5.0
            layer.shouldRasterize = true
            layer.masksToBounds = false
    }
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


class REImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isCircle{
            layer.cornerRadius = ( self.frame.height) / 2
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var tintImage: UIImage? {
        didSet {
            if tintImage != nil {
                let imgTintImage = tintImage?.withRenderingMode(.alwaysTemplate)
                self.image = imgTintImage
            }
        }
    }
}
