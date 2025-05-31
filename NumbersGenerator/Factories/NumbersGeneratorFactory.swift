//
//  NumbersGeneratorFactory.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 31.05.2025.
//

import Foundation

enum NumbersGeneratorFactory {
    static func makeResolver(for type: NumberType) -> IGeneratorsResolver {
        switch type {
        case .prime:
            return GeneratorsResolver(generator: PrimeGenerator())
        case .fibonacci:
            return GeneratorsResolver(generator: FibonacciGenerator())
        }
    }
}
