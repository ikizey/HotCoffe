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
