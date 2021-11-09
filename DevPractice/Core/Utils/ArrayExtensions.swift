//
//  ArrayExtensions.swift
//  DevPractice
//
//  Created by Tony Mu on 9/11/21.
//

import Foundation

//https://medium.com/@EnnioMa/back-to-the-fundamentals-sorting-algorithms-in-swift-from-scratch-fccf8a3daea3


extension Array where Element: Comparable {
    func bubbleSort(by areaInIncreaseingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        for i in 0..<(data.count-1) {
            print("Index i: \(i)")
            for j in 0..<(data.count-i-1) where areaInIncreaseingOrder(data[j+1], data[j]) {
                print("Swapping \(data[j]) and \(data[j+1])")
                data.swapAt(j, j+1)
            }
        }
        return data
    }
    
    func insertionSort(by areaInIncreaseingOrder: ((Element,Element)-> Bool) = (<)) -> [Element] {
        var data = self
        
        for i in 1..<data.count {
            let key = data[i]
            var j = i - 1
            
            while j>=0 && areaInIncreaseingOrder(key, data[j]) {
                data[j+1] = data[j]
                j = j - 1
            }
            
            data[j+1] = key
        }
        return data
    }
    
    func selectionSort(by areaInIncreaseingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        
        for i in 0..<(data.count-1) {
            var key = i
            
            for j in i+1..<count where areaInIncreaseingOrder(data[j], data[key]) {
                key = j
            }
            
            guard i != key  else {
                continue
            }
            
            data.swapAt(i, key)
        }
        return data
    }
}

extension Array where Element: Comparable {
    private func _quickSort(_ array: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool)) -> [Element] {
        if array.count < 2 { return array } // 0
        
        var data = array
        
        let pivot = data.remove(at: 0) // 1
        let left = data.filter { areInIncreasingOrder($0, pivot) } // 2
        let right = data.filter { !areInIncreasingOrder($0, pivot) } // 3
        let middle = [pivot]
        
        return _quickSort(left, by: areInIncreasingOrder) + middle + _quickSort(right, by: areInIncreasingOrder) // 4
    }
    
    func quickSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        return _quickSort(self, by: areInIncreasingOrder)
    }
    
    func quickSort2() -> [Element] {
        guard count > 1 else { return self }

        let pivot = self[count/2]

        let less = filter { $0 < pivot }
        let equal = filter { $0 == pivot }
        let greater = filter { $0 > pivot }

        return less.quickSort2() + equal + greater.quickSort2()
    }
}

extension Array where Element == Int {
    static func generateRandomNumber(size: Int) -> [Int] {
        guard size > 0 else { return [] }
        let result = Array<Int>(repeating: 0, count: size)
        return result.map { _ in Int.random(in: 0..<size)}
    }
    
    static func generateUniqueRandomNumber(size: Int) -> [Int] {
        guard size > 0  else { return [] }
        return Array<Int>(0..<size).shuffled()
    }
}
