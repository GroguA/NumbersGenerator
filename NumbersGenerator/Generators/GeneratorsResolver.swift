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
    }
    
    func setCurrentType(_ type: NumberType) {
        currentType = type
    }
    
    func createNumberGenerator() -> INumberGenerator {
        let generator = generators[currentType] ?? {
            let newGen = currentType.makeGenerator()
            generators[currentType] = newGen
            return newGen
        }()
        return generator
    }
    
    func getNumbers() -> [Int]? {
        let generator = createNumberGenerator()
        return generator.generateNext(count: visibleCount)
    }
    
    func addGenerator(for type: NumberType, generator: INumberGenerator) {
        generators[type] = generator
    }
}

