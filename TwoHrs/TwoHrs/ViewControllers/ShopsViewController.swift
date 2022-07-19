//
//  ShopsViewController.swift
//  TwoHrs
//
//  Created by Apple on 28/06/22.
//

import UIKit

class TableListViewCell: UITableViewCell {
    
    @IBOutlet weak var txtCategoryName: UILabel!
    @IBOutlet weak var imgShpItem: UIImageView!
    @IBOutlet weak var txtShopName: UILabel!
    @IBOutlet weak var txtAddress: UILabel!
}

class ShopsViewController: BaseViewController {
    var shopImage = [ShopModel]()
    var shopImageUrl = "https://2hrs.in/admin/uploads/vendors/"
    var imagePath = ""
    var categoryName = ""

    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getShopImage()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShopsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableListViewCell
//        cell.imgShpItem.image = UIImage (named: "image1")
//
        let data = shopImage[indexPath.row]
        cell.imgShpItem.downloaded(from: imagePath+(data.shopimage ?? "") as! String)
        cell.txtCategoryName.text = (data.categoryname ?? "" as? String)
        cell.txtShopName.text = (data.shopname ?? "" as? String)
        cell.txtAddress.text = (data.shopadd ?? "" as? String)
        
        print("hello "+(data.categoryname ?? "") as? String)
        print("image "+imagePath+(data.shopimage ?? "") as? String)
        return cell
    }
    
    func getShopImage(){
        let parameters: [String: Any] =
        ["pincode" : "440022"
        ]
        
        fetchOrSendWithHeaderData(url: Urls.getShopforCate, Parameter: parameters) { result, success, message in
            
            if success {
                if result["success"] as! Int == 1 {
                    print("Success message done")
                    
                    self.shopImage = self.parseShopData(result: result)
                    DispatchQueue.main.async {
                        self.TableView.reloadData()
                    }
                    
           //         let data = result["data"] as! AnyObject
//                    let shopData = result["shopData"] as! AnyObject
//                    let categoryname = data["category_name"] as! AnyObject
//                    let shopname = data["shop_name"] as! AnyObject
                  
                //    print(data)
//                    print(cateName)
//                    print(shopData)
//                    print(shopname)
                    
                           
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
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
