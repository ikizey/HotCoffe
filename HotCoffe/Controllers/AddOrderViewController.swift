//
//  AddOrderViewController.swift
//  HotCoffe
//
//  Created by PrincePhoenix on 31.07.2021.
//

import UIKit

protocol AddOrderDelegate {
    func addOrderViewControllerDidSave(order: Order, viewController: UIViewController)
    func addOrderViewControllerDidClose(viewController: UIViewController)
}

class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var delegate: AddOrderDelegate?
    
    private var viewModel = AddCofferOrderViewModel()
    private var coffeSizesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        
        self.navigationItem.hidesBackButton = true
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem = closeButton
        
        coffeSizesSegmentedControl = UISegmentedControl(items: viewModel.sizes)
        coffeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        coffeSizesSegmentedControl.selectedSegmentIndex = 0
        view.addSubview(coffeSizesSegmentedControl)
        
        coffeSizesSegmentedControl.topAnchor.constraint(
            equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        
        coffeSizesSegmentedControl.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func close() {
        if let delegate = delegate {
            delegate.addOrderViewControllerDidClose(viewController: self)
        }
    }
    
    
    @IBAction func save() {
        let name = nameTextField.text
        let email = emailTextField.text
        
        let size = coffeSizesSegmentedControl.titleForSegment(
            at: coffeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Error in selecting coffe!")}
        
        viewModel.name = name
        viewModel.email = email
        viewModel.selectedSize = size
        viewModel.selectedType = viewModel.types[indexPath.row]
        
        Webservice().load(resource: Order.create(viewModel: viewModel)) { result in
            switch result {
            case .success(let order):
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addOrderViewControllerDidSave(order: order, viewController: self)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
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
