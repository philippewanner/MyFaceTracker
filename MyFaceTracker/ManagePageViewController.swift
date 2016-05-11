//
//  ManagePageViewController.swift
//  MyFaceTracker
//
//  Created by Philippe Wanner on 01.05.16.
//  Copyright © 2016 Philippe Wanner. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    
    var images: [UIImage]!
    
    var imageIndex: Int!
    
    var dateString: String!
    
    private var imageTotalCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        self.imageTotalCount = images.count
        
        if let viewController = viewPhotoCommentController(imageIndex ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers,
                               direction: .Forward,
                               animated: false,
                               completion: nil)
        }
    }
    
    func viewPhotoCommentController(index: Int) -> PhotoPageViewController? {
        if let storyboard = storyboard,
            page = storyboard.instantiateViewControllerWithIdentifier("PhotoPageViewController") as? PhotoPageViewController {
            page.image = self.images[index]
            page.imageIndex = index
            page.imageTotalCount = self.images.count
            page.dateLabelText = self.dateString
            return page
        }
        return nil
    }
}

//MARK: implementation of UIPageViewControllerDataSource
extension ManagePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? PhotoPageViewController {
            var index = viewController.imageIndex
            guard index != NSNotFound && index != 0 else { return nil }
            index = index - 1
            return viewPhotoCommentController(index)
        }
        return nil
    }
    
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? PhotoPageViewController {
            var index = viewController.imageIndex
            guard index != NSNotFound else { return nil }
            index = index + 1
            guard index != images.count else {return nil}
            return viewPhotoCommentController(index)
        }
        return nil
    }
    
    // MARK: UIPageControl
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return imageIndex ?? 0
    }
}