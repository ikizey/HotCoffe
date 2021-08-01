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
        Webservice().load(resource: Order.all) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addOrderController = segue.destination as? AddOrderViewController else {
            fatalError("Error preparing segue!")}
        
        addOrderController.delegate = self
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

extension OrdersTableViewController: AddOrderDelegate {
    
    func addOrderViewControllerDidSave(order: Order, viewController: UIViewController) {
        navigationController?.popViewController(animated: true)
        
        let orderViewModel = OrderViewModel(order: order)
        orderListViewModel.ordersViewModel.append(orderViewModel)
        tableView.insertRows(at: [IndexPath(row: orderListViewModel.ordersViewModel.count - 1, section: 0)],
                             with: .automatic)
    }
    
    func addOrderViewControllerDidClose(viewController: UIViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
