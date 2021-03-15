
import Foundation

struct ProductsList : Codable {
    let products : [Products]
}

struct Products : Codable {
    let product_id : String?
    let name : String?
    let price : Int?
    let image : String?
}
