//
//  ViewController.swift
//  Sample
//
//  Created by Meniny on 2017-07-27.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import Localization

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    let options: [LocalizableLanguage] = [
        LocalizableLanguage.english,
        LocalizableLanguage.simplifiedChinese,
        LocalizableLanguage.traditionalChinese,
        LocalizableLanguage.japanese,
        LocalizableLanguage.korean,
        LocalizableLanguage.german
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        updateAppearance()
        
        Localization.startObserve(with: self, selector: #selector(localizationDidChangeWithPreferredLanguage))
    }
    
    deinit {
        Localization.stopObserve(with: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let system = Localization.preferredLanguage
        if let current = LocalizableLanguage(code: system) {
            if let idx = options.index(of: current) {
                // System
                picker.selectRow(idx, inComponent: 0, animated: false)
            } else {
                // English
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        }
    }
    
    func updateAppearance() {
        title = "hello".localized()
        label.text = "bye".localized()
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Localization.preferredLanguage = options[row].code
    }
    
}

extension ViewController {
    
    func localizationDidChangeWithPreferredLanguage() {
        updateAppearance()
    }
}
