//
//  WelcomeTermsAndConditionsView.swift
//  fastgi
//
//  Created by Hegaro on 12/11/2020.
//

import SwiftUI


struct WelcomeTermsAndConditionsView: View {
    
    var navRoot = NavigationRoot()
    @State private var animationScale: CGFloat = 0

    @State var scale: CGFloat = 1
    
    @State private var overText = false
    
    private let storage = UserDefaults.standard
    var body: some View {
        VStack(spacing:30){
            Image("logo_fastgi")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .opacity(Double(animationScale))
                .scaleEffect(animationScale)
                .animation(Animation.easeInOut(duration: 1).delay(0.2))
                //AutoStart Animation
                .onAppear { self.animationScale = 1 }
            
            Text("Te damos la bienvenida a Fastgi")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text("Una forma rápida y segura para hacer tus pagos.")
                .multilineTextAlignment(.center)
            VStack{
                Text("Pulsa en \"Aceptar y continuar\" para aceptar")
                HStack{
                    Text("las")
                    Link("Condiciones del servicio",
                          destination: URL(string: "https://www.fastgi.com")!)
                        .foregroundColor(Color("primary"))
                    Text("de Fastgi.")
                }
            }
             .padding(.top,30)
            Button(action: {
                print("Aceptar")
                self.storage.set("1", forKey: "termsAndConditions")
                self.navRoot.changeRootClose()
            }){
                Text("Aceptar y continuar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
            }
            
        }.padding(10)
        .animation(.default)
    }
}

struct WelcomeTermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTermsAndConditionsView()
    }
}
