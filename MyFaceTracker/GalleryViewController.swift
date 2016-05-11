//
//  Gallery.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 30.04.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import UIKit
import CoreData

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var moc : NSManagedObjectContext!
    
    var thumbnails: [EntityThumbnail]!
    
    var pagesManager: ManagePageViewController!
    
    @IBOutlet var galleryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        NSLog("Gallery did load")
        super.viewDidLoad()
        
        // Delegate and Data Source
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        
        // create an instance of our managedObjectContext
        moc = DataController().managedObjectContext
        // fetch all the thumbnails
        fetchAllThumbnails()
    }
    
    private func fetchAllThumbnails() {
        
        let thumbnailFetch = NSFetchRequest(entityName: "EntityThumbnail")
        
        do {
            self.thumbnails = try moc.executeFetchRequest(thumbnailFetch) as! [EntityThumbnail]
            print("There are \(thumbnails.count) thumbnails stored")
            
        } catch {
            fatalError("Failed to fetch thumbnail: \(error)")
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("galleryCell", forIndexPath: indexPath) as! GalleryCell
        
        NSLog("load image number %i in a cell", indexPath.row)
        cell.imageView.image = self.thumbnails[indexPath.row].thumbnail
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnails.count
    }
    
    @IBAction func unwindToGallery(segue: UIStoryboardSegue) {
        NSLog("Unwind to gallery")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("prepare for segue")
        if let
            cell = sender as? UICollectionViewCell, indexPath = galleryCollectionView?.indexPathForCell(cell), managePageViewController = segue.destinationViewController as? ManagePageViewController {
            // Pass the images to the page controller
            var fullResolutionImages = [UIImage]()
            for EntityThumbnail in self.thumbnails {
                fullResolutionImages.append((EntityThumbnail.relationshipPhoto?.image!)!)
            }
            managePageViewController.images = fullResolutionImages
            // Set the current index image clicked
            managePageViewController.imageIndex = indexPath.row
            // Set the creation date
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            let dateString = formatter.stringFromDate((self.thumbnails[indexPath.row].relationshipPhoto?.creationDate)!)
            managePageViewController.dateString = "Creation date: \(dateString)"
        }
    }
}


