//
//  NumberState.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 18.05.2025.
//

import Foundation

enum NumberType: String, CaseIterable {
    case prime = "Prime"
    case fibonacci = "Fibonacci"
}

extension NumberType {
    func makeGenerator() -> INumberGenerator {
        switch self {
        case .prime:
            return PrimeGenerator()
        case .fibonacci:
            return FibonacciGenerator()
        }
    }
}
