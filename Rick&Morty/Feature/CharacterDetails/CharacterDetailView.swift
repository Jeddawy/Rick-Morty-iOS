//
//  CharacterDetailView.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterEntity
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                    NetworkImageView(url: character.imageUrl)
                .frame(height: 350)
                
                // Content
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    Divider()
                    infoSection
                    Divider()
                    locationSection
                    
                    Spacer(minLength: 50)
                }
                .padding()
                .background(Color.systemBackground)
                .cornerRadius(20)
                .offset(y: -30) // Overlap slightly
            }
        }
        .edgesIgnoringSafeArea(.top)
    }

    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(character.species) • \(character.gender)")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            StatusBadge(status: character.status)
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Information")
                .font(.title3)
                .fontWeight(.semibold)
            
            InfoRow(icon: "heart.fill", label: "Status", value: character.status.rawValue)
            InfoRow(icon: "person.fill", label: "Species", value: character.species)
            InfoRow(icon: "figure.stand", label: "Gender", value: character.gender)
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Location")
                .font(.title3)
                .fontWeight(.semibold)
            
            InfoRow(icon: "map.fill", label: "Last known", value: character.location.name)
        }
    }
}

struct StatusBadge: View {
    let status: CharacterStatus
    
    var body: some View {
        Text(status.rawValue)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(statusColor.opacity(0.1))
            .foregroundColor(statusColor)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(statusColor, lineWidth: 1)
            )
    }
    
    private var statusColor: Color {
        switch status {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundColor(.blue)
            
            Text(label)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .fontWeight(.medium)
        }
    }
}

// Helper for background color
extension Color {
    static let systemBackground = Color(uiColor: .systemBackground)
}

// Use MockData for Preview
#Preview {
    CharacterDetailView(character: MockData.rick)
}
