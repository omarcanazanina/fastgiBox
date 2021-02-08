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
