

import UIKit

class DetailScreenViewController: UIViewController {

    @IBOutlet weak var selectedimageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var selectedImage = String()
    var selectedPrice : Int?
    var selectedProductName = String()
    var selectedProductID = String()
    var productDescription : ProductDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSelectedProduct()
        showProductDescription()
    }
    
    
    func showProductDescription() {
        let urlString =
            "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(String(describing: selectedProductID))/detail"
        if let url = URL(string: urlString) {
            let urlRequest  = URLRequest(url: url)
            let dataTask =  URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                if let data = data {
                    if  let response =  try? JSONDecoder().decode(ProductDescription.self, from: data) {
                        self.productDescription = response
                        DispatchQueue.main.async {
                            self.descriptionLabel.text = response.description
                         
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    
    func showSelectedProduct() {
        if let url = URL(string: selectedImage) {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.selectedimageView.image = UIImage(data: data)
                }
            }
            dataTask.resume()
        }
        
        productNameLabel.text = selectedProductName
        priceLabel.text = String(selectedPrice ?? 0)
        
    }
    
}
