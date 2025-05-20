//
//  PrimeGenerator.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 18.05.2025.
//

import Foundation

final class PrimeGenerator: INumberGenerator {
    private var generatedNumbers = [1]
    
    func generateNext(count: Int) -> [Int] {
        var newNumbers = [Int]()
        newNumbers.reserveCapacity(count)
        var nextNumber = generatedNumbers.last! + 1
        
        while newNumbers.count < count {
            if isPrime(nextNumber) {
                generatedNumbers.append(nextNumber)
                newNumbers.append(nextNumber)
            }
            nextNumber += 1
        }
        
        return newNumbers
    }
    
    func isPrime(_ n: Int) -> Bool {
        guard n >= 2 else { return false }
        if n <= 3 { return true }
        let maxDivisor = Int(sqrt(Double(n)))
        guard maxDivisor >= 2 else { return false }
        
        return !(2...maxDivisor).contains { n % $0 == 0 }
    }
    
    
    func reset() {
        generatedNumbers = [1]
    }
}
