//
//  ContentView.swift
//  Coin Purchase
//
//  Created by Mashael Alharbi on 16/02/2023.
//
import SwiftUI
import StoreKit

struct ContentView: View {
    
    @StateObject var storeKit = StoreKitManager()
    @StateObject var iAPManager = IAPManager()
    @State private var count = 0
    @State private var loops = 0
    
    //    @StateObject let consumable: Product.ProductType
    
//    @State private var coins = Int (isPurchased(Product))
    
    var body: some View {
        NavigationView {
            
            VStack {
                HStack {
                    Image("Coin")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Text("\(myCoinsCount + count)")
                        .font(.title.bold())
                    
                }
                .offset(y: -80)
                Divider()
                    .padding()
                
                
                /// ### Prodects
                ///
                ForEach(storeKit.storeProducts) { product in
                    HStack {
                        Image("Coin")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(product.displayName)
                        Spacer()
                        
                        Button(action: {
                            // purchase this product
                            Task { try await storeKit.purchase(product)
                                var str = product.displayName
                                if let intNum = Int(str.components(separatedBy: " ")[0]) {
                                    count += intNum
                                }
//                                count += 20
                                return
                            }
                        })
                        {
                         CourseItem(storeKit: storeKit, product: product)
                         .frame(width: 80, height: 40)
                         .foregroundColor(.white)
                         .background(Color("BabyGreen"))
                         .cornerRadius(15)

                            }
                        }
                    }
                }
                .navigationTitle("Balance")
                .padding()
            }
        }
        
    
        var myCoinsCount: Int {
            return UserDefaults.standard.integer(forKey: "Coins_Count")
        }
        
    }



struct CourseItem: View {
    
    @ObservedObject var storeKit : StoreKitManager
    @State var isPurchased: Bool = false
    
    var product: Product
    
    var body: some View {
        VStack {
            if isPurchased {
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .padding(10)
            } else {
                Text(product.displayPrice)
                    .padding(10)
            }
        }
        .onChange(of: storeKit.purchasedCoins) { course in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
        }
    }
}

var myCoinsCount: Int {
    return UserDefaults.standard.integer(forKey: "Coins_Count")
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
