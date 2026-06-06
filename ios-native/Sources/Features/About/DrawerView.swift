import SwiftUI

/// Side menu, ported from `drawer.dart`: Buses, About, Share.
/// Presented as a sheet for now; refined toward a side drawer in the polish pass (M7).
struct DrawerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showAbout = false

    private let shareURL = URL(string: "https://sglandtransport.app")!

    var body: some View {
        NavigationStack {
            List {
                Label("Buses", systemImage: "bus")
                    .accessibilityIdentifier("drawer.buses")

                Button {
                    showAbout = true
                } label: {
                    Label("About", systemImage: "info.circle")
                }
                .accessibilityIdentifier("drawer.about")

                ShareLink(
                    item: shareURL,
                    message: Text("Check out SG Land Transport here: \(shareURL.absoluteString)")
                ) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .accessibilityIdentifier("drawer.share")
            }
            .navigationTitle("SG Land Transport")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
            .sheet(isPresented: $showAbout) {
                AboutPlaceholderView()
            }
        }
    }
}

/// Placeholder About content (full links/version ported in M6).
private struct AboutPlaceholderView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Text("SG Land Transport")
                    .font(.title2.bold())
                Text("Version \(AppConfig.buildName)")
                    .foregroundStyle(.secondary)
                Text("free | ad-free | open-source")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .accessibilityIdentifier("screen.about")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}
