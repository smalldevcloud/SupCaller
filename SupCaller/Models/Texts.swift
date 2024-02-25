//
//  Texts.swift
//  SupCaller
//
//  Created by 8 on 16.12.23.
//

import Foundation

enum Texts {
//    текста совсем мало, оставил так не перенося в localizable
    static var error: String { "Ошибочка!" }
    static var success: String { "Успешно!" }
    
    static var numberAlredyExists: String { "Этот номер уже есть в списке." }
    static var fieldsNotFilled: String { "Оба поля должны быть заполнены." }
    static var sendedSucc: String { "Успешно отправлено!" }
    static var sendedFail: String { "Отправка не удалась." }
    
    static var okButtonText: String { "OK" }
}
