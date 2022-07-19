//
//  Dashboard ViewController.swift
//  TwoHrs
//
//  Created by Apple on 24/06/22.
//

import Foundation
import UIKit
class ShopDataTableViewCell: UITableViewCell {
   
}

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bannerImg: UIImageView!
}

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var txtCatName: UILabel!
    @IBOutlet weak var imgCatImage: UIImageView!
    @IBOutlet weak var txtShopName: UILabel!
    @IBOutlet weak var txtShopAdd: UILabel!
    @IBOutlet weak var viewCardVw: UIView!
    @IBOutlet weak var viewforImage: UIView!
}


class DashboardViewController: BaseViewController {
    var shopImageDash = [ShopModel]()
    var banners = [BannerModel]()
//    var imageUrl = "https://2hrs.in/admin/uploads/banners/"
//    var shopImageUrl = "https://2hrs.in/admin/uploads/vendors/"
    var imagePath = ""
    var categoryName = ""

   
    @IBOutlet weak var shopsTableView: UITableView!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var itemTableView: UITableView!
    
    override func viewDidLoad() {
        getBanner()
        getShopData()
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
         func scrollAutomatically(_ timer: Timer) {
        }
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
            
            if let coll  = bannerCollectionView {
                for cell in coll.visibleCells {
                    let indexPath: IndexPath? = coll.indexPath(for: cell)
                    if ((indexPath?.row)!  < banners.count - 1 ){
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                        
                        coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                    }
                    else{
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                        coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    }
                    
                }
            }
        }
}
//Collection view Controller
extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath)
//        return cell
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCollectionViewCell
        let data = banners[indexPath.row]
        cell.bannerImg.downloadedfrm(from: imageUrl + (data.banner ?? ""))
//        cell.bannerImg.image = UIImage(named: "image1")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let size:CGFloat = (bannerCollectionView.frame.size.width) / 1
            return CGSize(width: size, height: size)
        }
}


//Table view Controller
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopImageDash.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! ItemTableViewCell
//        cell.imgCatImage.image = UIImage(named: "child")
        let data = shopImageDash[indexPath.row]
        cell.txtCatName.text = (data.categoryname ?? "" as? String)
        cell.imgCatImage.downloadedfrm(from: imagePath + (data.shopimage ?? "") as! String)
        cell.txtShopName.text = (data.shopname ?? "" as? String)
        cell.txtShopAdd.text = (data.shopadd ?? "" as? String)
        print(data.categoryname ?? "") as? String

        setCardView(view: cell.viewCardVw)
        setCardView(view: cell.viewforImage)
        setCardView(view: cell.imgCatImage)

        return cell
    }



    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 6
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = shopsTableView.dequeueReusableCell(withIdentifier: "TableCell1", for: indexPath) as! ShopDataTableViewCell
//
//        return cell
//    }
        
    func getBanner(){
//        let parameters: [String: Any] = []
        
        fetchOrSendWithoutParameter(url:"https://2hrs.in/AndroidApis/index.php/Cms/GetBanners") { result, success, message in
            if success {
                if result["success"] as! Int == 1 {
                    let data = result["data"] as! AnyObject
                    print(data)
                    let id = data["id"] as! AnyObject
                    print("id is ", id)
                    
                    self.banners = self.parseBanner(result: result)
                    DispatchQueue.main.async {
                        self.bannerCollectionView.reloadData()
                    }
                } else if(result["success"] as! Int == 0) {
                    print("Your mobile number is not registered, Please Register")
                                        
                } else {
                    print("Result message")
                }
            } else {
                print("Network errors")
            }
        }
    }

    func parseBanner(result: NSDictionary) -> [BannerModel] {
        var bannerList = [BannerModel]()
        guard let data = result["data"] as? [AnyObject] else {
            return []
        }
        for item in data {
            bannerList.append(BannerModel(id: item["id"] as? String ?? "", title:  item["title"] as? String ?? "", banner: item["banner"] as? String ?? ""))
        }
        return bannerList
    }
    
    func getShopData() {
            let parameters: [String: Any] =
            ["pincode" : "440022"
            ]
            
            fetchOrSendWithHeaderData(url: Urls.getShopforCate, Parameter: parameters) { result, success, message in
                
                if success {
                    if result["success"] as! Int == 1 {
                        print("Success message done for shopsData")
                        
                        self.shopImageDash = self.parseShopData(result: result)
                        DispatchQueue.main.async {
                            self.itemTableView.reloadData()
                        }
                               
                    } else if(result["success"] as! Int == 0) {
                        print("Data not found")
                                            
                    } else {
                        print("Result message")
                    }
                } else {
                    print("Network errors")
                }
            }
        }
    func parseShopData(result: NSDictionary) -> [ShopModel] {
        var shopList = [ShopModel]()
        
        guard let data = result["data"] as? [AnyObject] else {
            return []
        }
        
        imagePath = result["image_path"] as! String
        for item in data {
            guard let shopData = item["shopData"] as? [AnyObject] else {
                return []
            }
            for itemsS in shopData {
                shopList.append(ShopModel(catid: item["category_id"] as? String ?? "", categoryname:  item["category_name"] as? String ?? "", shopname:  itemsS["shop_name"] as? String ?? "", shopimage:  (itemsS["image"] as? String ?? "") as? String ?? "", shopadd:  itemsS["address"] as? String ?? ""))
            }
            
//            shopList.append(ShopModel(catid: item["category_id"] as? String ?? "", categoryname:  item["category_name"] as? String ?? "", shopname:  item["shop_name"] as? String ?? "", shopimage:  item["image"] as? String ?? "", shopadd:  item["address"] as? String ?? ""))
        }
       
        return shopList
      
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
        
    }
extension UIImageView {
    func downloadedfrm(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloadedfrm(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}



