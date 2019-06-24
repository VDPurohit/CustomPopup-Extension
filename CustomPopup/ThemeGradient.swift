
//
//  Created by Cygnet Infotech on 12/11/18.
//  Copyright © 2018  Vivek. All rights reserved.
//

import UIKit
import Foundation

/**
 Set gradient in views
 - Authors:
 - Created By -
 - Modified By -  2432
 - Date:
 - Created At - 12-11-2018
 - Modified At - date
 - Version: 1.0
 - Remark: nil
 */

class ThemeGradient: NSObject {
    
    /**
     create instance of this class
     - Authors:
     - Created By -
     - Modified By -  2432
     - Date:
     - Created At - 12-11-2018
     - Modified At - date
     - Version: 1.0
     - Remark: nil
     */
    public static let shared: ThemeGradient = {
        return ThemeGradient()
    }()
    
    /**
     Set gradient on button
     - Authors:
     - Created By -
     - Modified By -  2432
     - Date:
     - Created At - 12-11-2018
     - Modified At - date
     - Version: 1.0
     - Remark: nil
     */
    func forButton(withRadius radius: CGFloat, andFrame frame: CGRect, forDegree degree: CGFloat! = -180) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.cornerRadius = radius
        let startColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        let endColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        let (start, end) = gradientPointsForAngle(degree)
        gradient.startPoint = start
        gradient.endPoint = end
        return gradient
    }
    
    /**
     Set gradient on in background
     - Authors:
     - Created By -
     - Modified By -  2432
     - Date:
     - Created At - 12-11-2018
     - Modified At - date
     - Version: 1.0
     - Remark: nil
     */
    func forBackground(withRadius radius: CGFloat, andFrame frame: CGRect, forDegree degree: CGFloat! = -180) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.cornerRadius = radius
        let startColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        let endColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        let (start, end) = gradientPointsForAngle(degree)
        gradient.startPoint = start
        gradient.endPoint = end
        return gradient
    }
    
    /**
     Set gradient on button using image
     - Authors:
     - Created By -
     - Modified By -  2432
     - Date:
     - Created At - 12-11-2018
     - Modified At - date
     - Version: 1.0
     - Remark: nil
     */
    func setGradientDefaultImageForButton(withRadius radius: CGFloat, andFrame frame: CGRect, forDegree degree: CGFloat! = -180) -> UIImage? {
        let gradientLayer = self.forButton(withRadius: radius, andFrame: frame)//self.gradientLayer(with: colors, startPoint: startPoint, endPoint: endPoint)
        let gradientImage = UIImage.imageWithLayer(layer: gradientLayer)
        let originalImage = gradientImage.withRenderingMode(.alwaysOriginal)
        return originalImage
    }
    /**
     create vector pointing in direction of angle
     - Authors:
     - Created By -  
     - Modified By -  2432
     - Date:
     - Created At - 12-11-2018
     - Modified At - date
     - Version: 1.0
     - Remark: nil
     */
    private func gradientPointsForAngle(_ angle: CGFloat) -> (CGPoint, CGPoint) {
        // get vector start and end points
        let end = pointForAngle(angle)
        let start = oppositePoint(end)
        // convert to gradient space
        let p0 = transformToGradientSpace(start)
        let p1 = transformToGradientSpace(end)
        return (p0, p1)
    }
    
    /**
     Set point for angle.
     - Authors:
     - Created By -
     - Modified By -  2432
     - Date:
     - Created At - 12-11-2018
     - Modified At - date
     - Version: 1.0
     - Remark: nil
     */
    private func pointForAngle(_ angle: CGFloat) -> CGPoint {
        // convert degrees to radians
        let radians = angle * .pi / 180.0
        var x = cos(radians)
        var y = sin(radians)
        // (x,y) is in terms unit circle. Extrapolate to unit square to get full vector length
        if (abs(x) > abs(y)) {
            // extrapolate x to unit length
            x = x > 0 ? 1 : -1
            y = x * tan(radians)
        } else {
            // extrapolate y to unit length
            y = y > 0 ? 1 : -1
            x = y / tan(radians)
        }
        return CGPoint(x: x, y: y)
    }
    private func oppositePoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: -point.x, y: -point.y)
    }
    
    /**
     transform gradient
     - Authors:
     - Created By -
     - Modified By -  2432
     - Date:
     - Created At - 12-11-2018
     - Modified At - date
     - Version: 1.0
     - Remark: nil
     */
    private func transformToGradientSpace(_ point: CGPoint) -> CGPoint {
        // input point is in signed unit space: (-1,-1) to (1,1)
        // convert to gradient space: (0,0) to (1,1), with flipped Y axis
        return CGPoint(x: (point.x + 1) * 0.5, y: 1.0 - (point.y + 1) * 0.5)
    }
}
