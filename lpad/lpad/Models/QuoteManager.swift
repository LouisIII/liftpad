

import Foundation
import SwiftUI
import WatchConnectivity


class QuoteManager: ObservableObject {
    
    @Published var dailyQuote: String = "...loading..."
    @Published var openAlert: Bool = false
    
    let quoteURL: String = "https://zenquotes.io/api/today"
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.openAlert = true
                    return
                }
                
                if let safeData = data {
                    self.parsJSON(quoteData: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parsJSON(quoteData: Data) {
        
        do {
            let decodedData = try JSONDecoder().decode(QuoteResponse.self, from: quoteData)
            print(decodedData.quote.q)
            dailyQuote = String(decodedData.quote.q)
        } catch {
            print(error)
        }
    }
}

struct QuoteResponse: Codable {
    let quote: QuoteData
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        quote = try container.decode(QuoteData.self)
    }
}

struct QuoteData: Codable {
    let q: String
    let a: String
    let h: String
}

