import SwiftUI

/// The home shell: a scrolling header + the active tab's content, a custom bottom bar,
/// a drawer, and a search entry point. Mirrors `dashboard_screen.dart`.
///
/// This is the M1 skeleton — feature content (nearby list, favorites, search, arrivals)
/// is added in later milestones. Layout/chrome is in place so each feature drops in.
struct RootView: View {
    @AppStorage("bottomBarIndex") private var selectedTabRaw = MainTab.nearby.rawValue
    @State private var showDrawer = false
    @State private var showSearch = false

    private var selectedTab: MainTab {
        MainTab(rawValue: selectedTabRaw) ?? .nearby
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Palette.background.ignoresSafeArea()

                ScrollView {
                    HomeHeader()
                    content
                        .padding(.horizontal, 16)
                        .padding(.bottom, 96) // clear the floating bottom bar
                }

                BottomBar(selection: $selectedTabRaw)
            }
            .navigationTitle("SG Land Transport")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Palette.primary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showDrawer = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                    .accessibilityIdentifier("nav.drawer")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSearch = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .accessibilityIdentifier("nav.search")
                }
            }
            .sheet(isPresented: $showDrawer) {
                DrawerView()
            }
            .sheet(isPresented: $showSearch) {
                SearchPlaceholderView()
            }
        }
        .tint(.white)
    }

    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case .nearby:
            NearbyPlaceholderView()
        case .favorites:
            FavoritesPlaceholderView()
        }
    }
}

/// Scrolling header area that will host the native hero animation (M7). For now a branded band.
private struct HomeHeader: View {
    var body: some View {
        Palette.primary
            .frame(height: 180)
            .overlay(alignment: .bottomLeading) {
                Image(systemName: "bus.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(.white.opacity(0.25))
                    .padding(20)
            }
    }
}

// MARK: - Placeholder feature surfaces (replaced in M5/M6)

private struct NearbyPlaceholderView: View {
    var body: some View {
        PlaceholderScreen(
            identifier: "screen.nearby",
            systemImage: "location",
            title: "Nearby Stops",
            message: "Nearby bus stops will appear here."
        )
    }
}

private struct FavoritesPlaceholderView: View {
    var body: some View {
        PlaceholderScreen(
            identifier: "screen.favorites",
            systemImage: "heart",
            title: "Favorite Buses",
            message: "Tap the favorites icon on any bus arrival to add a bus to your favorites"
        )
    }
}

/// Simple identified placeholder used during the skeleton phase. The identifier is on a
/// concrete `Text` so XCUITest can reliably query it.
private struct PlaceholderScreen: View {
    let identifier: String
    let systemImage: String
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 44))
                .foregroundStyle(Palette.secondary)
            Text(title)
                .font(.headline)
                .accessibilityIdentifier(identifier)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 60)
        .frame(maxWidth: .infinity)
    }
}

private struct SearchPlaceholderView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 44))
                    .foregroundStyle(Palette.secondary)
                Text("Search for bus stops")
                    .font(.headline)
                    .accessibilityIdentifier("screen.search")
            }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") { dismiss() }
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
