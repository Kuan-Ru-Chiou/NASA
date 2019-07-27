//
//  NasaController.swift
//  NASA
//
//  Created by 邱冠儒 on 2019/7/25.

//




//抓Json data  和 圖片   圖片是另外再透過data的URL 來抓

import UIKit

class NasaController {
    
    //單例模式  指初始化一次物件 所有檔案都能存取
    static let shared = NasaController()
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    var nasaArray = [Nasa]()
    
    func fetchSongs(completion: @escaping ([Nasa]?) -> Void) {
        if let urlStr = "https://api.nasa.gov/planetary/apod?api_key=KbC3LNS8QLTk1KaOjWBDT6xvb3s2R8i3a8ZPYSEL&start_date=2017-08-01&end_date=2017-08-25".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                //Json解碼
                if let data = data, let resultArray = (try? JSONSerialization.jsonObject(with: data,options: [])) as? [[String: Any]] {
                    //debug 用 可以刪掉
                    print(resultArray)
                    //並且把Json資料變成物件陣列   一筆一筆塞進ＡＲＲＡＲＹ
                    for nasaDic in resultArray {
                        if let nasa = Nasa(json: nasaDic as! [String : String]) {
                            self.nasaArray.append(nasa)
                        }
                    }
                    completion(self.nasaArray)
                }
            }
            task.resume()
        }
    }
}

