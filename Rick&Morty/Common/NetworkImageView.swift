//
//  NetworkImageView.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import SwiftUI

//MARK: TODO handle the arge amount of llist

struct NetworkImageView<Placeholder: View>: View {
    let url: URL?
    let contentMode: ContentMode
    let fallbackSystemName: String
    let placeholder: Placeholder
    let animation: Animation?

    init(
        url: String,
        contentMode: ContentMode = .fill,
        fallbackSystemName: String = "person.fill",
        @ViewBuilder placeholder: () -> Placeholder = { Color.gray.opacity(0.1) },
        animation: Animation? = .easeInOut(duration: 0.3)
    ) {
        self.url = URL(string: url)
        self.contentMode = contentMode
        self.fallbackSystemName = fallbackSystemName
        self.placeholder = placeholder()
        self.animation = animation
    }

    init(
        url: URL?,
        contentMode: ContentMode = .fill,
        fallbackSystemName: String = "person.fill",
        @ViewBuilder placeholder: () -> Placeholder = { Color.gray.opacity(0.1) },
        animation: Animation? = .easeInOut(duration: 0.3)
    ) {
        self.url = url
        self.contentMode = contentMode
        self.fallbackSystemName = fallbackSystemName
        self.placeholder = placeholder()
        self.animation = animation
    }

    var body: some View {
        AsyncImage(url: url, transaction: Transaction(animation: animation)) { phase in
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
