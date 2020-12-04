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
        else{
            self.move = self.move-UIScreen.main.bounds.width
            self.optionSlide+=1
        }
    }
    func previus() {
        if self.move == UIScreen.main.bounds.width{return}
        else{
            self.move = self.move+UIScreen.main.bounds.width
            self.optionSlide-=1
        }
    }
    var slide1:some View{
        VStack{
            Text("Slide 1")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("\(optionSlide)")
            Text("\(move)")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    var slide2:some View{
        VStack{
            Text("Slide 2")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("\(optionSlide)")
            Text("\(move)")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-140, alignment: .center)
    }
    var slide3:some View{
        VStack{
            Text("Slide 3")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("\(optionSlide)")
            Text("\(move)")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    var indicator1:some View{
        HStack(spacing:0){
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("1"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color.secondary)
                .frame(width: 40, height: 40)
                .overlay(Text("2"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color.secondary)
                .frame(width: 40, height: 40)
                .overlay(Text("3"))
                .foregroundColor(.white)
        }
    }
    var indicator2:some View{
        HStack(spacing:0){
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("1"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color("primary"))
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("2"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color.secondary)
                .frame(width: 40, height: 40)
                .overlay(Text("3"))
                .foregroundColor(.white)
        }
    }
    var indicator3:some View{
        HStack(spacing:0){
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("1"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color("primary"))
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("2"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color("primary"))
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("3"))
                .foregroundColor(.white)
        }
    }
    var buttons1:some View{
        HStack{
            Spacer()
                .frame(maxWidth:150)
                .padding(12)
              
            Text("Avanzar")
                .frame(maxWidth:150)
                .padding(12)
                .foregroundColor(.white)
                .background(Color("primary"))
                .clipShape(Capsule())
                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.next()
                    }
                    
                }
        }
    }
    var buttons2:some View{
        HStack{
            Text("Retroceder")
                .foregroundColor(Color("primary"))
                .padding(12)
                .frame(maxWidth:150)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color("primary"), lineWidth: 1))
                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.previus()
                    }
                }
            Text("Avanzar")
                .frame(maxWidth:150)
                .padding(12)
                .foregroundColor(.white)
                .background(Color("primary"))
                .clipShape(Capsule())
                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.next()
                    }
                }
        }
    }
    var buttons3:some View{
        HStack{
            Text("Retroceder")
                .foregroundColor(Color("primary"))
                .padding(12)
                .frame(maxWidth:150)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color("primary"), lineWidth: 1))

                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.previus()
                    }
                }
            Text("Aceptar")
                .frame(maxWidth:150)
                .padding(12)
                .foregroundColor(.white)
                .background(Color("primary"))
                .clipShape(Capsule())
                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.next()
                    }
                }
        }
    }
    var body: some View {
        VStack{
                if self.optionSlide == 1
                {
                    indicator1
                        .animation(.linear)
                }
                if self.optionSlide == 2
                {
                    indicator2
                        .animation(.linear)
                }
                if self.optionSlide == 3
                {
                    indicator3
                        .animation(.linear)
                }
            HStack(spacing:0){
                slide1
                    .animation(.default)
                slide2
                    .animation(.default)
                slide3
                    .animation(.default)
            }.offset(x: self.move)
            .animation(.linear)
            
            if self.optionSlide == 1
            {
                buttons1
                    .animation(.linear)
            }
            if self.optionSlide == 2
            {
                buttons2
                    .animation(.linear)
            }
            if self.optionSlide == 3
            {
                buttons3
                    .animation(.linear)
            }
            
            
        }
        
    }
}

struct TestWizardView_Previews: PreviewProvider {
    static var previews: some View {
        TestWizardView()  
    }
}
