//
//  ListViewModel.swift
//  ScrolingPagesTest
//
//  Created by Mac on 25.10.2022.
//

import Foundation
import UIKit

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = []
    @Published var ResultArr: [ItemModel] = []{
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_resultArr"
    let itemsKey2: String = "items_items"
    
    init() {
        getItems()
    }
    
    func getItems() {

        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        guard
            let data2 = UserDefaults.standard.data(forKey: itemsKey2),
            let savedItems2 = try? JSONDecoder().decode([ItemModel].self, from: data2)
        else { return }
                
        self.ResultArr = savedItems
        self.items = savedItems2
    }
    
    func deleteItem(indexSet: IndexSet) {
        ResultArr.remove(atOffsets: indexSet)
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        ResultArr.move(fromOffsets: from, toOffset: to)
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        ResultArr.append(newItem)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        if let index = ResultArr.firstIndex(where: { $0.id == item.id }) {
            ResultArr[index] = item.updateCompletion()
        }
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func filterIsCompleted() {
        ResultArr = items.filter({ (item) -> Bool in
            return item.isCompleted == true
        })
    }
    
    func filterIsNotCompleted() {
        ResultArr = items.filter({ (item) -> Bool in
            return item.isCompleted == false
        })
    }
    
    func updateResultArray() {
        ResultArr = items
    }
    
    func deleteAll() {
        ResultArr.removeAll()
        items.removeAll()
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(ResultArr) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey2)
        }
    }
}
