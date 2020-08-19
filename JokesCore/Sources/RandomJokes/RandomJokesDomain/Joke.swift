import UIKit

public struct Joke: Codable, Equatable {
    public let id: Int
    public let text: String
}

extension Joke {
    
    enum CodingKeys: String, CodingKey {
        case id
        case text = "joke"
    }
}

extension Joke {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text).htmlString
    }
}


private extension String {
    
    var htmlString: String { htmlAttributedString?.string ?? self }
    
    private var htmlAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        return try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
    }
}
