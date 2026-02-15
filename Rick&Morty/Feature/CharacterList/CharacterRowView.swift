//
//  CharacterRowView.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//


import SwiftUI

struct CharacterRowView: View {
    let character: CharacterEntity
    
    var body: some View {
        HStack {
            NetworkImageView(url: character.imageUrl)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
