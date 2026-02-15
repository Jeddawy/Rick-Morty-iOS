//
//  NetworkImageView.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import SwiftUI

struct NetworkImageView<Placeholder: View>: View {
    let url: URL?
    let contentMode: ContentMode
    let fallbackSystemName: String
    let placeholder: Placeholder

    init(
        url: String,
        contentMode: ContentMode = .fill,
        fallbackSystemName: String = AppImages.personFill,
        @ViewBuilder placeholder: () -> Placeholder = { Color.gray.opacity(0.1) }
    ) {
        self.url = URL(string: url)
        self.contentMode = contentMode
        self.fallbackSystemName = fallbackSystemName
        self.placeholder = placeholder()
    }

    init(
        url: URL?,
        contentMode: ContentMode = .fill,
        fallbackSystemName: String = AppImages.personFill,
        @ViewBuilder placeholder: () -> Placeholder = { Color.gray.opacity(0.1) }
    ) {
        self.url = url
        self.contentMode = contentMode
        self.fallbackSystemName = fallbackSystemName
        self.placeholder = placeholder()
    }

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ZStack { placeholder; ProgressView() }
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .transition(.opacity)
            case .failure:
                ZStack {
                    placeholder
                    Image(systemName: fallbackSystemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .foregroundColor(.gray)
                }
            @unknown default:
                EmptyView()
            }
        }
    }
}
