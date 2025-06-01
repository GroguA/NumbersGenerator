//
//  NumbersListViewModel.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 18.05.2025.
//

import Foundation

final class NumbersListViewModel: ObservableObject {
    @Published private(set) var numbers: [NumberModel] = []
    @Published var selectedType: NumberType {
        didSet {
            numbersGenerator = NumbersGeneratorFactory.makeResolver(for: selectedType)
            resetAndLoad()
        }
    }
    
    private var isLoading = false
    private var numbersGenerator: IGeneratorsResolver
    private let preloadTriggerCount = 5
    
    init(selectedType: NumberType = .prime) {
        self.selectedType = selectedType
        numbersGenerator = NumbersGeneratorFactory.makeResolver(for: selectedType)
    }
    
    func loadMore() {
        guard !isLoading else { return }
        isLoading = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let items = mapNumbers(numbersGenerator.getNumbers())
            
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
        isLoading = false
        numbers = []
        numbersGenerator.reset()
        loadMore()
    }
    
    func mapNumbers(_ nums: [Int]) -> [NumberModel] {
        return nums.map { NumberModel(value: $0, type: self.selectedType) }
    }
    
}
