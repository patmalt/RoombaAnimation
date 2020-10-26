//
//  ContentView.swift
//  Roomba
//
//  Created by Patrick Maltagliati on 10/26/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            LineGrid(percent: viewModel.percent)
                .stroke(lineWidth: 1)
                .foregroundColor(Color.gray)
                .padding()
                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                .mask(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .center))
                .mask(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .center, endPoint: .bottom))
            Circle().fill().frame(width: 100, height: 100).shadow(radius: 1)
        }
        .onAppear {
            viewModel.animate()
        }
    }
}

struct LineGrid: Shape {
    var percent: CGFloat
    
    var animatableData: CGFloat {
        get { percent }
        set { percent = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.closeSubpath()
        
        path.move(to: CGPoint(x: 0, y: percent * rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: percent * rect.maxY))
        
        path.move(to: CGPoint(x: 0, y: percent * rect.maxY - (rect.maxY / 3)))
        path.addLine(to: CGPoint(x: rect.maxX, y: percent * rect.maxY - (rect.maxY / 3)))
        
        path.move(to: CGPoint(x: 0, y: percent * rect.maxY - (2 * rect.maxY / 3)))
        path.addLine(to: CGPoint(x: rect.maxX, y: percent * rect.maxY - (2 * rect.maxY / 3)))
        
        path.move(to: CGPoint(x: 0, y: percent * rect.maxY + (rect.maxY / 3)))
        path.addLine(to: CGPoint(x: rect.maxX, y: percent * rect.maxY + (rect.maxY / 3)))
        
        path.move(to: CGPoint(x: 0, y: percent * rect.maxY + (2 * rect.maxY / 3)))
        path.addLine(to: CGPoint(x: rect.maxX, y: percent * rect.maxY + (2 * rect.maxY / 3)))
        
        return path
    }
}

class ViewModel: ObservableObject {
    @Published var percent: CGFloat = 0
    private var disposeBag = Set<AnyCancellable>()
    
    func animate() {
        percent = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
