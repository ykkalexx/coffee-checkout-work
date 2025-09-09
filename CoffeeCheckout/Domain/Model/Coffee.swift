import Foundation
import Combine

struct Coffee: Identifiable, Codable {
    let id: Int
    let name: String
    let desc: String
    let price: Double
}
