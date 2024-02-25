//
//  TelegramSender.swift
//  SupCaller
//
//  Created by 8 on 18.02.24.
//

import Foundation
final class TelegramSender {
//    занимается отправкой списка клиентов в телеграм 
    let telegramBotId = "1697241527"
    let telegramBotApiKey = "AAH2h-935T9N3MGjLEMKOPtffcuIgT1pu5M"
    let telegramChatId = "apptest111"

    func send(arrOfClients: [Client], onResult: @escaping (Result<Void, Error>) -> Void) {
//        отправление списка в группу в телеграмме чеерз бота
        var stringToSending = String()

        for client in arrOfClients {
            stringToSending = "\(stringToSending)\n\((client.name))  \(client.inputNumber)"
        }
        let requestUrlString = "https://api.telegram.org/bot\(telegramBotId):\(telegramBotApiKey)/sendMessage?chat_id=@\(telegramChatId)&text=\(stringToSending)"

        let url = URL(string: requestUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    onResult(.failure(error))
                }
                return
            }
            guard let data else {
                DispatchQueue.main.async {
                    onResult(.failure(UnknownError()))
                }
                return
            }

            do {
                let responseJSON = try JSONDecoder().decode(TelegramApiResponseModel.self, from: data)
                if responseJSON.ok {
                    DispatchQueue.main.async {
                        onResult(.success(()))
                    }
                } else {
                    DispatchQueue.main.async {
                        onResult(.failure(UnknownError()))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    onResult(.failure(error))
                }
            }
        }
        task.resume()
    }
}
