//
//  PersonCell.swift
//  MissingPersons
//
//  Created by Ryan Collins on 6/8/16.
//  Copyright © 2016 Ryan Collins. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    
    func configureCell(imgURL: String) {
        
        if let url = NSURL(string: imgURL) {
            downloadImage(url)
        }
    }
    
    func downloadImage(url: NSURL) {
        getDataFromURL(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else {return}
                self.personImage.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromURL(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) {
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
        }.resume()
    }
    
}
