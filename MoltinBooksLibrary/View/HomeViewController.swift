//
//  HomeViewController.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,PmoltenHomeCallback {
    
    var homePresenterObj: HomeViewPresenter?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getProductDetails()
    }
    
    func getProductDetails() {
        self.homePresenterObj = HomeViewPresenter(pmoltenHomeCallback: self)
        homePresenterObj?.getProductDetails()
    }
    
    
    //MARK:callback implementation
    func success(productValue:Codable) {
        
    }
    func showError(message:String) {
        //show localized error
        print("error")
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
