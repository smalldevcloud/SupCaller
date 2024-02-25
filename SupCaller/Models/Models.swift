//
//  Models.swift
//  SupCaller
//
//  Created by 8 on 12.12.23.
//

import Foundation
struct Client {
//      модель клиента, которая будет использоваться для
    public let name: String
    public let inputNumber: String
    public let convertedNumber: String
}

extension Client {

    public static func getTestClients() -> [Client] {
//        немножко тестовых записей, чтобы приложение не выглядело пустым при запуске
        let testClients = [
            Client(name: "First Client", inputNumber: "+375251112233", convertedNumber: "**80251112233"),
            Client(name: "Second Client", inputNumber: "+375294445566", convertedNumber: "**80294445566"),
            Client(name: "3rd Client", inputNumber: "+375331111111", convertedNumber: "**80331111111"),
            Client(name: "Just Client", inputNumber: "+375299999999", convertedNumber: "**80299999999"),
            Client(name: "Strange Client", inputNumber: "+375255555555", convertedNumber: "**80255555555"),
            Client(name: "Angry Client", inputNumber: "+375293333333", convertedNumber: "**80293333333"),
            Client(name: "Another Client", inputNumber: "+375294444444", convertedNumber: "**80294444444"),
            Client(name: "Again Client", inputNumber: "+375337777777", convertedNumber: "**802337777777"),
            Client(name: "Big Client", inputNumber: "+375447778899", convertedNumber: "**80447778899")
        ]
        return testClients
    }
}

struct UnknownError: Error, LocalizedError {
    var errorDescription: String = "Неизвестная ошибка"
}

struct TelegramApiResponseModel: Decodable {
//    let result: [String: Any]
    let ok: Bool
}
