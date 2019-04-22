//
//  CartViewPresenter.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit

protocol PmoltenViewCartCallback {
    func success(productValue:Array<CartDataModel>)
    func showError(message:String)
}




class CartViewPresenter: NSObject {
    var delegate: PmoltenViewCartCallback?
    var cartModelArray = Array<CartDataModel>()
    
    init(pmoltenViewCartCallback:PmoltenViewCartCallback) {
        self.delegate = pmoltenViewCartCallback
    }
    
    func getCartData() {
        MoltinCalls.getItemInCart( success: {(cartItemArray) in
            print(cartItemArray.count)
            
            for cartItem in cartItemArray {
                let modelObj = CartDataModel(productValue: cartItem)
                self.cartModelArray.append(modelObj)
            }
            self.delegate?.success(productValue: self.cartModelArray)
            
        }, failure: {error in
            //fix localize error
            self.delegate?.showError(message: error.localizedDescription)
            
        })
    }

}
