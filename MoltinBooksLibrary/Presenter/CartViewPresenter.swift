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
            self.cartModelArray.removeAll()
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
    
    func deleteCart(cartModelArray:Array<CartDataModel>) {
                
        for productObj in cartModelArray {
            if(productObj.isSelected == true) {
                MoltinCalls.deleteItemInCart(id:productObj.id ?? "",success: {(cartItemArray) in
                    print(cartItemArray.count)
                    self.cartModelArray.removeAll()
                    for cartItem in cartItemArray {
                        let modelObj = CartDataModel(productValue: cartItem)
                        self.cartModelArray.append(modelObj)
                    }
                    self.delegate?.success(productValue: self.cartModelArray)
                    
                }, failure: { error in
                    //TODO:-need to handle if item gives an error while adding
                    self.delegate?.showError(message: error.localizedDescription)
                })
            }
            
        }
        
    }
    


}
