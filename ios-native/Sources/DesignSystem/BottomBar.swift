import SwiftUI

/// Custom two-item bottom bar (Nearby / Favorites), standing in for the Flutter
/// `convex_bottom_bar`. The convex/elevated styling is refined in the polish pass (M7);
/// this keeps the interaction and selection persistence in place now.
struct BottomBar: View {
    @Binding var selection: Int

    var body: some View {
        HStack {
            ForEach(MainTab.allCases) { tab in
                Button {
                    selection = tab.rawValue
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 22))
                        Text(tab.title)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(selection == tab.rawValue ? Palette.accent : Palette.primary)
                }
                .accessibilityIdentifier(tab.accessibilityIdentifier)
            }
        }
        .padding(.vertical, 10)
        .background(Palette.bottomBar)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        .padding(.horizontal, 24)
        .padding(.bottom, 8)
    }
}
