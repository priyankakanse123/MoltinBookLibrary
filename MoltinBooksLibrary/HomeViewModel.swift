//
//  HomeViewModel.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit
import moltin

class HomeViewModel: NSObject {
    
    var title: String?
    var price: String?
    var image: UIImage?
    var descriptionOfProduct: String?
    var stock: String?
    var status: String?
    init(productValue:Product) {
        
        self.title = productValue.name
        self.price = "\(String(describing: productValue.price?[0].amount) )  \(String(describing: productValue.price?[0].currency))"
        self.descriptionOfProduct = productValue.description
        self.status = productValue.status
        
    }
    
}
