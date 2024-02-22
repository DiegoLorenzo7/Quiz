//
//  Extensions.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
infix operator =+-= : ComparisonPrecedence

extension String{
    
    // Devuelve el string lowered y trimmed
    
    func loweredTrimmed() -> String{
        self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    // Compara igualdad despues de lowered y trimmed
    
    func isLoweredTrimmedEqual(_ str: String) -> Bool{
        self.loweredTrimmed() == str.loweredTrimmed()
    }
    // Compara si dos strings son mas o menos iguales, o mejor dicho,
    
    // igualdad despues lowered y trimmed
    
    static func =+-= (s1: String, s2: String) -> Bool {
        
        s1.isLoweredTrimmedEqual(s2)
    }
}

extension String: LocalizedError{
    
    public var errorDescription: String?{
        
        return self
    }
}
