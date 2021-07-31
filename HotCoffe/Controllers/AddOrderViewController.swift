//
//  AddOrderViewController.swift
//  HotCoffe
//
//  Created by PrincePhoenix on 31.07.2021.
//

import UIKit

class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = AddCofferOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AddOrderViewController: UITableViewDelegate {}

extension AddOrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.types[indexPath.row]
        return cell
    }
    
    
}
