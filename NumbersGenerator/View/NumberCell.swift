//
//  NumberCell.swift
//  NumbersGenerator
//
//  Created by Александра Сергеева on 20.05.2025.
//

import SwiftUI

struct NumberCell: View {
    let item: NumberModel
    let index: Int
    
    var body: some View {
        VStack {
            Text("\(item.value)")
                .font(.system(.title3, design: .default))
                .bold()
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .truncationMode(.middle)
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .cornerRadius(8)
    }
    
}

private extension NumberCell {
    var backgroundColor: Color {
        let row = index / 2
        let column = index % 2
        return (row + column) % 2 == 0 ? Color(.systemGray6) : Color(.systemBackground)
    }
}
