
import Foundation

class APIManager {

    func fetchData(url urlString: String, completion: @escaping (Result<ProductsList?, Error>) -> ()) {
        if let url = URL(string: urlString) {
            fetchData(url: url, completion: completion)
        }
    }

    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T?, Error>) -> ()) {
        let urlRequest = URLRequest(url: url)
        URLSession.shared.configuration.urlCache = nil
        let config = URLSessionConfiguration.default
        URLSession(configuration: config).dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                if let dataResponse = try? JSONDecoder().decode(ProductsList.self, from: data) {
                    completion(.success(dataResponse as? T))
                } else {
                    completion(.success(nil))
                }
            }
        }.resume()
    }
}
