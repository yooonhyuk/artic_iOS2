//
//  Home.swift
//  Artic
//
//  Created by admin on 03/07/2019.
//  Copyright © 2019 choyi. All rights reserved.
//

import UIKit

class Home: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var homeTableView: UITableView!
    var categories = ["새로운 아카이브", "새로운 아티클", "최근 읽은 아티클", "UI/UX", "브랜딩"]
    
    public var newArchiveList: [NewArchive] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.separatorStyle = .none
        homeTableView.sectionIndexBackgroundColor = UIColor.white
        
        
    }
    
    func getNewArchive() {
        
        NewArchiveService.shared.getNewArchive() {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
            case .success(let res):
                
                self.newArchiveList = res as! [NewArchive]
                self.homeTableView.reloadData()
                
                break
            case .requestErr(let err):
                print(".requestErr(\(err))")
                break
            case .pathErr:
                // 대체로 경로를 잘못 쓴 경우입니다.
                // 오타를 확인해보세요.
                print("경로 에러")
                break
            case .serverErr:
                // 서버의 문제인 경우입니다.
                // 여기에서 동작할 행동을 정의해주시면 됩니다.
                print("서버 에러")
                break
            case .networkFail:
                self.simpleAlert(title: "통신 실패", message: "네트워크 상태를 확인하세요.")
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //네비게이션 바 숨김
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 5
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            //새로운 아카이브
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewArchiveCell") as! NewArchiveCell
            
            return cell
        }else if indexPath.section == 1{
            //새로운 아티클
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewArticleCell") as! NewArticleCell
            return cell
        }else if indexPath.section == 2{
            //최근 읽은 아티클
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentArticleCell") as! RecentArticleCell
            return cell
        }else{
            //카테고리별
            let cell = tableView.dequeueReusableCell(withIdentifier: "CateArchiveCell") as! CateArchiveCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            //새로운 아카이브
            return 287
        }else if indexPath.section == 1{
            return 343
        }else if indexPath.section == 2{
            return 90
        }else{
            return 530
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.text = categories[section]
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 20, y: 17, width:titleLabel.frame.width + 9, height: 18)
        titleLabel.font = UIFont(name: "NanumBarunGothicBold", size: 18)
        
        let button = UIButton(type: .system)
        //button.setTitle("See All", for: .normal)
        button.setImage(UIImage(named: "btnRightarrow"), for: .normal)
        button.tintColor = UIColor.black
        //button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        var xPosition = 20 + titleLabel.frame.width
        button.frame = CGRect(x: xPosition, y: 14, width: 21, height: 21)
//        button.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(button)
        
        return view
    }

    @IBAction func homeSearchBtnClicked(_ sender: Any) {
        
    }
}
