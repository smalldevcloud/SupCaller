//
//  ViewController.swift
//  SupCaller
//
//  Created by 8 on 18.02.24.
//

import UIKit

class ViewController: UIViewController {
    private var clients = Client.getTestClients()
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var clientNameTF: UITextField!
    @IBOutlet weak var clientNumberTF: UITextField!
    
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var addButton: UIButton!

    @IBAction func clearButtonTapped(_ sender: Any) {
        //      нажата кнопка очищения списка
                clear()
    }

    @IBAction func sendButtonTapped(_ sender: Any) {
        //        нажата кнопка отправки списка в телеграм
                send()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        //        нажата кнопка добавления клиента
                save()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        если буфер содержит текст - сразу вставлят в поле отвечающее за номер клиента
        if let pasteboardString = UIPasteboard.general.string {
            clientNumberTF.text = pasteboardString
        }
    }
    
    func setupUI() {
        self.view.backgroundColor = .backgroundViewColor
        let buttons = [addButton, sendButton, clearButton]
        for btn in buttons {
            btn?.tintColor = .black
            btn?.backgroundColor = .gray
            btn?.layer.cornerRadius = 16
            btn?.layer.cornerCurve = .continuous
        }
        
        let fields = [clientNameTF, clientNumberTF]
        for fld in fields {
            fld?.backgroundColor = .lightGray
            fld?.textColor = .black
        }
        clientNameTF?.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        clientNumberTF?.attributedPlaceholder = NSAttributedString(string: "Number", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        tableView.backgroundColor = .backgroundViewColor
        tableView.layer.cornerRadius = 24
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.layer.cornerCurve = .continuous
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
//
    func save() {
        
        let client = Client(
            name: clientNameTF.text ?? "",
            inputNumber: clientNumberTF.text ?? "",
            convertedNumber: clientNumberTF.text ?? ""
        )
        
        //        проверка на пустые поля
        guard !client.name.isEmpty || !client.inputNumber.isEmpty else {
            showAlert(alrtTitle: Texts.error, msg: Texts.fieldsNotFilled)
            return
        }
        
        // Если такой номер уже имеется - сообщение пользователю, если нет - добавление в массив
        if checkNumberInArr(num: client.inputNumber) {
            showAlert(alrtTitle: Texts.error, msg: Texts.numberAlredyExists)
        } else {
            convertAndAdd(client: client)
            tableView.reloadData()
        }
    }
    
    func clear() {
        //        удаляет все записи в массиве клиентов
        clients.removeAll()
        tableView.reloadData()
    }
    
    func send() {
        sendButton.isEnabled = false
        
        let sender = TelegramSender()
        
        sender.send(arrOfClients: clients, onResult: { result in
            switch result {
            case .success:
                self.showAlert(alrtTitle: Texts.success, msg: Texts.sendedSucc)
            case .failure(let error):
                self.showAlert(alrtTitle: Texts.error, msg: error.localizedDescription)
            }
            self.sendButton.isEnabled = true
        })

    }
    
    func showAlert(alrtTitle: String, msg: String) {
        //        чтобы не делать на каждую ошибку свой алёрт - алёрт всегда один, только текст ошибки разный, передаётся в аргументе вызова функции
        let alert = UIAlertController(title: alrtTitle, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Texts.okButtonText, style: .default))
        self.present(alert, animated: true)
    }
    
    private func checkNumberInArr(num: String) -> Bool {
        //        проверяет наличие номера в модели. если есть - true, если нет - false
        var inArray = false
        for client in clients {
            
            if client.inputNumber == num {
                inArray = true
                break
            }
        }
        return inArray
    }
    
    private func convertAndAdd(client: Client) {
        //        функция, ради которой и создавалось приложение. Собственно, было бы достаточно только этой функции
        //        ниже перечислены символы, которые будут вырезаны из строки, если будут там обнаружены
        let unsafeChars = CharacterSet.alphanumerics.inverted
        let lowLetters = CharacterSet.lowercaseLetters
        let uppLetters = CharacterSet.uppercaseLetters
        
        let cleanChars  = client.inputNumber.components(separatedBy: unsafeChars).joined(separator: "")
        let cleanLowLett = cleanChars.components(separatedBy: lowLetters).joined(separator: "")
        let cleanUppLett = cleanLowLett.components(separatedBy: uppLetters).joined(separator: "")

        let numberPrefixes = ["375", "80"]
        for prefix in numberPrefixes {
            guard cleanUppLett.hasPrefix(prefix) else { continue }
            let dropFirst = String(cleanUppLett.dropFirst(prefix.count))
            let result = "**80\(dropFirst)"
            
            let tempClient = Client(name: client.name, inputNumber: client.inputNumber, convertedNumber: result)
            //        клиент с изменённым номером добавляется в массив
            clients.append(tempClient)
            //        после добавления - очищение полей ввода
            clientNameTF.text = ""
            clientNumberTF.text = ""
            return
        }
    }
    
    private func callNumber(phoneNumber: String) {
        UIApplication.shared.open(NSURL(string: "tel://\(phoneNumber)")! as URL)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        регистрация nib'a ячейки для таблицы
        let nib = UINib(nibName: "ClientTVCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "clientsTVCell")
        
        let client = clients[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ClientTVCell.identifier, for: indexPath) as! ClientTVCell
        
        cell.clientName.text = client.name
        cell.clientNumber.text = client.inputNumber
        
        cell.callButtonHandler = { [weak self] in
            //            замыкание, вызываемое нажатием кнопки в таблице. Позволяет набрать номер
            UIPasteboard.general.string = client.inputNumber
            self?.callNumber(phoneNumber: client.convertedNumber)
            
        }
        
        cell.backgroundColor = .systemFill
        return cell
    }
}
