//
//  ChatMessage.swift
//  App
//
//  Created by Michel Anderson Lutz Teixeira on 27/08/19.
//

import Foundation

final class ChatMessage: Codable {
    let name: String
    let text: String
    let isIncoming: Bool
    let date: Date

    init(name: String, text: String, isIncoming: Bool, date: Date) {
        self.name = name
        self.text = text
        self.isIncoming = isIncoming
        self.date = date
    }
}
