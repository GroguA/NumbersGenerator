//
//  IGeneratorsResolver.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 30.05.2025.
//

import Foundation

protocol IGeneratorsResolver {
    func getNumbers() -> [Int]
    func reset()
}
