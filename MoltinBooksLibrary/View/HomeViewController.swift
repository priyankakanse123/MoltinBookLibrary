//
//  HomeViewController.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,PmoltenHomeCallback,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var productTableView: UITableView!
    var homePresenterObj: HomeViewPresenter?
    var homeModelArray = Array<HomeViewModel>()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getProductDetails()
    }
    
    func getProductDetails() {
        self.homePresenterObj = HomeViewPresenter(pmoltenHomeCallback: self)
        homePresenterObj?.getProductDetails()
        self.productTableView.estimatedRowHeight = 40
        self.productTableView.rowHeight = UITableView.automaticDimension
        self.productTableView.tableFooterView = UIView()
    }
    
    
    //MARK:callback implementation
    func success(productValue:Array<HomeViewModel>) {
        self.homeModelArray = productValue
        DispatchQueue.main.async {
            self.productTableView.reloadData()
        }
    }
    
    func showError(message:String) {
        //show localized error
        print("error")
    }
    
    //MARK:-UITableview data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeModelArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! HomeProductTableViewCell
        
        let productObj = self.homeModelArray[indexPath.row]
        cell.productTitle.text = productObj.title ?? ""
        cell.productDescription.text = productObj.descriptionOfProduct ?? ""
        cell.productPrice.text = productObj.price ?? ""
        
        if(productObj.isSelected == false) {
            cell.selectedImgView.image = UIImage(named: "unselected")
        } else {
            cell.selectedImgView.image = UIImage(named: "selected")
        }
        
        return cell
        
    }
    

    
    //MARK:UITableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var productObj = self.homeModelArray[indexPath.row]
        productObj.isSelected = !productObj.isSelected
        self.homeModelArray[indexPath.row] = productObj
        
        self.productTableView.reloadData()
        
    }
    
    @IBAction func checkoutButtonClicked(_ sender: Any) {
        
        
        
        self.performSegue(withIdentifier: "showCart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCart"{
            let vc = segue.destination as! CartViewController
            vc.homeModelArray = self.homeModelArray
        }
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
