//
//  IGeneratorsResolver.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 30.05.2025.
//

import Foundation

protocol IGeneratorsResolver {
    func createNumberGenerator() -> INumberGenerator
    func getNumbers() -> [Int]?
    func setCurrentType(_ type: NumberType)
    func addGenerator(for type: NumberType, generator: INumberGenerator)
}
