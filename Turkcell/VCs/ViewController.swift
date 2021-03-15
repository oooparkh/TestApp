
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel = ViewModel()
    private let apiURL = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.fetchData(url: apiURL)
    }
    
}
extension ViewController :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel.ProductsList.value?.products.count else {
            return 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nameCell = String(describing: CustomUICollectionViewCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nameCell,
                                                       for: indexPath) as? CustomUICollectionViewCell else {
            return UICollectionViewCell()
        }
        
        DispatchQueue.main.async {
            if let productName = self.viewModel.ProductsList.value {
                cell.productNameLabel.text = productName.products[indexPath.row].name
            }
            if let price = self.viewModel.ProductsList.value {
                cell.priceLabel.text = (String(price.products[indexPath.row].price ?? 0))
            }
            if let produstID = self.viewModel.ProductsList.value {
                cell.productIDLabel.text = produstID.products[indexPath.row].product_id 
            }
            
            if let image = self.viewModel.ProductsList.value {
                if let url = URL(string: image.products[indexPath.row].image ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error  in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
        }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailScreenViewController = storyboard.instantiateViewController(identifier: String(describing: DetailScreenViewController.self)) as! DetailScreenViewController
        detailScreenViewController.modalPresentationStyle = .fullScreen
        detailScreenViewController.selectedImage = viewModel.ProductsList.value?.products[indexPath.row].image ?? ""
        detailScreenViewController.selectedPrice = viewModel.ProductsList.value?.products[indexPath.row].price 
        detailScreenViewController.selectedProductName = viewModel.ProductsList.value?.products[indexPath.row].name ?? ""
        detailScreenViewController.selectedProductID = viewModel.ProductsList.value?.products[indexPath.row].product_id ?? ""
        self.navigationController?.pushViewController(detailScreenViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) * 0.9, height: (view.frame.width / 2) * 0.9)
    }
    
    

}
