//
//  NasaDetailViewController.swift
//  NASA
//
//  Created by 邱冠儒 on 2019/7/25.

//

import UIKit

class NasaDetailViewController: UIViewController {
    
    var nasa: Nasa!
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    //網路下載圖片要更新畫面時 圖片的更新最好另外寫因為圖片處理比較不一樣  （小心）
    func updateUI() {
        navigationItem.title = nasa.date
        titleLabel.text = nasa.title
        descriptionLabel.text = nasa.explanation
        //不用產生實例物件就能直接使用 因為是型別方法
        NasaController.shared.fetchImage(url: nasa.url) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
}
