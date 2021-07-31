//
//  OrdersTableViewController.swift
//  HotCoffe
//
//  Created by PrincePhoenix on 31.07.2021.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrders()
    }
    
    private func populateOrders() {
        let urlString = "https://guarded-retreat-82533.herokuapp.com/orders"
        guard let coffeOrdersURL = URL(string: urlString) else {
            fatalError("URL was incorrect")}
        
        let resource = Resource<[Order]>(url: coffeOrdersURL)
        
        Webservice().load(resource: resource) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        cell.textLabel?.text = viewModel.type
        cell.detailTextLabel?.text = viewModel.size
        return cell
    }
}

