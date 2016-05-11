//
//  EntityPhoto.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 30.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class EntityPhoto: NSManagedObject {

    @NSManaged var creationDate: NSDate?
    @NSManaged var relationshipThumbnail: EntityThumbnail?
    @NSManaged var relationshipImage: EntityImage?

    var image : UIImage? {
        get {
            return self.relationshipImage?.image
        }
        set(value) {
            self.relationshipImage?.image = value
        }
    }
    
    var thumbnail : UIImage? {
        get {
            return self.relationshipThumbnail?.thumbnail
        }
        set(value) {
            self.relationshipThumbnail?.thumbnail = value
        }
    }
}
