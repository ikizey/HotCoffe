//
//  Order.swift
//  HotCoffe
//
//  Created by PrincePhoenix on 01.08.2021.
//

import Foundation

enum CoffeType: String, Codable, CaseIterable {
    
    case cappuccino
    case latte
    case java
    case espresso
    case mocha
    case americano
    case cortado
}

enum CoffeSize: String, Codable, CaseIterable {
    
    case small
    case medium
    case large
}

struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeType
    let size: CoffeSize
}

extension Order {
    
    init?(_ viewModel: AddCofferOrderViewModel) {
        guard let name = viewModel.name,
              let email = viewModel.email,
              let selectedType = CoffeType(
                rawValue: viewModel.selectedType!.lowercased()),
              let seletedSize = CoffeSize(
                rawValue: viewModel.selectedSize!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = seletedSize
    }
}

extension Order {
    
    static var all: Resource<[Order]> = {
        let urlString = "https://guarded-retreat-82533.herokuapp.com/orders"
        guard let url = URL(string: urlString) else {
            fatalError("URL is incorrect!")}
        
        return Resource<[Order]>(url: url)
    }()
    
    static func create(viewModel: AddCofferOrderViewModel) -> Resource<Order?> {
        let order = Order(viewModel)
        let urlString = "https://guarded-retreat-82533.herokuapp.com/orders"
        guard let url = URL(string: urlString) else {
            fatalError("URL is incorrect!")}
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding data!")}
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = .post
        resource.body = data
        
        return resource
    }
}
