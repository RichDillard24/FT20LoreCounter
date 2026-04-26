
import SwiftUI

//  best of 3 tracker
struct DiamondTracker: View {
    @Binding var wins: Int
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(1...2, id: \.self) { index in
                Image(systemName: index <= wins ? "diamond.fill" : "diamond")
                    .font(.system(size: 25))
                    .foregroundStyle(wins >= 2 ? Color.yellow : Color.white)
                    .shadow(color: wins >= 2 ? .yellow.opacity(0.7) : .clear, radius: 10)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            if wins == index {
                                wins = index - 1
                            } else {
                                wins = index
                            }
                        }
                    }
            }
        }
        .padding(.bottom, 1)
    }
}

//  LoreCounter
struct LoreCounter: View {
    @Binding var lore: Int
    @Binding var wins: Int
    var isRotated: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            
            DiamondTracker(wins: $wins)
            
            HStack(spacing: 40) {
                // Decrease Lore
                Button(action: { lore -= 1 }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 45))
                    Image(systemName: "minus")
                        .font(.system(size: 40))
                        //.padding(-10)
                }
                .disabled(lore <= 0)
                
                // Lore Display
                Text("\(lore)")
                    .font(.system(size: 100, weight: .black, design: .serif))
                    .foregroundStyle(lore >= 20 ? Color.yellow : Color.white)
                    .shadow(color: lore >= 20 ? .yellow.opacity(0.7) : .clear, radius: 10)
                    
                
                // Increase Lore
                Button(action: { lore += 1 }) {
                    Image(systemName: "plus")
                        .font(.system(size: 40))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 45))
                            //.padding(-10)
                        
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
    
    // Win Tracker
    @State private var player1Wins: Int = 0
    @State private var player2Wins: Int = 0

    var body: some View {
        ZStack {
            // Background Image
            
            Image("FT20.1")
                .resizable()
                .scaledToFill()
                .rotationEffect(.degrees(90))
                .ignoresSafeArea()
                .padding(.trailing, 200)
            
            VStack {
                // (Player 2)
                LoreCounter(lore: $player2Lore, wins: $player2Wins, isRotated: true)
                    .padding(-65)
                
                Spacer()
                
                // Reset Button
                Button(action: {
                    if player1Wins < 2 && player2Wins < 2 {
                        // reset lores
                        withAnimation {
                            player1Lore = 0
                            player2Lore = 0
                        }
                    }
                    else {
                        // reset everything
                        withAnimation {
                            player1Lore = 0
                            player2Lore = 0
                            player1Wins = 0
                            player2Wins = 0
                        }
                    }
                }) {
                    Text(" New Chapter! ")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .background(.yellow.opacity(0.5))
                        .border(Color.yellow, width:4)
                        .cornerRadius(10)
                        .rotationEffect(Angle(degrees: 90))
                        .shadow(color: player1Lore >= 20 ? .yellow.opacity(0.7) : .clear, radius: 10)
                        .shadow(color: player2Lore >= 20 ? .yellow.opacity(0.7) : .clear, radius: 10)
                        .shadow(color: player1Wins >= 2 ? .yellow.opacity(0.7) : .clear, radius: 10)
                        .shadow(color: player2Wins >= 2 ? .yellow.opacity(0.7) : .clear, radius: 10)
                        .padding(.trailing, 275)
                }
                Spacer()
                
                //  (Player 1)
                LoreCounter(lore: $player1Lore, wins: $player1Wins)
                    .padding(-65)
            }
            .padding(.vertical, 60)
        }
    }
}

#Preview {
    ContentView()
}
