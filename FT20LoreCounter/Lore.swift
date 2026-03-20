import SwiftUI

struct LoreCounter: View {
    @Binding var lore: Int
    var isRotated: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 40) {
                // Decrease Lore
                Button(action: { lore -= 1 }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 45))
                    Image(systemName: "minus")
                        .font(.system(size: 40))
                        
                }
                .disabled(lore <= 0)
                
                // Lore Display
                Text("\(lore)")
                    .font(.system(size: 100, weight: .black, design: .serif))
                    // Turns Gold/Yellow when they hit the winning 20 Lore
                    .foregroundStyle(lore >= 20 ? Color.yellow : Color.white)
                    .shadow(color: lore >= 20 ? .yellow.opacity(0.7) : .clear, radius: 10)
                
                // Increase Lore
                Button(action: { lore += 1 }) {
                    Image(systemName: "plus")
                        .font(.system(size: 40))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 45))
                }
                .disabled(lore >= 20)
            }
            .foregroundStyle(.yellow)
        }
        .rotationEffect(.degrees(isRotated ? 180 : 0))
    }
}

struct ContentView: View {
    @State private var player1Lore: Int = 0
    @State private var player2Lore: Int = 0

    var body: some View {
        ZStack {
            // Background Image
            Image("FT20.1")
                .resizable()
                .scaledToFill()
                .rotationEffect(.degrees(90))
                .ignoresSafeArea()
                

            VStack {
                // Opponent
                LoreCounter(lore: $player2Lore, isRotated: true)
                
                Spacer()
                
                
                Button(action: {
                    player1Lore = 0
                    player2Lore = 0
                }) {
                    Text("New Chapter")
                        .font(.largeTitle)
                        .foregroundStyle(.yellow.opacity(0.8))
                        .foregroundStyle(Color.yellow)
                        .rotationEffect(Angle(degrees: 1891))
                        .padding(.trailing, 200)
//                    Image(systemName: "arrow.counterclockwise.circle.fill")
//                        .font(.largeTitle)
//                        .foregroundStyle(.white.opacity(0.6))
                }
                
                Spacer()
                
                // Local Player
                LoreCounter(lore: $player1Lore)
            }
            .padding(.vertical, 60)
        }
    }
}
#Preview {
    ContentView()
}
