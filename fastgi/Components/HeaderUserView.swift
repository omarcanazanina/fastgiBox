//
//  HeaderUserView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeaderUserView: View {
    var text: String
    var _id: String
    @State private var action:Int? = 0
    @ObservedObject var userDataVM = UserDataViewModel()
    @State var controlMenu = 1
    //
    //@Binding var selectedMenuItem: MenuItem
  
    
    var imgProfile:some View{
        HStack{
            WebImage(url: URL(string: "https://i.postimg.cc/8kJ4bSVQ/image.jpg" ))
            //WebImage(url: URL(string: "https://api.fastgi.com/avatar/\(_id)" ))
                .placeholder(Image( "user-default"))
                    .resizable()
                    .frame(width:35, height: 35)
                    .clipShape(Circle())
        }
        
    }
    
    var textHeader: some View{
        
        Text(text)
    }
    
    var body: some View {
        VStack(){
            HStack{
                imgProfile
                textHeader
                Text("asdasdasddsf")
                    .foregroundColor(.white)
                
                Button(action: {
                    self.action = 15
                }){
                    Text("55.0 Bs")
                }
                
                NavigationLink(destination: FormLoadBoxView(MontoRecarga1: .Btn30) , tag: 15, selection: self.$action) {
                    EmptyView()
                }
                Spacer()
            }
            
        }
    }
}

/*struct HeaderUserView_Previews: PreviewProvider {
    static var previews: some View {
        //HeaderUserView( text: "user name", _id: "")
        HeaderUserView( text: "user name", _id: "", selectedMenuItem: .constant(.TEST))
    }
}*/
