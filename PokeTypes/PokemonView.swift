//
//  PokemonView.swift
//  PokeTypes
//
//  Created by Jaume on 25/10/2020.
//

import SwiftUI

struct PokemonView: View {
    
    let name: String
    let color1: Color
    let color2: Color?
    
    var body: some View {
        
        Text(name)
            .foregroundColor(.white)
            .padding(6)
            .background(
                Group {
                    if let color2 = color2 {
                        LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color:  color1, location: 0), Gradient.Stop(color: color2, location: 1)]), startPoint: .top, endPoint: .bottom)
                    } else {
                        RadialGradient(gradient: Gradient(stops: [Gradient.Stop(color:  color1, location: 0), Gradient.Stop(color: color1.opacity(0.5), location: 0.9)]), center: .center, startRadius: 0, endRadius: 100)
                    }
                }
            )
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary, lineWidth: 1)
            )
    }
}

struct PokemonView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            PokemonView(name: "Bulbasaur", color1: Color("\(0)"), color2: Color("\(18)"))
        }
        .font(.custom("PKMN RBYGSC", size: 12, relativeTo: .body))
    }
}
