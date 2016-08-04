//
//  ViewController.swift
//  Neemu Challenge
//
//  Created by Kayron Cabral on 03/08/16.
//  Copyright © 2016 Neemu. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let productIdentifier = "ProductIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]() {
        didSet {
            let hasItems = products.count > 0
            tableView.hidden = !hasItems
//            messageLabel.hidden = hasItems
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(productIdentifier, forIndexPath: indexPath) as! ProductCell
        
        dispatch_async(dispatch_get_main_queue()) { 
            if let url = NSURL(string: self.products[indexPath.row].image!) {
                if let data = NSData(contentsOfURL: url) {
                    cell.photo.image = UIImage(data: data)
                }
            }
        }
        
        cell.name.text = products[indexPath.row].name
        cell.price.text = products[indexPath.row].lastPrice! + " por " + products[indexPath.row].price!
        
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func parseJSON() -> NSDictionary! {
        let filePath = NSBundle.mainBundle().pathForResource("challenge", ofType:"json")!
        
        let data = NSData(contentsOfFile: filePath)!
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
            
        return json
    }
    
    func loadData() {
        let data = parseJSON()
        let result = data!["result"] as! NSDictionary
        let products = result["products"]! as! NSArray
        for product in products {
        let product = Product(data: product as! NSDictionary)
            self.products.append(product)
        }
    }
    
}

