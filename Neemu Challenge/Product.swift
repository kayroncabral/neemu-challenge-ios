//
//  Product.swift
//  Neemu Challenge
//
//  Created by Kayron Cabral on 03/08/16.
//  Copyright © 2016 Neemu. All rights reserved.
//

import UIKit

class Product {
    
    var id: String?
    var name: String?
    var link: String?
    var imageUrl: String?
    var imageCache: UIImage?
    var rating: String?
    var price: String?
    var priceRaw: Double?
    var lastPrice: String?
    var lastPriceRaw: Double?
    var desc: String?
    
    init() {}
    
    init(data: AnyObject!) {
        
        if let id = data["id"] as? String {
            self.id = id
        }

        if let name = data["name"] as? String {
            self.name = name
        }
        
        if let link = data["link"]! as? String {
            self.link = link
        }

        if let imageUrl = data["image"] as? String {
            self.imageUrl = imageUrl
        }

        if let rating = data["rating"] as? String {
            self.rating = rating
        }

        if let price = data["price"] as? String {
            self.price = price
        }
        
        if let priceRaw = data["price_raw"] as? Double {
            self.priceRaw = priceRaw
        }
        
        if let lastPrice = data["last_price"] as? String {
            self.lastPrice = lastPrice
        }
        
        if let lastPriceRaw = data["last_price_raw"] as? Double {
            self.lastPriceRaw = lastPriceRaw
        }
        
        if let desc = data["desc"] as? String {
            self.desc = desc
        }
    }

    
}