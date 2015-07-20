//
//  CircleUtility.swift
//  PercentCompleteControl
//
//  Created by Overby, Sean on 6/16/15.
//  Copyright (c) 2015 Sean Overby. All rights reserved.
//

import Foundation
import UIKit

public class CircleUtility: NSObject {
    
    public typealias CircleAttributes = (centerPoint: CGPoint, outerRadius: Double, innerRadius: Double, animationRadius: Double, animationLineWidth: Double)
    
    public class func degreesToRadians(angle: CFloat) -> CGFloat {
        return CGFloat(angle / 180.0 * CFloat(M_PI))
    }
    
    public class func radiansToDegress(radians: CFloat) -> CGFloat {
        return CGFloat(radians * (180.0 / CFloat(M_PI)))
    }
    
    public class func baseCircle(center: CGPoint, radius: Double, strokeColor: UIColor, lineWidth: Double) -> CAShapeLayer {
        let bCircle = CAShapeLayer()
        bCircle.path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: CGFloat(0), endAngle: degreesToRadians(360), clockwise: true).CGPath
        bCircle.fillColor = UIColor.clearColor().CGColor
        bCircle.strokeColor = strokeColor.CGColor
        bCircle.lineWidth = CGFloat(lineWidth)
        return bCircle
    }
    
    public class func animatedPercentCircle(center: CGPoint, radius: Double, percentComplete: Double, strokeColor: UIColor, lineWidth: Double) -> CAShapeLayer {
        
        let aProgress = CAShapeLayer()
        let endAngleComputed = CFloat(90 + (360 * (percentComplete / 100.0)))
        let endAngle = degreesToRadians(endAngleComputed)
        aProgress.path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: degreesToRadians(90), endAngle: endAngle, clockwise: true).CGPath
        
        aProgress.fillColor = UIColor.clearColor().CGColor
        aProgress.strokeColor = strokeColor.CGColor
        aProgress.lineWidth = CGFloat(lineWidth)
        return aProgress
    }
    
    public class func strokeAnimation(duration: Double) -> CABasicAnimation {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.duration = duration
        strokeAnimation.repeatCount = 1.0
        strokeAnimation.autoreverses = false
        strokeAnimation.removedOnCompletion = false
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        return strokeAnimation
    }
    
    public class func baseCircleFromFrame(frameSize: CGSize, circleWidth: Int) -> CircleUtility.CircleAttributes {
        let ibCenterPoint = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        let ibOuterRadius = Double((min(frameSize.width, frameSize.height) - 4) / 2)
        let ibInnerRadius = ibOuterRadius - Double(circleWidth)
        let ibAnimationRadius = ibInnerRadius + Double(circleWidth / 2)
        let ibAnimationLineWidth = ibOuterRadius - ibInnerRadius - 1
        
        return (ibCenterPoint, ibOuterRadius, ibInnerRadius, ibAnimationRadius, ibAnimationLineWidth)
    }
}