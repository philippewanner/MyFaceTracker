//
//  EntityThumbnail.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 30.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class EntityThumbnail: NSManagedObject {

    @NSManaged var thumbnailData: NSData?
    @NSManaged var relationshipPhoto: EntityPhoto?
    
    private let maxThumbnailSize: CGSize = CGSize(width: 200, height: 200)
    
    var thumbnail : UIImage? {
        get {
            if let thumbData = self.thumbnailData {
                return UIImage(data: thumbData)
            }
            NSLog("no data in thumbnail image")
            return nil
        }
        set(value) {
            if let value = value {
                var thumbResized: UIImage
                if(value.size.width > maxThumbnailSize.width){
                    NSLog("resize thumbnail")
                    thumbResized = resizeImage(value, width: maxThumbnailSize.width)
                } else {
                    NSLog("no resizing thumbnail")
                    thumbResized = value
                }
                self.thumbnailData = UIImageJPEGRepresentation(thumbResized, 1)
            }
        }
    }
    
    private func resizeImage(imageToResize: UIImage, width: CGFloat) -> UIImage
    {
        let scale = width / imageToResize.size.width
        let height = imageToResize.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        imageToResize.drawInRect(CGRectMake(0, 0, width, height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
