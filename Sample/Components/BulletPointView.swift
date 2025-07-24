import SwiftUI

// A reusable view for a single bullet point item
struct BulletPointView: View {
    var text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.body)
                .bold()
            
            Text(text)
                .font(.system(size: 15))
        }
        // Add padding to the entire bullet point row
        .padding(.bottom, 5) // Adjust this value for vertical spacing between items
    }
}
