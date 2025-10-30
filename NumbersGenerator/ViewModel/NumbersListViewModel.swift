//
//  NumbersListViewModel.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 18.05.2025.
//

import Foundation

final class NumbersListViewModel: ObservableObject {
    @Published private(set) var numbers: [NumberModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published var selectedType: NumberType {
        didSet {
            generatorsResolver.setCurrentType(selectedType)
            
            if let cached = cachedNumbers[selectedType] {
                numbers = cached
            } else {
                numbers.removeAll()
                loadMore()
            }
        }
    }
    
    private var cachedNumbers: [NumberType: [NumberModel]] = [:]
    
    private let generatorsResolver: IGeneratorsResolver
    private let preloadTriggerCount = 5
    
    init(selectedType: NumberType = .prime, generatorsResolver: IGeneratorsResolver? = nil) {
        self.selectedType = selectedType
        
        if let resolver = generatorsResolver {
            self.generatorsResolver = resolver
        } else {
            self.generatorsResolver = GeneratorsResolver(currentType: selectedType)
        }
        self.generatorsResolver.setCurrentType(selectedType)
    }
    
    func loadMore() {
        guard !isLoading else { return }
        isLoading = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self, let items = generatorsResolver.getNumbers() else { return }
            let mappedNumbers = mapNumbers(items)
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.numbers += mappedNumbers
                self.cachedNumbers[selectedType] = numbers
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
    func mapNumbers(_ nums: [Int]) -> [NumberModel] {
        return nums.map { NumberModel(value: $0, type: self.selectedType) }
    }
    
}
