//
//  TableTableViewController.swift
//  CountryDisplay
//
//  Created by Giridhar Bhujanga on 24/05/17.
//  Copyright © 2017 Giridhar Bhujanga. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    var fetchedCountry = [Country]()
    
    var mySelectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = fetchedCountry[indexPath.row].country
        cell?.detailTextLabel?.text = fetchedCountry[indexPath.row].capital
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedCountry.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mySelectedIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! DestinationViewController
                destVC.titleText = self.fetchedCountry[indexPath.row].country
            }
        }
    }
    
    func parseData() {
        fetchedCountry = []
        
        let url = "https://restcountries.eu/rest/v1/all"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("ERROR !")
            } else {
                do {
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    
                    //print(fetchedData)
                    
                    for eachFetchedCountry in fetchedData {
                        let eachCountry = eachFetchedCountry as! [String:Any]
                        let country = eachCountry["name"] as! String
                        let capital = eachCountry["capital"] as! String
                        
                        print(country)
                        print(capital)
                        print("\n")
                        
                        self.fetchedCountry.append(Country(country: country, capital: capital))
                        
                    }
                    print(self.fetchedCountry)
                    self.tableView.reloadData()
                } catch {
                    print("Error in JSON Serialization !")
                }
            }
        }
        task.resume()
        print(fetchedCountry)

    }

}


class Country {
    var country : String
    var capital : String
    init(country: String, capital: String) {
        self.country = country
        self.capital = capital
    }
}
