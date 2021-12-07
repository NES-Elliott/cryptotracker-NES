//
//  ViewController.swift
//  CryptoTracker-NES
//
//  Created by Nathaniel Spry on 12/7/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        // Check for value
        if let symbol = textField.text {
            
            getData(symbol : symbol)
            
        }
        
    }
    
    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD"
    
    
    func getData(symbol : String) {
        
        url = "\(url)&fsym=\(symbol)"
        
        // 1. Initialize URL (protection for missing url to not crash the app, if no url is provided, return)
        guard let swiftURL = URL(string: url) else {return}
        
        // 2. Initialize Task and URL Session
        
        let task = URLSession.shared.dataTask(with: swiftURL) { data, _, error in // CLOSURE - create a function within a function
            
            // 3. Check Optionals
            guard let data = data, error == nil else {return}
            
            print("Data Received")
            
            do {
                
                let Result = try JSONDecoder().decode(APIRepsonse.self, from: data)
                
                print(Result.USD)
                
                DispatchQueue.main.async {
                    
                    // String Interpolation
                    self.outputLabel.text = "\(Result.USD)"
                    
                }
                
            } catch {
                
                print(error.localizedDescription)
                
            }
            
        }
        
        // 4. Resume Task
        task.resume()
        
    }
    
    // 5. Define Response Perameters in a Structure
    struct APIRepsonse : Codable {
        
        let USD : Float
        
    }
    
    
    // JSON OBJECT -> SWIFT FOUNDATION OBJECT
    // 1. Initialize URL
    // 2. Initialize Task and URL Session
    // 3. Check Optionals
    // 4. Resume Task
    // 5. Define Response Perameters in a Structure
    
}
