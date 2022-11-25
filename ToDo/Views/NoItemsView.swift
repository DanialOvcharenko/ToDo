//
//  NoItemsView.swift
//  ScrolingPagesTest
//
//  Created by Mac on 27.10.2022.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list!")
                    .padding(.bottom, 20)
                NavigationLink(
                    destination: AddView(),
                    label: {
                        Text("ADD TASKS 🤟💪")
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.black)
                            .background(animate ? Color("RtoO") : Color.accentColor)
                            .cornerRadius(10)
                    })
                    .padding(.horizontal, animate ? 25 : 50)
                    .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -5 : 5)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(
                Animation
                    .easeInOut(duration: 3.0)
                    .repeatForever()
                ) {
                animate.toggle()
            }
        }
    }
    
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("Title")
        }
    }
}
