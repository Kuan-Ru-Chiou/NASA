//
//  NasaDailyTableViewController.swift
//  NASA
//
//  Created by 邱冠儒 on 2019/7/25.

//

import UIKit

class NasaDailyTableViewController: UITableViewController {
    
    //初始化物件陣列 要拿來存json的物件用
    var nasas = [Nasa]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //不用產生實例物件就能直接使用 因為是型別方法
        NasaController.shared.fetchSongs { (nasas) in
            if let nasas = nasas {
                self.updateUI(nasas: nasas)
            }
        }

    }
    
    
    func updateUI(nasas: [Nasa]) {
        DispatchQueue.main.async {
            self.nasas = nasas
            self.tableView.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nasas.count
    }
    
    //更新cell
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let nasa = nasas[indexPath.row]
        cell.textLabel?.text = nasa.title
        cell.detailTextLabel?.text = nasa.date
        //有可能nasa 的URL 沒圖片  如果沒圖片或還沒載完就不顯示圖片 或者使用者可以自訂圖片
        cell.imageView?.image = UIImage(named:"nasa-144")
        
        //不用產生實例物件就能直接使用 因為是型別方法
        NasaController.shared.fetchImage(url: nasa.url) { (image) in
            guard let image = image else {
                return
            }
            //Cell圖片在背景下載 下載完後會在main thread 更新 這樣使用者在看畫面才不會卡住 圖片下載速度跟網路有關
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath == indexPath {
                    cell.imageView?.image = image
                }
            }
        }
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NasaCell", for: indexPath)
        
        // Configure the cell...
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nasaDetailViewController = segue.destination as? NasaDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row {
            nasaDetailViewController.nasa = nasas[row]
        }
        
    }
    
    
}
