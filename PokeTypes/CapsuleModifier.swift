//
//  CapsuleModifier.swift
//  PokeTypes
//
//  Created by Jaume on 25/10/2020.
//

import Foundation
import SwiftUI

struct CapsuleModifier: ViewModifier {
    
    let selected: Bool
    let id: Int16
    
    func body(content: Content) -> some View {
        content
            .font(.custom("PKMN RBYGSC", size: 14, relativeTo: .body))
            .padding(6)
            .background(
                Group {
                    if selected {
                        Color.black
                    } else {
                        RadialGradient(gradient: Gradient(stops: [Gradient.Stop(color:  Color("\(id)"), location: 0), Gradient.Stop(color: Color("\(id)").opacity(0.5), location: 0.9)]), center: .center, startRadius: 0, endRadius: 100)
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
