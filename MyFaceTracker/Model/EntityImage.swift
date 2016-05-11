//
//  EntityImage.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 30.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class EntityImage: NSManagedObject {
    
    @NSManaged var imageData: NSData?
    @NSManaged var relationshipPhoto: EntityPhoto?

    var image: UIImage? {
        get {
            if let imgData = self.imageData {
                return UIImage(data: imgData)
            }
            return nil
        }
        set(value) {
            if let value = value {
                self.imageData = UIImageJPEGRepresentation(value, 1)
            }
        }
    }

}
