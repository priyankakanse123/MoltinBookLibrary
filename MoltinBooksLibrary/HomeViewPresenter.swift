//
//  HomeViewPresenter.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit

protocol PmoltenHomeCallback {
    func success(productValue:Array<HomeViewModel>)
    func showError(message:String)
    func performCheckoutAction()
}

class HomeViewPresenter: NSObject {
    
    var delegate: PmoltenHomeCallback?
    var modelArray = Array<HomeViewModel>()
    
    init(pmoltenHomeCallback:PmoltenHomeCallback) {
        self.delegate = pmoltenHomeCallback
    }
    
    
    
    func getProductDetails() {
        
        self.modelArray.removeAll()
        MoltinCalls.authorizeMoltin()
        MoltinCalls.getAllProductDetails(success: { result in
            
            guard let dataObjArray = result.data else {
                // print(data error)
                print("error")
                return
            }
            
            for dataObj in dataObjArray {
                print(dataObj)
                let modelObj = HomeViewModel(productValue: dataObj)
                self.modelArray.append(modelObj)
            }
            self.delegate?.success(productValue: self.modelArray)
            
        }, failure: { error in
                self.delegate?.showError(message: error.localizedDescription)
            })
    }
    
    //add cart items
    func addCartItems(homeModelArray:Array<HomeViewModel>) {
        
        var i = 0
        
        for productObj in homeModelArray {
            if(productObj.isSelected == true) {
                MoltinCalls.addItemInCart(id:productObj.id ?? "",success: {
                    successString in
                    i += 1
                    self.performCheckoutAction(i: i,totalCount:homeModelArray.count)
                }, failure: { error in
                    //TODO:-need to handle if item gives an error while adding
                    self.delegate?.showError(message: error.localizedDescription)
                    i += 1
                    self.performCheckoutAction(i: i,totalCount:homeModelArray.count)
                })
            } else {
                i += 1
                self.performCheckoutAction(i: i,totalCount:homeModelArray.count)
            }
        }

    }
    
    func performCheckoutAction(i:Int,totalCount:Int) {
        if(i==totalCount) {
            self.delegate?.performCheckoutAction()
        }
    }

}
