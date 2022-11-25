//
//  Sheet.swift
//  ScrolingPagesTest
//
//  Created by Mac on 27.10.2022.
//

import SwiftUI

struct Sheet: View {
    var body: some View {
        ZStack{
            Color("BtoR")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                    .frame(height: 50)
                Text("Instructions")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                    .frame(height: 20)
                Text("Real instructions must be here, but i know that you can figure it out yourself. I add this sheet just for having a sheet in app 😉🤓")
                    .padding()
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
}

struct Sheet_Previews: PreviewProvider {
    static var previews: some View {
        Sheet()
    }
}
