//
//  Custom2View.swift
//  AppTemplate
//
//  Created by Bogdan Ionescu on 12.04.2023.
//

import SwiftUI

struct Custom2View: View {
    
    @ObservedObject var viewModel: Custom2ViewModel
    var continueCallback: (() -> Void)?

    var myGradient = Gradient(
        colors: [
            Color("Primary"),
            Color("Secondary")
        ]
    )
    
    var body: some View {
        VStack(spacing: 32) {
            VStack {
                Text("Hello, \(viewModel.userApplication?.firstname ?? "Stranger")!")
                    .font(.system(size: 24))
            }
            .padding(40)
            .background(RoundedRectangle(cornerRadius: 16)
                .stroke(
                    RadialGradient(
                        gradient: myGradient,
                        center: UnitPoint(x: 0, y: 0),
                        startRadius: 270,
                        endRadius: 0
                    ),
                    lineWidth: 20
                ))
            .padding(40)
            .background(RoundedRectangle(cornerRadius: 16)
                .stroke(
                    RadialGradient(
                        gradient: myGradient,
                        center: UnitPoint(x: 0, y: 0),
                        startRadius: 0,
                        endRadius: 270
                    ),
                    lineWidth: 20
            ))
            
            Button {
                self.continueCallback?()
            } label: {
                Text("Continue")
                    .padding(16)
                    .border(Color("Primary"))
            }
            
        }
    }
}

struct Custom2View_Previews: PreviewProvider {
    static var previews: some View {
        Custom2View(viewModel: Custom2ViewModel())
    }
}
