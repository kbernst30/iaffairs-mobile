//
//  PostsViewController.swift
//  IAffairsCanada
//
//  Created by Kyle Bernstein on 3/10/15.
//  Copyright (c) 2015 IAffairsCanada. All rights reserved.
//

import UIKit

let reuseIdentifier = "PostsViewCell"

class PostsViewController: UICollectionViewController {
    
    var postData: [AnyObject]? = nil
    var totalPosts: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        
        loadBlogPosts()
    }
    
    func loadBlogPosts() {
        
        func updatePostsView(data: String, isError: Bool) {
            if !isError {
                var jsonData = data.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
                var localError: NSError?
                var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                
                var responseData = json as? [String: AnyObject]
                postData = responseData!["posts"] as? [AnyObject]
                totalPosts = responseData!["found"] as! Int
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.collectionView!.reloadData()
                });
            } else {
                print(data)
            }
        }
        
        WordpressApiConnection.sharedInstance.doRequest("https://public-api.wordpress.com/rest/v1/sites/www.iaffairscanada.com/posts/", method: "GET", callback: updatePostsView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier != nil && segue.identifier! == "ShowPostSegue" {
            if let destination = segue.destinationViewController as? DetailedPostViewController {
                let view = self.collectionView
                let indexPath = view!.indexPathForCell(sender as! PostsViewCell)
                var post = postData![indexPath!.item] as! [String: AnyObject]
                destination.postTitle = (post["title"] as! String).gtm_stringByUnescapingFromHTML()
                destination.postContent = post["content"] as! String
            }
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        
        return postData != nil ? postData!.count : 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PostsViewCell
    
        // Configure the cell
        if postData != nil {
            var post = postData![indexPath.item] as! [String: AnyObject]
            
            cell.setTitle((post["title"] as! String).gtm_stringByUnescapingFromHTML())
            cell.setData("Posted on " + (post["date"] as! String))
        } else {
            cell.setTitle("testing")
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
