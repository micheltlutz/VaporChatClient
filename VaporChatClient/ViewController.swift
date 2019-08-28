//
//  ViewController.swift
//  VaporChatClient
//
//  Created by Michel Anderson Lutz Teixeira on 27/08/19.
//  Copyright © 2019 Michel Lutz. All rights reserved.
//

import UIKit

let host = "192.168.1.140:8080"

class ViewController: UIViewController {

    var socket: WebSocket?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSocket()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket?.close()
    }
    
    func startSocket() {
        //        socket = WebSocket("ws://\(host)/echo-test")
        socket = WebSocket("ws://\(host)/chat")
        
        socket?.event.close = { [weak self] code, reason, clean in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        socket?.event.message = { [weak self] message in
            guard let self = self else { return }
            guard let bytes = message as? [UInt8] else { return }
            let data = Data(bytes: bytes)
            let decoder = JSONDecoder()
            do {
                let message = try decoder.decode(
                    ChatMessage.self,
                    from: data
                )
                print("MESSAGE FROM WS: \(message.text)")
            } catch {
                print("Error decoding location: \(error)")
                print("Error decoding message: \(message)")
                
            }
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        let message = ChatMessage(name: "Mike",
                                  text: "Mike Random message \(UUID().uuidString.lowercased())",
            isIncoming: false, date: Date())
        let json = try! JSONEncoder().encode(message)
        print(json)
        //        socket?.send(text: "Ola")
        socket?.send(data: json)
    }
}


