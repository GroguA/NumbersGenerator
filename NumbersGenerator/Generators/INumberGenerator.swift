//
//  INumberGenerator.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 18.05.2025.
//

import Foundation

protocol INumberGenerator {
    func generateNext(count: Int) -> [Int]
}
