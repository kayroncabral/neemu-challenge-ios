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
    let headerIdentifier = "HeaderIdentifier"
    let detailViewControllerIdentifier = "DetailViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]() {
        didSet {
            let hasItems = products.count > 0
            tableView.hidden = !hasItems
        }
    }
    
    var productsHeader = ["Games para PS4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier(headerIdentifier) as! HeaderCell
        cell.title.text = productsHeader[section]
        return cell.contentView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: products[indexPath.row].lastPrice!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        
        cell.lastPrice.attributedText = attributeString
        
        cell.price.text = products[indexPath.row].price!
        
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewControllerWithIdentifier(detailViewControllerIdentifier) as! DetailViewController
        DetailViewController.product = products[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
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

