//
//  PostsViewCell.swift
//  IAffairsCanada
//
//  Created by Kyle Bernstein on 3/10/15.
//  Copyright (c) 2015 IAffairsCanada. All rights reserved.
//

import UIKit

class PostsViewCell: UICollectionViewCell {
    
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var postData: UILabel!
    
    override func drawRect(rect: CGRect) {
        var color: UIColor = UIColor.grayColor()
        var bpath: UIBezierPath = UIBezierPath(rect: rect)
        color.set()
        bpath.stroke()
    }

    
    func setTitle(title: String) {
        postTitle.text = title
    }
    
    func setData(date: String) {
        postData.text = date
    }
}
