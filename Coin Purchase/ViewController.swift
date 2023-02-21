//
//  ViewController.swift
//  Coin Purchase
//
//  Created by Mashael Alharbi on 16/02/2023.
//

import UIKit
import StoreKit

//extension String {
//    func toImage() -> UIImage? {
//        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
//            return UIImage(data: data)
//        }
//        return nil
//    }
//}

struct Model {
    let title: Int
//    let title20 : Int = 20
//    let title40 : Int = 40
//    let title60 : Int = 60
//    let title80 : Int = 80
//    let title100 : Int = 100
    let handler: (() -> Void)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    var models = [Model] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ** Cofigure models ** //
        models.append(Model(title: 20 , handler: {
            IAPManager.shared.purchase(product: .Coins_20) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myCoinsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "Coins_Count")
                    self?.setUpHeader()
                }
            }
        }))
        models.append(Model(title: 40, handler: {
            IAPManager.shared.purchase(product: .Coins_40) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myCoinsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "Coins_Count")
                    self?.setUpHeader()
                }
            }
        }))
        models.append(Model(title: 60, handler: {
            IAPManager.shared.purchase(product: .Coins_60) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myCoinsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "Coins_Count")
                    self?.setUpHeader()
                }
            }
        }))
        models.append(Model(title: 80 , handler: {
            IAPManager.shared.purchase(product: .Coins_80) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myCoinsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "Coins_Count")
                    self?.setUpHeader()
                }
            }
        }))
        models.append(Model(title: 100, handler: {
            IAPManager.shared.purchase(product: .Coins_100) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myCoinsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "Coins_Count")
                    self?.setUpHeader()
                }
            }
        }))
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        setUpHeader()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = model.title
        cell.imageView?.image = UIImage(named: "Coin")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        model.handler()
    }
    
    var myCoinsCount: Int {
        return UserDefaults.standard.integer(forKey: "Coins_Count")
    }
    
    func setUpHeader() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        let imageView = UIImageView(image: UIImage(named: "Coin"))
        imageView.frame = CGRect(x: (view.frame.size.width - 100)/2, y: 10, width: 100, height: 100)
        imageView.tintColor = .systemRed
        ///*****
        header.addSubview(imageView)
        let lable = UILabel(frame: CGRect(x: 10, y: 120, width: view.frame.size.width-20, height: 100))
        header.addSubview(lable)
        lable.font = .systemFont(ofSize: 25, weight: .bold)
        lable.textAlignment = .center
        lable.text = "\(myCoinsCount) Coins"
        tableView.tableHeaderView = header   
    }
}
