//
//  FibonacciGenerator.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 20.05.2025.
//

import Foundation

final class FibonacciGenerator: INumberGenerator {
    private var pair: (Int, Int) = (0, 1)
    private(set) var isExhausted = false
    
    func generateNext(count: Int) -> [Int] {
        var result = [Int]()
        result.reserveCapacity(count)
        for _ in 0..<count {
            let (sum, overflow) = pair.0.addingReportingOverflow(pair.1)
            if overflow {
                isExhausted = true
                break
            }
            pair = (pair.1, sum)
            result.append(pair.0)
        }
        return result
    }
    
    
    func reset() {
        pair = (0, 1)
        isExhausted = false
    }
}
