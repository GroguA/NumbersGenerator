//
//  IGeneratorsResolver.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 30.05.2025.
//

import Foundation

protocol IGeneratorsResolver {
    func getNumbers() -> [Int]?
    func setCurrentType(_ type: NumberType)
    func reset()
    func addGenerator(for type: NumberType, generator: INumberGenerator)
}
