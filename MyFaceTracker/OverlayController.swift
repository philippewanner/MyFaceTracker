//
//  ElementManager.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 26.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import UIKit
import FaceTracker

class Overlays: NSObject, FaceTrackerViewControllerDelegate {
    
    static var Views : [OverlayType: UIImageView] = [
        .Hat: UIImageView(image: UIImage(named: "hat")),
        .LeftEye: UIImageView(image: UIImage(named: "eye")),
        .RightEye: UIImageView(image: UIImage(named: "eye")),
        .LeftBrow: UIImageView(image: UIImage(named: "leftEyebrow")),
        .RightBrow: UIImageView(image: UIImage(named: "rightEyebrow")),
        .Glasses: UIImageView(image: UIImage(named: "glasses0")),
        .Mouth: UIImageView(image: UIImage(named: "mouth")),
        .Nose: UIImageView(image: UIImage(named: "nose")),
        ]
    
    init(overlaysView: UIView) {
        overlaysView.addSubview(Overlays.Views[.Hat]!)
        overlaysView.addSubview(Overlays.Views[.LeftEye]!)
        overlaysView.addSubview(Overlays.Views[.RightEye]!)
        overlaysView.addSubview(Overlays.Views[.LeftBrow]!)
        overlaysView.addSubview(Overlays.Views[.RightBrow]!)
        overlaysView.addSubview(Overlays.Views[.Mouth]!)
        overlaysView.addSubview(Overlays.Views[.Glasses]!)
        overlaysView.addSubview(Overlays.Views[.Nose]!)
    }
    
    func hideAllOverlayViews() {
        for(_, view) in Overlays.Views {
            view.hidden = true
        }
    }
    
    func showAllOverlayViews() {
        for(_, view) in Overlays.Views {
            view.hidden = false
        }
    }
    
    static func hideType(ot: OverlayType) {
        for (type, _) in Overlays.Views {
            if( type == ot) {
                NSLog("hide \(type)")
                Overlays.Views[type]!.hidden = true
            }
        }
    }
    
    static func showType(ot: OverlayType) {
        for (type, _) in Overlays.Views {
            if( type == ot) {
                NSLog("show \(type)")
                Overlays.Views[type]!.hidden = false
            }
        }
    }
    
