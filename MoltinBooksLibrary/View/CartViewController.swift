//
//  CartViewController.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,PmoltenViewCartCallback,UITableViewDelegate,UITableViewDataSource{
    
    var cartModelArray = Array<CartDataModel>()
    var cartViewPresenterObj: CartViewPresenter?
    @IBOutlet weak var cartTableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCartItems()
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
    }
    
    func getCartItems() {
        self.cartViewPresenterObj = CartViewPresenter(pmoltenViewCartCallback:self)
        self.cartViewPresenterObj?.getCartData()
    }
    
    //MARK:-UITableview data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartModelArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! HomeProductTableViewCell
        
        let productObj = self.cartModelArray[indexPath.row]
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
        var productObj = self.cartModelArray[indexPath.row]
        productObj.isSelected = !productObj.isSelected
        self.cartModelArray[indexPath.row] = productObj
        self.cartTableView.reloadData()
    }

    
    //MARK:-implementation callback
    func success(productValue:Array<CartDataModel>) {
        self.cartModelArray = productValue
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
    func showError(message:String){
        
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
