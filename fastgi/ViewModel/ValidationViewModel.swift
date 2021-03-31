//
//  ValidationViewModel.swift
//  fastgi wallet
//
//  Created by Hegaro on 26/03/2021.
//

import Foundation

class ValidationViewModel : ObservableObject {
    var userDataVM = UserDataViewModel()
    @Published var ci = ""
    @Published var email = ""
    @Published var name = ""
    @Published var apellidos = ""
    @Published var direccion = ""
    @Published var nombrenit = ""
    @Published var nit = ""
    //@Published var password = ""
    //@Published var confirmPw = ""
    
    init(){
        self.userDataVM.DatosUser1()
    }
   
    func isCiValid() -> Bool {
        let ciTest = NSPredicate(format: "SELF MATCHES %@", "/^\\d{5,10}([\\s-]\\d[A-Z])?$/")
        return ciTest.evaluate(with: ci )
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email )
    }
    
    func isNameValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let nameTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9\\s.\\-]+$")
        return nameTest.evaluate(with: name )
    }
    
    func isApellidosValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let apellidosTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9\\s.\\-]+$")
        return apellidosTest.evaluate(with: apellidos )
    }
    
    func isDireccionValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let direccionTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9\\s.\\-]+$")
        return direccionTest.evaluate(with: direccion )
    }
    
    func isNameNitValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let namenitTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9\\s.\\-]+$")
        return namenitTest.evaluate(with: nombrenit )
    }
    
    
    
    var isValidationComplete: Bool {
        if  !isEmailValid() || !isNameValid() || !isApellidosValid() || !isDireccionValid() || !isNameNitValid() {
            return false
        }
        return true
    }
    
    var ciPrompt : String {
        if isCiValid(){
            return ""
        }else {
            return "Ingrese ci valido"
        }
    }
    
    var emailPrompt : String {
        if isEmailValid(){
            return ""
        }else {
            return "Ingrese email valido"
        }
    }
    
    var namePrompt : String {
        if isNameValid(){
            return ""
        }else {
            return "Ingrese nombre"
        }
    }
    
    var apellidosPrompt : String {
        if isApellidosValid(){
            return ""
        }else {
            return "Ingrese apellidos"
        }
    }
    
    var direccionPrompt : String {
        if isDireccionValid(){
            return ""
        }else {
            return "Ingrese direccion"
        }
    }
    
    var nameNitPrompt : String {
        if isNameNitValid(){
            return ""
        }else {
            return "Ingrese nombre del nit"
        }
    }
    
}

/*func passwordsMatch() -> Bool {
    password == confirmPw
}

func isPasswordValid() -> Bool {
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
    return passwordTest.evaluate(with: password )
}*/

/*var confirmPwPrompt : String {
    if passwordsMatch(){
        return ""
    }else {
        return "Las contraseñas no son iguales"
    }
}

var passwordPrompt : String {
    if isPasswordValid(){
        return ""
    }else {
        return "Debe ser entre 8 y 15 caracteres"
    }
}*/
