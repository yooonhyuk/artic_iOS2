//
//  HomeCateArticle.swift
//  Artic
//
//  Created by admin on 08/07/2019.
//  Copyright © 2019 choyi. All rights reserved.
//

import Foundation

struct HomeCateArchive: Codable {
    let category_title: String
    let archive_idx, user_idx: Int
    let archive_title, date, archive_img: String
    let category_idx: Int
    let article_cnt: Int
}
