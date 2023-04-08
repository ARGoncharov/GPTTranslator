//
//  ViewController.swift
//  GPTTranslator
//
//  Created by Алексей  on 20.03.2023.
//

import UIKit
import SnapKit
import Combine

class ViewController: UIViewController {
    
    let viewModel = MainViewModel()
    var resultCancellable: AnyCancellable?
    
    //MARK: - UI Components
    
    private lazy var toEnglishTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .none
        textField.textColor = .systemPink
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.placeholder = "Enter the russian text here..."
        textField.delegate = self
        return textField
    }()
    
    private lazy var toRussianTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .none
        textField.textColor = .systemPink
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.placeholder = "Enter the english text here..."
        textField.delegate = self
        return textField
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
//        var textColor: UIColor {
//            if #available(iOS 13.0, *) {
//                return UIColor { (traits) -> UIColor in
//                    return traits.userInterfaceStyle == .dark ? .white : .black
//                }
//            } else {
//                return .black
//            }
//        }
        label.textColor = .systemPink
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let resultButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.layer.cornerRadius = 5
        button.backgroundColor = .gray
        button.setTitle("Translate", for: .normal)
        button.addTarget(
            self,
            action: #selector(resultButtonPressed),
            for: [.touchDown, .touchUpInside, .touchUpOutside]
        )
        return button
    }()
    
    private var toEnglishTextFieldBottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    private var toRussianTextFieldBottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(
            toEnglishTextField,
            toEnglishTextFieldBottomLine,
            toRussianTextFieldBottomLine,
            toRussianTextField,
            resultLabel,
            resultButton
        )
        
        addConstraints()
        
        resultCancellable = viewModel.$translatedResult.sink { [weak self] translated in
            self?.resultLabel.text = translated
        }
    }
    
    //MARK: - Private methods
    
    private func addConstraints() {
        toEnglishTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(200)
        }
        
        toEnglishTextFieldBottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(toEnglishTextField.snp.bottom).offset(10)
            make.height.equalTo(1.5)
        }
        
        toRussianTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(toEnglishTextFieldBottomLine).offset(30)
        }
        
        toRussianTextFieldBottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(toRussianTextField.snp.bottom).offset(10)
            make.height.equalTo(1.5)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(100)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(toRussianTextField.snp.bottom).offset(60)
            make.height.equalTo(50)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func resultButtonPressed() {
        buttonColorChange()
        handleTextFields()
    }
    
    private func handleTextFields() {
        if toEnglishTextField.isFirstResponder, let text = toEnglishTextField.text {
            viewModel.translateToEnglish(text)
            toEnglishTextField.resignFirstResponder()
        } else if toRussianTextField.isFirstResponder, let text = toRussianTextField.text {
            viewModel.translateToRussian(text)
            toRussianTextField.resignFirstResponder()
        }
    }
    
    private func buttonColorChange() {
        if resultButton.backgroundColor == .gray {
            resultButton.backgroundColor = UIColor.systemPink
        } else {
            resultButton.backgroundColor = UIColor.gray
        }
    }
}

//For case we hit return button
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleTextFields()
        return true
    }
}

