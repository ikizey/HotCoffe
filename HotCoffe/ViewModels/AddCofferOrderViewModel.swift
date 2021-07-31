//
//  AddCofferOrderViewModel.swift
//  HotCoffe
//
//  Created by PrincePhoenix on 01.08.2021.
//

import Foundation

struct AddCofferOrderViewModel {
    
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        CoffeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        CoffeSize.allCases.map { $0.rawValue.capitalized }
    }
}
