//
//  APIService.swift
//  GPTTranslator
//
//  Created by Алексей  on 20.03.2023.
//

import Foundation
import OpenAISwift

protocol ChatGPTAPIService {
    func translate(_ text: String, completion: @escaping (String) -> Void)
}

class ChatGPTAPIServiceMock: ChatGPTAPIService {
    
    func translate(_ text: String, completion: @escaping (String) -> Void) {
        completion(text + " translated")
    }
    
}

class ChatGPTAPIServiceImpl: ChatGPTAPIService {
    
    private let openAI = OpenAISwift(authToken: "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")
    
    //Implement with ChatGpt api 
    func translate(_ text: String, completion: @escaping (String) -> Void) {
        
        openAI.sendCompletion(with: text, model: .gpt3(.davinci), maxTokens: 64) { result in
            switch result {
            case .success(let success):
                print(success)
                completion(success.choices.first?.text ?? "")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
