//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Joseph on 19/02/2020.
//  Copyright © 2020 Joseph Doogan. All rights reserved.
//

import Foundation

class Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    static func saveToFile(emojis: [Emoji]) {
        // Create a Property List Encoder
        let propertyListEncoder = PropertyListEncoder()
        // Encode the emojis array as Data
        let encodedEmojis = try? propertyListEncoder.encode(emojis)
        // Write the Encoded Data to ArchiveURL
        try? encodedEmojis?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Emoji]? {
        // Create a Property List Decoder
        let propertyListDecoder = PropertyListDecoder()
        // Fetch the Data and attempt to Decode as Emoji array
        if let retrievedData = try? Data(contentsOf: ArchiveURL),
            let decodedEmojis = try? propertyListDecoder.decode(Array<Emoji>.self, from: retrievedData) {
            // Return decoded Emojis
            return decodedEmojis
        }
        // Return empty Emoji array
        return nil
    }
    
    static func loadSampleEmojis() -> [Emoji] {
        // Create a sample list of Emojis
        let emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face",
              description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face",
              description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",
              description: "A smiley face with hearts for eyes.",
              usage: "love of something; attractive"),
        Emoji(symbol: "👮", name: "Police Officer",
              description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
        Emoji(symbol: "🐢", name: "Turtle", description:
            "A cute turtle.", usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description:
            "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti",
              description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books",
              description: "Three colored books stacked on each other.",
              usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart",
              description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore",
              description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag",
              description: "A black-and-white checkered flag.", usage:
            "completion")]
        
        return emojis
    }
}