    private func drawHat(points: FacePoints){
        let eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
        let eyeToEyeCenter = CGPointMake((points.leftEye[0].x + points.rightEye[5].x) / 2, (points.leftEye[0].y + points.rightEye[5].y) / 2)
        
        let hatWidth = 2.0 * eyeCornerDist
        let hatHeight = (Overlays.Views[.Hat]!.image!.size.height / Overlays.Views[.Hat]!.image!.size.width) * hatWidth
        
        Overlays.Views[.Hat]!.transform = CGAffineTransformIdentity
        
        Overlays.Views[.Hat]!.frame = CGRectMake(eyeToEyeCenter.x - hatWidth / 2, eyeToEyeCenter.y - 1.3 * hatHeight, hatWidth, hatHeight)
        Overlays.Views[.Hat]!.hidden = false
        
        let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        Overlays.Views[.Hat]!.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func drawRightEye(points: FacePoints){
        
        // Compute the left eye frame
        let rightEyeCenter = CGPointMake((points.rightEye[0].x + points.rightEye[5].x)/2, (points.rightEye[0].y + points.rightEye[5].y)/2)
        
        let rightEyeWidth = sqrt(pow(points.rightEye[0].x - points.rightEye[5].x, 2) + pow(points.rightEye[0].y - points.rightEye[5].y, 2))
        let rightEyeHeight = (Overlays.Views[.RightEye]!.image!.size.height / Overlays.Views[.RightEye]!.image!.size.width) * rightEyeWidth
        
        Overlays.Views[.RightEye]!.transform = CGAffineTransformIdentity
        
        Overlays.Views[.RightEye]!.frame = CGRectMake(rightEyeCenter.x - rightEyeWidth / 2, rightEyeCenter.y - rightEyeHeight / 2, rightEyeWidth, rightEyeHeight)
        Overlays.Views[.RightEye]!.hidden = false
        
        setAnchorPoint(CGPointMake(0.5, 1.0), forView: Overlays.Views[.RightEye]!)
        
        let angle = atan2(points.rightEye[5].y - points.rightEye[0].y, points.rightEye[5].x - points.rightEye[0].x)
        Overlays.Views[.RightEye]!.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func drawLeftEye(points: FacePoints){
        // Compute the left eye frame
        let leftEyeCenter = CGPointMake((points.leftEye[0].x + points.leftEye[5].x)/2, (points.leftEye[0].y + points.leftEye[5].y)/2)
        
        let leftEyeWidth = sqrt(pow(points.leftEye[0].x - points.leftEye[5].x, 2) + pow(points.leftEye[0].y - points.leftEye[5].y, 2))
        let leftEyeHeight = (Overlays.Views[.LeftEye]!.image!.size.height / Overlays.Views[.LeftEye]!.image!.size.width) * leftEyeWidth
        
        Overlays.Views[.LeftEye]!.transform = CGAffineTransformIdentity
        
        Overlays.Views[.LeftEye]!.frame = CGRectMake(leftEyeCenter.x - leftEyeWidth / 2, leftEyeCenter.y - leftEyeHeight/2, leftEyeWidth, leftEyeHeight)
        Overlays.Views[.LeftEye]!.hidden = false
        
        setAnchorPoint(CGPointMake(0.5, 1.0), forView: Overlays.Views[.LeftEye]!)
        
        let angle = atan2(points.leftEye[5].y - points.leftEye[0].y, points.leftEye[5].x - points.leftEye[0].x)
        Overlays.Views[.LeftEye]!.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func drawRightEyebrow(points: FacePoints){
        // Compute the left eye frame
        let rightEyeCenter = CGPointMake((points.rightBrow[0].x + points.rightBrow[3].x)/2, (points.rightBrow[0].y + points.rightBrow[3].y)/2)
        
        let rightEyeWidth = sqrt(pow(points.rightBrow[0].x - points.rightBrow[3].x, 2) + pow(points.rightBrow[0].y - points.rightBrow[3].y, 2))
        let rightEyeHeight = (Overlays.Views[.RightBrow]!.image!.size.height / Overlays.Views[.RightBrow]!.image!.size.width) * rightEyeWidth
        
        Overlays.Views[.RightBrow]!.transform = CGAffineTransformIdentity
        
        Overlays.Views[.RightBrow]!.frame = CGRectMake(rightEyeCenter.x - rightEyeWidth / 2, rightEyeCenter.y - rightEyeHeight / 2, rightEyeWidth, rightEyeHeight)
        Overlays.Views[.RightBrow]!.hidden = false
        
        setAnchorPoint(CGPointMake(0.5, 1.0), forView: Overlays.Views[.RightBrow]!)
        
        let angle = atan2(points.rightBrow[3].y - points.rightBrow[0].y, points.rightBrow[3].x - points.rightBrow[0].x)
        Overlays.Views[.RightBrow]!.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func drawLeftEyebrow(points: FacePoints){
        // Compute the left eye frame
        let leftEyeCenter = CGPointMake((points.leftBrow[0].x + points.leftBrow[3].x)/2, (points.leftBrow[0].y + points.leftBrow[3].y)/2)
        
        let leftEyeWidth = sqrt(pow(points.leftBrow[0].x - points.leftBrow[3].x, 2) + pow(points.leftBrow[0].y - points.leftBrow[3].y, 2))
        let leftEyeHeight = (Overlays.Views[.LeftBrow]!.image!.size.height / Overlays.Views[.LeftBrow]!.image!.size.width) * leftEyeWidth
        
        Overlays.Views[.LeftBrow]!.transform = CGAffineTransformIdentity
        
        Overlays.Views[.LeftBrow]!.frame = CGRectMake(leftEyeCenter.x - leftEyeWidth / 2, leftEyeCenter.y - leftEyeHeight/2, leftEyeWidth, leftEyeHeight)
        Overlays.Views[.LeftBrow]!.hidden = false
        
        setAnchorPoint(CGPointMake(0.5, 1.0), forView: Overlays.Views[.LeftBrow]!)
        
        let angle = atan2(points.leftBrow[3].y - points.leftBrow[0].y, points.leftBrow[3].x - points.leftBrow[0].x)
        Overlays.Views[.LeftBrow]!.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
    private func drawMouth(points: FacePoints){
        // Compute the left eye frame
        let mouthCenter = CGPointMake((points.outerMouth[0].x + points.outerMouth[6].x)/2, (points.outerMouth[0].y + points.outerMouth[6].y)/2)
        
        let mouthWidth = sqrt(pow(points.outerMouth[0].x - points.outerMouth[6].x, 2) + pow(points.outerMouth[0].y - points.outerMouth[6].y, 2))
        let mouthHeight = (Overlays.Views[.Mouth]!.image!.size.height / Overlays.Views[.Mouth]!.image!.size.width) * mouthWidth
        
        Overlays.Views[.Mouth]!.transform = CGAffineTransformIdentity
        
        Overlays.Views[.Mouth]!.frame = CGRectMake(mouthCenter.x - mouthWidth / 2, mouthCenter.y - mouthHeight/2, mouthWidth, mouthHeight)
        Overlays.Views[.Mouth]!.hidden = false
        
        setAnchorPoint(CGPointMake(0.5, 1.0), forView: Overlays.Views[.LeftEye]!)
        
        let angle = atan2(points.outerMouth[6].y - points.outerMouth[0].y, points.outerMouth[6].x - points.outerMouth[0].x)
        Overlays.Views[.Mouth]!.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func drawNose(points: FacePoints){
        // Compute the left eye frame
        let noseCenter = CGPointMake((points.nose[1].x + points.nose[5].x)/2, (points.nose[1].y + points.nose[5].y)/2)
        
        let noseWidth = sqrt(pow(points.nose[1].x - points.nose[5].x, 2) + pow(points.nose[1].y - points.nose[5].y, 2))
        let noseHeight = (Overlays.Views[.Nose]!.image!.size.height / Overlays.Views[.Nose]!.image!.size.width) * noseWidth
        
        Overlays.Views[.Nose]!.transform = CGAffineTransformIdentity
        
        Overlays.Views[.Nose]!.frame = CGRectMake(noseCenter.x - noseWidth / 2, noseCenter.y - noseHeight/2, noseWidth, noseHeight)
        Overlays.Views[.Nose]!.hidden = false
        
        setAnchorPoint(CGPointMake(0.5, 1.0), forView: Overlays.Views[.Nose]!)
        
        let angle = atan2(points.nose[5].y - points.nose[1].y, points.nose[5].x - points.nose[1].x)
        Overlays.Views[.Nose]!.transform = CGAffineTransformMakeRotation(angle)
    }
    
    private func drawGlasses(points: FacePoints){
        let eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
        let eyeToEyeCenter = CGPointMake((points.leftEye[0].x + points.rightEye[5].x) / 2, (points.leftEye[0].y + points.rightEye[5].y) / 2)
        
        let glassesWidth = 2.0 * eyeCornerDist
        let glassesHeight = (Overlays.Views[.Glasses]!.image!.size.height / Overlays.Views[.Glasses]!.image!.size.width) * glassesWidth
        
        Overlays.Views[.Glasses]!.transform = CGAffineTransformIdentity
        
        Overlays.Views[.Glasses]!.frame = CGRectMake(eyeToEyeCenter.x - glassesWidth / 2, eyeToEyeCenter.y - glassesHeight/2, glassesWidth, glassesHeight)
        Overlays.Views[.Glasses]!.hidden = false
        
        let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        Overlays.Views[.Glasses]!.transform = CGAffineTransformMakeRotation(angle)
    }
    
    //Actual protocol implementation
    func faceTrackerDidUpdate(points: FacePoints?) {
        
        if let points = points {
            
            if(!Overlays.Views[OverlayType.LeftEye]!.hidden){
                drawLeftEye(points)
            }
            
            if(!Overlays.Views[OverlayType.RightEye]!.hidden){
                drawRightEye(points)
            }
            
            if(!Overlays.Views[OverlayType.LeftBrow]!.hidden) {
                drawLeftEyebrow(points)
            }
            
            if(!Overlays.Views[OverlayType.RightBrow]!.hidden) {
                drawRightEyebrow(points)
            }
            
            if(!Overlays.Views[OverlayType.Hat]!.hidden) {
                drawHat(points)
            }
            
            if(!Overlays.Views[OverlayType.Nose]!.hidden) {
                drawNose(points)
            }
            
            if(!Overlays.Views[OverlayType.Mouth]!.hidden) {
                drawMouth(points)
            }
            
            if(!Overlays.Views[OverlayType.Glasses]!.hidden) {
                drawGlasses(points)
            }
            
        } else {
            self.hideAllOverlayViews()
        }
        
    }
    
}
