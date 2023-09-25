//
//  AlgoDemoDS.swift
//  LocalCacheExample
//
//  Created by Pradeep kumar on 20/9/23.
//

import Foundation


class AlgoDemoDS {
    
    
    init() {
        
        print(lengthOfLongestSubstring("dvdf"))
    }
    
    //"dvdf"
    // abcdeagh
    // bacdeagh
    //
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        var ans = 0
        var setAns = Set<Character>()
        for ele in s {
            if setAns.isEmpty {
                setAns.insert(ele)
            } else {
                if setAns.contains(ele) {
                    ans = max(ans, setAns.count)
                    setAns = updateCurrentSet(setAns, s: s, currentChar: ele)
                    setAns.insert(ele)
                } else {
                    setAns.insert(ele)
                }
            }
        }
        
        ans = max(ans, setAns.count)
        
        return ans
        
    }
    
    func updateCurrentSet(_ setAns: Set<Character>, s: String, currentChar: Character) -> Set<Character> {
        var setAns = setAns
        for char in s {
            setAns.remove(char)
            if currentChar == char {
                break
            }
        }
        return setAns
    }
        
}
