
import Foundation

class ViewModel {
    private let api = APIManager()

    let ProductsList: Observable<ProductsList?> = Observable(nil)

    func fetchData(url: String) {
        api.fetchData(url: url) { (result) in
            switch result {
            case .success(let data):
                self.ProductsList.value = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
