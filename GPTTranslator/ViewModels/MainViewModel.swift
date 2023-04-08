//
//  MainViewModel.swift
//  GPTTranslator
//
//  Created by Алексей  on 20.03.2023.
//

import Foundation
import Combine

final class MainViewModel {
    
    @Published var translatedResult = ""
    
    //Change mock to impl
    let service: ChatGPTAPIService = ChatGPTAPIServiceImpl()
    
    //MARK: - Methods
    
    func translateToEnglish(_ text: String) {
        
        let text = "\"\(text)\" translate to Mandarin and write characters and pinyin"
        
        service.translate(text) { translated in
            DispatchQueue.main.async {
                print(translated)
                self.translatedResult = translated.trimmingCharacters(in: .newlines)
            }
        }
    }
    
    func translateToRussian(_ text: String) {
        
        let text = "\"\(text)\" translate to Russian"
        
        service.translate(text) { translated in
            DispatchQueue.main.async {
                print(translated)
                self.translatedResult = translated.trimmingCharacters(in: .newlines)
            }
        }
    }
}
