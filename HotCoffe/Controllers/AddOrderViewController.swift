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
    private var coffeSizesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        coffeSizesSegmentedControl = UISegmentedControl(items: viewModel.sizes)
        coffeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coffeSizesSegmentedControl)
        
        coffeSizesSegmentedControl.topAnchor.constraint(
            equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        
        coffeSizesSegmentedControl.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
    }
}

extension AddOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

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
