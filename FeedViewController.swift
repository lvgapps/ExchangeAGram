//
//  FeedViewController.swift
//  ExchangeAGram
//
//  Created by Wale Anif on 12/22/14.
//  Copyright (c) 2014 Lavvo Group. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var feedArray: [AnyObject] = []
    
    let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        let request = NSFetchRequest(entityName: "FeedItem")
        managedObjectContext.executeFetchRequest(request, error: nil)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButtonTapped(sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            var cameraController = UIImagePickerController()
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaTypes
            cameraController.allowsEditing = false
            
            self.presentViewController(cameraController, animated: true, completion: nil)
            
        }
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            var photoLibraryController = UIImagePickerController()
            photoLibraryController.delegate = self
            photoLibraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            photoLibraryController.mediaTypes = mediaTypes
            photoLibraryController.allowsEditing = false
            
            self.presentViewController(photoLibraryController, animated: true, completion: nil)
            
        }
        else{
            
            Scripts.alert(self, header: "Error", message: "Media Source Unavailable")
            
        }
        
    }
    
    /****************************************************************************************************************************
    
    UIImagePickerControllerDelegate
    
    *****************************************************************************************************************************/
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        
        let entityDescription = NSEntityDescription.entityForName("FeedItem", inManagedObjectContext: managedObjectContext)
        let feedItem = FeedItem(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        //let feedItem = NSEntityDescription.insertNewObjectForEntityForName("FeedItem", inManagedObjectContext: managedObjectContext) as FeedItem
        
        feedItem.image = imageData
        feedItem.caption = "Test Caption"
        
        appDelegate.saveContext()
        
        feedArray.append(feedItem)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        collectionView.reloadData()
        
    }
    
    
    /****************************************************************************************************************************

    UICollectionViewDataSource

    *****************************************************************************************************************************/
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return feedArray.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell:FeedCell = collectionView.dequeueReusableCellWithReuseIdentifier("ReuseCell", forIndexPath: indexPath) as FeedCell
        
        let thisItem = feedArray[indexPath.item] as FeedItem
        
        cell.imageView.image = UIImage(data: thisItem.image)
        cell.captionLabel.text = thisItem.caption
        
        return cell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
