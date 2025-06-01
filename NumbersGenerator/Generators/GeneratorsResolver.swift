//
//  GeneratorsResolver.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 30.05.2025.
//

import Foundation

final class GeneratorsResolver: IGeneratorsResolver {
    private let generator: INumberGenerator
    private let visibleCount = 30

    init(generator: INumberGenerator) {
        self.generator = generator
    }

    func getNumbers() -> [Int] {
        generator.generateNext(count: visibleCount)
    }

    func reset() {
        generator.reset()
    }
    
}
