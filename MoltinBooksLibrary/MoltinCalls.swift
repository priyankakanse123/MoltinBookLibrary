//
//  MoltinCalls.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit
import moltin

class MoltinCalls: NSObject {
    
    static var moltin: Moltin?
    
    //authorized moltin
    class func authorizeMoltin() {
        moltin = Moltin(withClientID: "syPjFYN1qw0id5jhu4y8x8G3cAQBBs5BcKmuDaCag5")
    }
    
    //to get all product details
    class func getAllProductDetails(success: @escaping (PaginatedResponse<[Product]>) -> (),failure: @escaping (Error) -> ()) {
        guard let moltinObj = moltin else {
            //throw an initilalizing error
            print("error")
            return
        }
        moltinObj.product.all { (result: Result<PaginatedResponse<[Product]>>) in
            switch result {
            case .success(let products):
                success(products)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    //to get all product details
    class func addItemInCart(success: @escaping (String) -> (),failure: @escaping (Error) -> ()) {
        guard let moltinObj = moltin else {
            //throw an initilalizing error
            print("error")
            return
        }
        moltinObj.cart.addProduct(withID: "",
                               ofQuantity: 1,
                               toCart: "XXXX") { (result) in
            switch result {
            case .success:
                success("Prduct added")
            case .failure(let error):
                failure(error)
            }
        }
    }

    

}
