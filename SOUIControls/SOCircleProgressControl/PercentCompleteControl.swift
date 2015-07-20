//
//  PercentCompleteControl.swift
//  PercentCompleteControl
//
//  Created by Overby, Sean on 6/16/15.
//  Copyright (c) 2015 Sean Overby. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable
public class PercentCompleteControl: UIView {
    
    var outerCircle: CALayer?
    var innerCircle: CALayer?
    var animatedCircle: CALayer?
    var lastPercentComplete: Double?
    var calculatedCircleAttributes: CircleUtility.CircleAttributes?
    
    @IBInspectable var circleOutlineColor: UIColor = UIColor.whiteColor()
    @IBInspectable var animationColor: UIColor = UIColor.whiteColor()
    @IBInspectable var circleOutlineLineWidth: CGFloat = 0.0
    @IBInspectable var animationDuration: Double = 0.0
    @IBInspectable var circleWidth: Int = 6
    
    let outerCircleName = "outerCircleLayer"
    let innerCircleName = "innerCircleLayer"
    let animatedCircleName = "animatedCircleName"
    let animationName = "progressAnimation"

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.calculatedCircleAttributes = CircleUtility.baseCircleFromFrame(self.frame.size, circleWidth: self.circleWidth)
        addBaseCircles(self.calculatedCircleAttributes!, strokeColor: circleOutlineColor, lineWidth: circleOutlineLineWidth)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationDidChange", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    public func animateProgress(percentComplete: Double, ignoreDuration: Bool) {
        if let realizedAnimationCircle = self.animatedCircle {
            realizedAnimationCircle.removeFromSuperlayer()
        }
        
        if let realizedCircleAttributes = self.calculatedCircleAttributes {
            let progressCircle = CircleUtility.animatedPercentCircle(realizedCircleAttributes.centerPoint, radius: realizedCircleAttributes.animationRadius, percentComplete: percentComplete, strokeColor: self.animationColor, lineWidth: realizedCircleAttributes.animationLineWidth)
            progressCircle.name = self.animatedCircleName
            animatedCircle = progressCircle
            self.layer.addSublayer(progressCircle)
            
            if(!ignoreDuration) {
                let progressAnimation = CircleUtility.strokeAnimation(self.animationDuration)
                progressCircle.addAnimation(progressAnimation, forKey: animationName)
            }
            
            self.lastPercentComplete = percentComplete
        }
    }
    
    private func addBaseCircles(baseCircle: CircleUtility.CircleAttributes, strokeColor: UIColor, lineWidth: CGFloat) {
        
        if let realizedInnerCircle = self.innerCircle {
            realizedInnerCircle.removeFromSuperlayer()
        }
        
        let innerShapeLayer = CircleUtility.baseCircle(baseCircle.centerPoint, radius: baseCircle.outerRadius, strokeColor: strokeColor, lineWidth: Double(lineWidth))
        innerShapeLayer.name = innerCircleName
        self.innerCircle = innerShapeLayer
        
        // DRY this out....
        // Ok it's hard to DRY out well...
        if let realizedOuterCircle = self.outerCircle {
            realizedOuterCircle.removeFromSuperlayer()
        }
        
        let outerShapeLayer = CircleUtility.baseCircle(baseCircle.centerPoint, radius: baseCircle.innerRadius, strokeColor: strokeColor, lineWidth: Double(lineWidth))
        outerShapeLayer.name = outerCircleName
        self.outerCircle = outerShapeLayer
        
        self.layer.addSublayer(innerShapeLayer)
        self.layer.addSublayer(outerShapeLayer)
        
    }
    
    public func orientationDidChange() {
        if let actualLastPercentComplete = self.lastPercentComplete {
            animateProgress(actualLastPercentComplete, ignoreDuration: true)
        }
    }
}



