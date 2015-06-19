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
    
    typealias CircleAttributes = (centerPoint: CGPoint, outerRadius: Double, innerRadius: Double, animationRadius: Double, animationLineWidth: Double)
    
    var outerCircle: CALayer?
    var innerCircle: CALayer?
    var animatedCircle: CALayer?
    var calculatedCircleAttributes: CircleAttributes?
    
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
        self.calculatedCircleAttributes = baseCircleAttributes()
        addBaseCircles(self.calculatedCircleAttributes!, strokeColor: circleOutlineColor, lineWidth: circleOutlineLineWidth)
    }
    
    public func animateProgress(percentComplete: Double) {
        if let realizedAnimationCircle = self.animatedCircle {
            realizedAnimationCircle.removeFromSuperlayer()
        }
        
        if let realizedCircleAttributes = self.calculatedCircleAttributes {
            let progressCircle = CircleLayers.animatedPercentCircle(realizedCircleAttributes.centerPoint, radius: realizedCircleAttributes.animationRadius, percentComplete: percentComplete, strokeColor: self.animationColor, lineWidth: realizedCircleAttributes.animationLineWidth)
            progressCircle.name = self.animatedCircleName
            animatedCircle = progressCircle
            self.layer.addSublayer(progressCircle)
            
            let progressAnimation = CircleLayers.strokeAnimation(self.animationDuration)
            progressCircle.addAnimation(progressAnimation, forKey: animationName)
        }
    }
    
    private func baseCircleAttributes() -> CircleAttributes {
        let ibCenterPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        let ibOuterRadius = Double((min(self.frame.size.width, self.frame.size.height) - 4) / 2)
        let ibInnerRadius = ibOuterRadius - Double(circleWidth)
        let ibAnimationRadius = ibInnerRadius + Double(circleWidth / 2)
        let ibAnimationLineWidth = ibOuterRadius - ibInnerRadius - 2

        return (ibCenterPoint, ibOuterRadius, ibInnerRadius, ibAnimationRadius, ibAnimationLineWidth)
    }
    
    private func addBaseCircles(baseCircle: CircleAttributes, strokeColor: UIColor, lineWidth: CGFloat) {
        
        if let realizedInnerCircle = self.innerCircle {
            realizedInnerCircle.removeFromSuperlayer()
        }
        
        let innerShapeLayer = CircleLayers.baseCircle(baseCircle.centerPoint, radius: baseCircle.outerRadius, strokeColor: strokeColor, lineWidth: Double(lineWidth))
        innerShapeLayer.name = innerCircleName
        self.innerCircle = innerShapeLayer
        
        // DRY this out....
        // Ok it's hard to DRY out well...
        if let realizedOuterCircle = self.outerCircle {
            realizedOuterCircle.removeFromSuperlayer()
        }
        
        let outerShapeLayer = CircleLayers.baseCircle(baseCircle.centerPoint, radius: baseCircle.innerRadius, strokeColor: strokeColor, lineWidth: Double(lineWidth))
        outerShapeLayer.name = outerCircleName
        self.outerCircle = outerShapeLayer
        
        self.layer.addSublayer(innerShapeLayer)
        self.layer.addSublayer(outerShapeLayer)
        
    }
    

}



