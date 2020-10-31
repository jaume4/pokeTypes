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
            .foregroundColor(selected ?  Color(UIColor.systemBackground) : .white)
            .padding(6)
            .background(
                Group {
                    if selected {
                        Color(UIColor.label)
                        
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

struct CapsuleModifier_Previews: PreviewProvider {
    
    static let range: Range<Int16> = 0..<19
    
    static var previews: some View {
        Group {
            ScrollView {
                ForEach(range) { colorIndex in
                    VStack {
                        HStack {
                            Text("Label")
                                .modifier(CapsuleModifier(selected: false, id: colorIndex))
                            Text("Label")
                                .modifier(CapsuleModifier(selected: true, id: colorIndex))
                        }
                    }
                }
            }
            ScrollView {
                ForEach(range) { colorIndex in
                    VStack {
                        HStack {
                            Text("Label")
                                .modifier(CapsuleModifier(selected: false, id: colorIndex))
                            Text("Label")
                                .modifier(CapsuleModifier(selected: true, id: colorIndex))
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
        .font(.custom("PKMN RBYGSC", size: 12, relativeTo: .body))
    }
}

extension Int16: Identifiable {
    public var id: Int16 {
        self
    }
}
