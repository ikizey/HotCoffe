//
//  OrdersTableViewController.swift
//  HotCoffe
//
//  Created by PrincePhoenix on 31.07.2021.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrders()
    }
    
    private func populateOrders() {
        let urlString = "https://guarded-retreat-82533.herokuapp.com/orders"
        guard let coffeOrdersURL = URL(string: urlString) else {
            fatalError("URL was incorrect")}
        
        let resource = Resource<[Order]>(url: coffeOrdersURL)
        
        Webservice().load(resource: resource) { result in
            switch result {
            case .success(let orders):
                print(orders)
            case .failure(let error):
                print(error)
            }
        }
    }
}

