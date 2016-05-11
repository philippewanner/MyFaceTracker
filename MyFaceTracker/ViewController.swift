//
//  ViewController.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 13.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import UIKit
import FaceTracker

class ViewController: UIViewController {
    
    weak var faceTrackerViewController: FaceTrackerViewController?
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var galleryButton: UIButton!
    
    @IBOutlet weak var alphaLabel: UILabel!
    
    @IBOutlet weak var overlayButton: UIButton!
    
    @IBOutlet var swapCameraButton: UIButton!
    
    @IBOutlet var faceTrackerContainerView: UIView!
    
    var collectionViewManager = CollectionViewManager()
    
    var overlayController: Overlays!
    
    var isOverlaysCollectionOpen = false
    
    @IBOutlet weak var overlaysView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Collection View
        self.collectionView.hidden = true
        self.collectionView.delegate = collectionViewManager
        self.collectionView.dataSource = collectionViewManager
        self.collectionView.backgroundColor = UIColor.clearColor()
        
        //Overlay Controller
        self.overlayController = Overlays(overlaysView: self.overlaysView)
        
        //FaceTrackerViewController
        faceTrackerViewController?.delegate = overlayController
        
        //Overlay Menu
        self.hideOverlayMenu()
        
        //Overlay view no background
        self.overlaysView.backgroundColor = UIColor.clearColor()
        
        //Alpha
        self.faceTrackerContainerView.alpha = CGFloat(slider.value)
        self.alphaLabel.hidden = true
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "faceTrackerEmbed"){
            NSLog("prepare for segue faceTrackerEmbed")
            faceTrackerViewController = segue.destinationViewController as? FaceTrackerViewController
            faceTrackerViewController!.delegate = self.overlayController
        }
        
        if(segue.identifier == "toCheckPhoto") {
            NSLog("prepare for segue toCheckPhoto")
            let photoViewController = segue.destinationViewController as? CheckPhotoViewController
            
            //Convert UIView to UIImage
            UIGraphicsBeginImageContextWithOptions(faceTrackerContainerView.bounds.size, true, 0)
            faceTrackerContainerView.backgroundColor = UIColor.whiteColor()
            faceTrackerContainerView.drawViewHierarchyInRect(faceTrackerContainerView.bounds, afterScreenUpdates: true)
            overlaysView.drawViewHierarchyInRect(overlaysView.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            photoViewController?.image = image
            photoViewController?.sourceController = self
            
        }
    }
    
    override func  viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("did appear")
        faceTrackerViewController!.startTracking{ () -> Void in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swapCamera(sender: UIButton) {
        faceTrackerViewController?.swapCamera()
    }
    
    @IBAction func onOverlay(sender: UIButton) {
        if overlayButton.selected {
            self.hideOverlayMenu()
        } else {
            self.showOverlayMenu()
        }
    }
    
    private func showOverlayMenu() {
        NSLog("show overlay menu")
        self.overlayButton.imageView?.image = UIImage(named: "overlayButtonSelected")
        self.overlayButton.selected = true
        self.collectionView.hidden = false
    }
    
    private func hideOverlayMenu() {
        NSLog("hide overlay menu")
        self.overlayButton.imageView?.image = UIImage(named: "overlayButton")
        self.overlayButton.selected = false
        self.collectionView.hidden = true
    }
    
    @IBAction func onGallery(sender: UIButton) {
        
    }
    
    @IBAction func unwindToFaceTracker(segue: UIStoryboardSegue) {
    }
    
    @IBAction func onSlider(sender: UISlider) {
        let sliderValue = CGFloat(slider.value)
        self.faceTrackerContainerView.alpha = sliderValue
        self.alphaLabel.text = String(format: "%02.1f%%", sliderValue * 100)
    }
    
    @IBAction func onSliderTouchDown(sender: UISlider) {
        NSLog("slider - touch down")
        self.alphaLabel.hidden = false
    }
    
    @IBAction func onSliderTouchUpInside(sender: UISlider) {
        NSLog("slider - touch up inside")
        self.alphaLabel.hidden = true
        
    }
    
    @IBAction func onSliderTouchUpOutside(sender: UISlider) {
        NSLog("slider - touch up ouside")
        self.alphaLabel.hidden = true
    }
    
}

