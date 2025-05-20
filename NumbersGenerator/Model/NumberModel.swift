//
//  NumberModel.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 18.05.2025.
//

import Foundation

struct NumberModel: Identifiable {
    let id = UUID()
    let value: Int
    let type: NumberType
}
