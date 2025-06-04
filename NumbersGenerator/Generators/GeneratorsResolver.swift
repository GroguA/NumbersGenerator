//
//  GeneratorsResolver.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 30.05.2025.
//

import Foundation

final class GeneratorsResolver: IGeneratorsResolver {
    private var generators: [NumberType: INumberGenerator] = [:]
    private var currentType: NumberType
    private let visibleCount: Int
    
    init(currentType: NumberType, visibleCount: Int = 30) {
        self.currentType = currentType
        self.visibleCount = visibleCount
        
        for type in NumberType.allCases {
            generators[type] = type.makeGenerator()
        }
    }
    
    func setCurrentType(_ type: NumberType) {
        currentType = type
    }
    
    func getNumbers() -> [Int]? {
        guard let generator = generators[currentType] else { return nil }
        return generator.generateNext(count: visibleCount)
    }
    
    func reset() {
        guard let generator = generators[currentType] else { return }
        generator.reset()
    }
    
    func addGenerator(for type: NumberType, generator: INumberGenerator) {
        generators[type] = generator
    }
}

