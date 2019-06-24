
//
//  Created by Cygnet Infotech on 06/11/18.
//  Copyright © 2018  Vivek. All rights reserved.
//

import UIKit
import Kingfisher

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint: CGPoint {
        return points.startPoint
    }
    
    var endPoint: CGPoint {
        return points.endPoint
    }
    
    var points: GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint.init(x: 0.0, y: 1.0), CGPoint.init(x: 1.0, y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 1, y: 1))
        case .horizontal:
            return (CGPoint.init(x: 0.0, y: 0.5), CGPoint.init(x: 1.0, y: 0.5))
        case .vertical:
            return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 0.0, y: 1.0))
        }
    }
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    public func isCapitalValidPassword(_ emailString: String) -> Bool {
        
        let passwordRegex = "^.*(?=.*[A-Z]).*$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
        // email valid
    }
    
    public func isNumberValidPassword(_ emailString: String) -> Bool {
        
        let passwordRegex = "^.*(?=.*[0-9]).*$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
        // email valid
    }
    
    // Check for mobile Validation
    func isValidMobileNumber() -> Bool {
        if self.count < 14 {
            return false
        }
        return true
    }
    
    // Check for Password Validation
    func isCharacterValidPassword() -> Bool {
        if self.count < 8 {
            return false
        }
        return true
    }
    
    // Check for Password Validation
    func isValidPin() -> Bool {
        if self.count == 5 {
            return true
        }
        return false
    }
    
    func isValidName() -> Bool {
        
        let nameRegEx = ".*[^A-Za-z ].*"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
        
    }
    // Check for Valid Email Address
    func isValidEmail() -> Bool {
        let emailRegEx = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
        
    }
    
    
    // Check for String is Empty
    
    func isEmpty() -> Bool {
        return self.trimming().isEmpty
        
    }
    
    // Return the string after trimming
    func trimming() -> String {
        let strText = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return strText
        
    }
    
    var encodeEmoji: String? {
        
        let encodedStr = NSString(cString: self.cString(using: String.Encoding.nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue)
        return encodedStr as String?
        
    }
    
    
    
    var decodeEmoji: String {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if data != nil {
            let valueUniCode = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue) as String?
            if valueUniCode != nil {
                return valueUniCode!
            } else {
                return self
            }
        } else {
            return self
        }
    }
}

extension UIView{
    
    func addRightEmptyImageOnTextField(textField : UITextField) {
        
        let imgView = UIImageView(frame: CGRect(x: textField.frame.width - 40 , y: 2, width: 50, height: 50))
        
        textField.rightViewMode = .always
        textField.rightView = imgView
    }
    
    func addRightIconOnTextField(textField : UITextField , icon : UIImage) {
        
        let imgView = UIImageView(frame: CGRect(x: textField.frame.width - 40 , y: 2, width: 18, height: 18))
        imgView.image = icon
        textField.rightViewMode = .always
        textField.rightView = imgView
    }
}

extension UIView {
    
    func applyGradient(colours: [UIColor], gradientOrientation orientation: GradientOrientation) -> Void {
        DispatchQueue.main.async {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
            gradient.startPoint = orientation.startPoint
            gradient.endPoint = orientation.endPoint
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    /// Remove UIBlurEffect from UIView
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }set {
            
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }set {
            
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    
    var borderColor: UIColor? {
        
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        
        get {
            return layer.shadowRadius
            
        }set {
            
            layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

extension UITableView {
    
    // Set Text when no any Data found for TableView
    func setTextForBlankTableview(message : String, color: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),y : CGFloat = 0.0) -> Void {
        
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 0, y: y, width: self.frame.size.width, height: 50))
        messageLabel.backgroundColor = .clear
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.contentMode = .bottom
        messageLabel.font = UIFont.init(name: "Helvetica", size: 15.0)
        let vw = UIView.init()
        vw.backgroundColor = .clear
        self.backgroundView = vw
        self.backgroundView?.addSubview(messageLabel)
    }
}

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 0)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
extension UICollectionView {
    
    // Set Text when no any Data found for TableView
    func setTextForBlankCollectionview(message : String, color: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) -> Void {
        
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 17, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.init(name: "Helvetica", size: 15.0)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
}

extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
}

extension UIImageView {
    
    //Add bluff effect on image
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    //Add bluff effect on image
    func addBlurLightEffect()
    {
        DispatchQueue.main.async {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            blurEffectView.alpha = 0.8
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
            self.addSubview(blurEffectView)
        }
    }
    
    // Download image and set into given imageview
    func setImage(imgURL: String,placeholderImage: UIImage) {
        
        if !imgURL.isEmpty {
    
            let url = URL(string: imgURL)
            self.image = nil
            self.kf.indicatorType = .activity
    
            self.kf.setImage(with: url, placeholder: placeholderImage,
                             options: [.transition(.fade(1))],
                             progressBlock: nil,
                             completionHandler: nil)
            
        } else {
            self.image = placeholderImage
        }
    }
}

extension UIImage {
    
    class func imageWithLayer(layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    
    func customImageOrientation()->UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch self.imageOrientation {
        case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            break
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
            break
        case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
            break
        case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
            break
        }
        
        switch self.imageOrientation {
        case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
            transform.translatedBy(x: self.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
            transform.translatedBy(x: self.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
            break
        }
        
        let ctx:CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: (self.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (self.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch self.imageOrientation {
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
            break
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
            break
        }
        
        let cgimg:CGImage = ctx.makeImage()!
        let img:UIImage = UIImage(cgImage: cgimg)
        
        return img
    }
}

extension UIViewController {
    
    //MARK:- Pop VC from stack
    @IBAction func btnBackClicked(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fontName() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}

extension Date {
    
    func  dateToString(date : Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
