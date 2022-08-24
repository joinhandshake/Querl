//
//  CountryViewController.swift
//  Querl
//
//  Created by Joel Kin on 08/10/2022.
//  Copyright (c) 2022 Joel Kin. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!

    @IBAction func search(_ sender: Any) {
        Task {
            do {
                let country = try await CountryService.query(CountryForCode(code: countryField.text ?? Locale.current.regionCode ?? "TV")).country
                await MainActor.run {
                    emojiLabel.text = country?.emoji
                    nameLabel.text = country?.name
                    capitalLabel.text = country?.capital
                    currencyLabel.text = country?.currency
                    languagesLabel.text = ListFormatter().string(from: country?.languages
                        .map(\.name) ?? [])
                }
            } catch {
                print(error)
            }
        }
    }
}

