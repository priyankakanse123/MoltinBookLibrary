//
//  CartDataModel.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit
import moltin

class CartDataModel: NSObject {
    
    var title: String?
    var price: String?
    var image: UIImage?
    var descriptionOfProduct: String?
    var stock: String?
    var status: String?
    var isSelected: Bool = false
    var id: String?

    
    init(productValue:CartItem) {
        
        self.title = productValue.name
        self.price = "\(String(describing: productValue.unitPrice.amount)))  \(String(describing: productValue.unitPrice.currency))"
        self.descriptionOfProduct = productValue.description
        self.id = productValue.id
        
    }

    
}
