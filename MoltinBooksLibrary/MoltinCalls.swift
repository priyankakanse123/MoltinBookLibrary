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
    class func addItemInCart(id:String,success: @escaping (String) -> (),failure: @escaping (Error) -> ()) {
        guard let moltinObj = moltin else {
            //throw an initilalizing error
            print("error")
            return
        }
        moltinObj.cart.addProduct(withID: id,
                               ofQuantity: 1,
                               toCart: "myCart") { (result) in
            switch result {
            case .success:
                success("Prduct added")
            case .failure(let error):
                failure(error)
            }
        }
    }

    //view cart
    class func getItemInCart(success: @escaping ([CartItem]) -> (),failure: @escaping (Error) -> ()) {
        guard let moltinObj = moltin else {
            //throw an initilalizing error
            print("error")
            
            return
        }
        moltinObj.cart.items(forCartID: "myCart") { (result) in

                                    switch result {
                                    case .success(let response):
                                        success(response.data ?? [CartItem]())
                                    case .failure(let error):
                                        failure(error)
                                    }
        }
    }
    
    
    //view cart
    class func deleteItemInCart(id:String,success: @escaping ([CartItem]) -> (),failure: @escaping (Error) -> ()) {
        guard let moltinObj = moltin else {
            //throw an initilalizing error
            print("error")
            
            return
        }
        moltinObj.cart.removeItem(id, fromCart: "myCart", completionHandler: { (result) in
            
            switch result {
            case .success(let response):
                success(response ?? [CartItem]())
            case .failure(let error):
                failure(error)
            }
        })
    }


    
}
