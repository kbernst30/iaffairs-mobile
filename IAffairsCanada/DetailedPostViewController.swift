//
//  DetailedPostViewController.swift
//  IAffairsCanada
//
//  Created by Kyle Bernstein on 4/28/15.
//  Copyright (c) 2015 IAffairsCanada. All rights reserved.
//

import UIKit

class DetailedPostViewController: UIViewController, UIScrollViewDelegate {
    
    var postTitle = ""
    var postContent = ""
    
    @IBOutlet weak var postWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSLog(postContent)
        postWebView.loadHTMLString(postContent, baseURL: nil)
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
