//
//  CollectionViewDelegate.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 26.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import UIKit

class CollectionViewManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let overlays: [(type: OverlayType, image: UIImage)] = [
        (.Hat, UIImage(named: "hat0")!),
        (.Hat, UIImage(named: "hat1")!),
        (.LeftEye, UIImage(named: "eye")!),
        (.RightEye, UIImage(named: "eye")!),
        (.RightEye, UIImage(named: "eyeRight0")!),
        (.LeftEye, UIImage(named: "eyeLeft0")!),
        (.LeftBrow, UIImage(named: "eyebrowLeft0")!),
        (.RightBrow, UIImage(named: "eyebrowRight0")!),
        (.LeftBrow, UIImage(named: "eyebrowLeft1")!),
        (.RightBrow, UIImage(named: "eyebrowRight1")!),
        (.Glasses, UIImage(named: "glasses0")!),
        (.Glasses, UIImage(named: "glasses1")!),
        (.Glasses, UIImage(named: "glasses2")!),
        (.Glasses, UIImage(named: "glasses3")!),
        (.Glasses, UIImage(named: "glasses4")!),
        (.Glasses, UIImage(named: "glasses5")!),
        (.Glasses, UIImage(named: "glasses6")!),
        (.Mouth, UIImage(named: "mouth0")!),
        (.Mouth, UIImage(named: "mouth1")!),
        (.Mouth, UIImage(named: "mouth2")!),
        (.Mouth, UIImage(named: "mouth3")!),
        (.Mouth, UIImage(named: "mouth4")!),
        (.Nose, UIImage(named: "nose0")!),
        (.Nose, UIImage(named: "nose1")!),
    ]
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //When someone clicks on the cell
        let type = overlays[indexPath.row].type
        NSLog("click on image \(type), hidden: \(Overlays.Views[type]!.hidden)")
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        
        if(Overlays.Views[type]!.hidden){
            NSLog("show it")
            cell.titleLabel.textColor = UIColor.grayColor()
            Overlays.Views[type]?.image = cell.imageView.image
            Overlays.showType(overlays[indexPath.row].type)
        } else {
            NSLog("hide it")
            cell.titleLabel.textColor = UIColor.whiteColor()
            Overlays.hideType(overlays[indexPath.row].type)
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        NSLog("load image number %i in a cell", indexPath.row)
        cell.imageView.image = self.overlays[indexPath.row].image
        cell.titleLabel.text = self.overlays[indexPath.row].type.rawValue
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return overlays.count
    }
}
