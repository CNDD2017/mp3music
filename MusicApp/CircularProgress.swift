//
//  CircularProgress.swift
//  MusicApp
//
//  Created by Tran Tuat on 3/10/17.
//  Copyright © 2017 TranTuat. All rights reserved.
//

import Foundation
import UIKit

class CircularProgress: UIView {
    
    // MARK: Property
    
    let MinStrokeLength: CGFloat = 0.01
    let MaxStrokeLength: CGFloat = 1.0
    let circleOutlineLayer     = CAShapeLayer()
    let insideCircleShapeLayer = CAShapeLayer()
    let checkmarkShapeLayer    = CAShapeLayer()
    let AfterpartDuration: Double = 0.3
    
    var CheckmarkPath: UIBezierPath {
        get {
            let CheckmarkSize  = CGSize(width: 20, height: 16)
            let checkmarkPath = UIBezierPath()
            let startPoint    = CGPoint(x: center.x - CheckmarkSize.width * 0.48,
                                        y: center.y + CheckmarkSize.height * 0.05)
            checkmarkPath.move(to: startPoint)
            let firstLineEndPoint = CGPoint(x: startPoint.x + CheckmarkSize.width * 0.36,
                                            y: startPoint.y + CheckmarkSize.height * 0.36)
            checkmarkPath.addLine(to: firstLineEndPoint)
            let secondLineEndPoint = CGPoint(x: firstLineEndPoint.x + CheckmarkSize.width * 0.64,
                                             y: firstLineEndPoint.y - CheckmarkSize.height)
            checkmarkPath.addLine(to: secondLineEndPoint)
            return checkmarkPath
        }
    }
    
    var duration: Double = 3.0
    
