//
//  NumbersListView.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 18.05.2025.
//

import SwiftUI

struct NumbersListView: View {
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @StateObject private var viewModel = NumbersListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Number Type", selection: $viewModel.selectedType) {
                    ForEach(NumberType.allCases, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(Array(viewModel.numbers.enumerated()), id: \.element.id) { index, item in
                                NumberCell(item: item, index: index)
                                    .onAppear {
                                        viewModel.itemAppeared(at: index)
                                    }
                            }
                        }
                        .padding()
                    }
                    .id(viewModel.selectedType)
                    .blur(radius: viewModel.isLoading ? 5 : 0)
                    .disabled(viewModel.isLoading)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .scaleEffect(1.5)
                    }
                }
            }
            .navigationTitle("Numbers")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.numbers.isEmpty {
                    viewModel.loadMore()
                }
            }
        }
    }
}

// MARK: - Preview
struct NumbersListView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersListView()
    }
}
