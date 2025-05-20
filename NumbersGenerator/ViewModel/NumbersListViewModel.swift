//
//  NumbersListViewModel.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 18.05.2025.
//

import Foundation

final class NumbersListViewModel: ObservableObject {
    @Published private(set) var numbers: [NumberModel] = []
    @Published var selectedType: NumberType = .prime {
        didSet {
            resetAndLoad()
        }
    }
    
    private var isLoading = false
    
    private let primeGenerator = PrimeGenerator()
    private let fibonacciGenerator = FibonacciGenerator()
    private let visibleCount = 30
    private let preloadTriggerCount = 5
    
    func loadMore() {
        if selectedType == .fibonacci && fibonacciGenerator.isExhausted {
            return
        }
        
        guard !isLoading else { return }
        isLoading = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let items = getNumbers()
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.numbers += items
                self.isLoading = false
            }
        }
    }
    
    func itemAppeared(at index: Int) {
        let triggerIndex = max(numbers.count - preloadTriggerCount, 0)
        if index >= triggerIndex && !isLoading {
            loadMore()
        }
    }
}

private extension NumbersListViewModel {
    func resetAndLoad() {
        numbers = []
        isLoading = false
        fibonacciGenerator.reset()
        primeGenerator.reset()
        loadMore()
    }
    
    func getNumbers() -> [NumberModel] {
        let newNumbers: [Int] = {
            switch self.selectedType {
            case .prime:
                return self.primeGenerator.generateNext(count: self.visibleCount)
            case .fibonacci:
                return self.fibonacciGenerator.generateNext(count: self.visibleCount)
            }
        }()
        
        return mapNumbers(newNumbers)
    }
    
    func mapNumbers(_ nums: [Int]) -> [NumberModel] {
        return nums.map { NumberModel(value: $0, type: self.selectedType) }
    }
}