    //MARK: Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        initShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        initShapeLayer()
    }
    
    //MARK: Private method
    
    private func initShapeLayer() {
        // Outline
        let outLineWidth: CGFloat = 5
        circleOutlineLayer.actions = ["strokeEnd" : NSNull(),
                                      "strokeStart" : NSNull(),
                                      "transform" : NSNull(),
                                      "strokeColor" : NSNull()]
        circleOutlineLayer.backgroundColor = UIColor.clear.cgColor
        circleOutlineLayer.strokeColor     = UIColor.blue.cgColor
        circleOutlineLayer.fillColor       = UIColor.clear.cgColor
        circleOutlineLayer.lineWidth       = outLineWidth
        circleOutlineLayer.strokeStart     = 0
        circleOutlineLayer.strokeEnd       = MinStrokeLength
        let center                         = CGPoint(x: bounds.width*0.5, y: bounds.height*0.5)
        circleOutlineLayer.frame           = bounds
        circleOutlineLayer.lineCap         = kCALineCapButt
        circleOutlineLayer.path            = UIBezierPath(arcCenter: center,
                                                          radius: center.x,
                                                          startAngle: 0,
                                                          endAngle: CGFloat(M_PI*2),
                                                          clockwise: true).cgPath
        circleOutlineLayer.transform       = CATransform3DMakeRotation(CGFloat(M_PI*1.5), 0, 0, 1.0)
        layer.addSublayer(circleOutlineLayer)
        // Inside
        let insideCircleRect = CGRect(origin: CGPoint(x: outLineWidth * 0.5, y: outLineWidth * 0.5),
                                      size: CGSize(width: circleOutlineLayer.bounds.width - outLineWidth,
                                                   height: circleOutlineLayer.bounds.height - outLineWidth))
        let insideCirclePath = UIBezierPath(ovalIn: insideCircleRect).cgPath
        insideCircleShapeLayer.path = insideCirclePath
        insideCircleShapeLayer.fillColor = UIColor.blue.cgColor
        insideCircleShapeLayer.opacity   = 0
        layer.addSublayer(insideCircleShapeLayer)
        
        // Checkmark
        checkmarkShapeLayer.strokeColor = UIColor.white.cgColor
        checkmarkShapeLayer.lineWidth   = 3.0
        checkmarkShapeLayer.fillColor   = UIColor.clear.cgColor
        checkmarkShapeLayer.path        = CheckmarkPath.cgPath
        checkmarkShapeLayer.strokeEnd   = 0
        layer.addSublayer(checkmarkShapeLayer)
    }
    
   
    
    private func startColorAnimation() {
        let color      = CAKeyframeAnimation(keyPath: "strokeColor")
        color.duration = 10.0
        color.values   = [UIColor.red.cgColor]
        color.calculationMode = kCAAnimationPaced
        color.repeatCount     = Float.infinity
        circleOutlineLayer.add(color, forKey: "color")
    }
    
    private func startRotatingAnimation() {
        let rotation            = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue        = M_PI*6.0
        rotation.duration       = (duration - AfterpartDuration) * 0.77
        rotation.isCumulative     = true
        rotation.isAdditive       = true
        rotation.isRemovedOnCompletion = false
        rotation.fillMode       = kCAFillModeForwards
        rotation.timingFunction = CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1.0)
        circleOutlineLayer.add(rotation, forKey: "rotation")
    }
    
    private func startStrokeAnimation() {
        let easeInOutSineTimingFunc = CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1.0)
        let progress: CGFloat     = MaxStrokeLength
        let endFromValue: CGFloat = circleOutlineLayer.strokeEnd
        let endToValue: CGFloat   = endFromValue + progress
        let strokeEnd                   = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.fromValue             = endFromValue
        strokeEnd.toValue               = endToValue
        strokeEnd.duration              = duration - AfterpartDuration
        strokeEnd.fillMode              = kCAFillModeForwards
        strokeEnd.timingFunction        = easeInOutSineTimingFunc
        strokeEnd.isRemovedOnCompletion   = false
        let pathAnim                 = CAAnimationGroup()
        pathAnim.animations          = [strokeEnd]
        pathAnim.duration            = duration - AfterpartDuration
        pathAnim.fillMode            = kCAFillModeForwards
        pathAnim.isRemovedOnCompletion = false
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.startCompletionAnimation()
        }
        circleOutlineLayer.add(pathAnim, forKey: "stroke")
        CATransaction.commit()
    }
    
    private func startCompletionAnimation() {
        startFadeOutOutSideLineAnimation()
        startFillCircleAnimation()
        startDrawingCheckmarkAnimation()
    }
    
    private func startFadeOutOutSideLineAnimation() {
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.toValue  = 0
        fadeOutAnimation.duration = AfterpartDuration
        fadeOutAnimation.fillMode = kCAFillModeForwards
        fadeOutAnimation.isRemovedOnCompletion = false
        fadeOutAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        circleOutlineLayer.add(fadeOutAnimation, forKey: "fadeOut")
    }
    
    private func startFillCircleAnimation() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.toValue  = 1.0
        fadeInAnimation.duration = AfterpartDuration
        fadeInAnimation.fillMode = kCAFillModeForwards
        fadeInAnimation.isRemovedOnCompletion = false
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        insideCircleShapeLayer.add(fadeInAnimation, forKey: "fadeOut")
    }
    
    private func startDrawingCheckmarkAnimation() {
        let drawPathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawPathAnimation.toValue = 1.0
        drawPathAnimation.fillMode = kCAFillModeForwards
        drawPathAnimation.isRemovedOnCompletion = false
        drawPathAnimation.duration = AfterpartDuration
        checkmarkShapeLayer.add(drawPathAnimation, forKey: "strokeEnd")
    }
    
    //MARK: Public method
    
    func stopAnimating() {
        layer.removeAllAnimations()
        circleOutlineLayer.removeAllAnimations()
        insideCircleShapeLayer.removeAllAnimations()
        checkmarkShapeLayer.removeAllAnimations()
        circleOutlineLayer.transform = CATransform3DIdentity
        layer.transform              = CATransform3DIdentity
    }
    
    func startAnimating(duration: Double) {
        self.duration = duration
        if layer.animation(forKey: "rotation") == nil {
            startColorAnimation()
            startStrokeAnimation()
            startRotatingAnimation()
        }
    }

}
