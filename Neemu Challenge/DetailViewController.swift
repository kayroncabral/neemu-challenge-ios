//
//  DetailViewController.swift
//  Neemu Challenge
//
//  Created by Kayron Cabral on 03/08/16.
//  Copyright © 2016 Neemu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static var product: Product?
    
    let detailIdentifier = "DetailIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(detailIdentifier, forIndexPath: indexPath) as! DetailCell
        
        let product = DetailViewController.product
        
        dispatch_async(dispatch_get_main_queue()) {
            if let url = NSURL(string: product!.image!) {
                if let data = NSData(contentsOfURL: url) {
                    cell.photo.image = UIImage(data: data)
                }
            }
        }
        
        cell.name.text = product!.name
        cell.lastPrice.text = product!.lastPrice
        cell.price.text = product!.price
        cell.desc.text = product!.desc
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
