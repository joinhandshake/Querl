//
//  StarWarsViewController.swift
//  Querl
//
//  Created by Joel Kin on 08/10/2022.
//  Copyright (c) 2022 Joel Kin. All rights reserved.
//

import UIKit
import Querl

class StarWarsViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var crawlText: UITextView!
    
    var pagination: Pagination?

    @IBAction func search(_ sender: Any) {
        Task {
            do {
                let paged = try await StarWarsService.query(NextFilm(afterCursor: pagination?.endCursor, pageSize: 1))
                await MainActor.run {
                    nextButton.isEnabled = paged.pageInfo.hasNextPage ?? false
                    nameLabel.text = paged.nodes.first?.title
                    crawlText.text = paged.nodes.first?.openingCrawl
                    self.pagination = paged.pageInfo
                }
            } catch {
                print(error)
            }
        }
    }
}

