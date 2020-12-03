//
//  TestWizardView.swift
//  fastgi
//
//  Created by Amilkar on 12/2/20.
//

import SwiftUI

struct TestWizardView: View {
    var isSelect:Bool? = true
    @State private var move:CGFloat = UIScreen.main.bounds.width
    @State private var optionSlide:Int = 1
    func next() {
        if self.move == (UIScreen.main.bounds.width*(-1)){return}
        else{self.move = self.move-UIScreen.main.bounds.width}
    }
    func previus() {
        if self.move == UIScreen.main.bounds.width{return}
        else{self.move = self.move+UIScreen.main.bounds.width}
    }
    var slide1:some View{
        VStack{
            Text("Slide 1")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("\(move)")
            
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        //.background(Color.green.opacity(0.5))
    }
    var slide2:some View{
        VStack{
            Text("Slide 2")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("\(move)")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-120, alignment: .center)
        //.background(Color.red.opacity(0.5))
    }
    var slide3:some View{
        VStack{
            Text("Slide 3")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("\(move)")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        //.background(Color.blue.opacity(0.5))
    }
    var indicator1:some View{
        HStack(spacing:0){
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("1"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color("primary"))
                .frame(width: 40, height: 5)
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("2"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 40, height: 5)
            Circle()
                .fill(Color.secondary)
                .frame(width: 40, height: 40)
                .overlay(Text("3"))
                .foregroundColor(.white)
        }
    }
    var body: some View {
        VStack{
            indicator1
            
            HStack(spacing:0){
                slide1
                slide2
                slide3
            }.offset(x: self.move)
            .animation(.default)
            HStack{
                Text("Retroceder")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .padding(6)
                    .onTapGesture {
                        withAnimation(Animation.spring()){
                            self.previus()
                        }
                    }
                Text("Avanzar")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .padding(6)
                    .onTapGesture {
                        withAnimation(Animation.spring()){
                            self.next()
                        }
                        
                    }
            }
            //.padding(10)
            
            
        }
        
    }
}

struct TestWizardView_Previews: PreviewProvider {
    static var previews: some View {
        TestWizardView()
    }
}
