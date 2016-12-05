//
//  CategoryManager.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 12/2/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class CategoryManager: NSObject {
    
    lazy var managedObjectContext = CoreDataManager().managedObjectContext
    var dataStored = DataStored()
    
    func checkCategoryExisted(name: String) -> Bool {
        let listCategory = dataStored.fetchRecordsForEntity("Category", inManagedObjectContext: managedObjectContext)
        for categories in listCategory {
            if let category = categories as? Category {
                if category.name == name {
                    return true
                }
            }
        }
        return false
    }
    
    func addCategory(category: CategoryModel) -> Bool {
        var id = 0
        let listCategory = dataStored.fetchRecordsForEntity("Category", inManagedObjectContext: managedObjectContext)
        if let lastCategory = listCategory.last as? Category, let idCategories = lastCategory.idCategory as? Int {
            id = idCategories + 1
        }
        if let categories = dataStored.createRecordForEntity("Category", inManagedObjectContext: managedObjectContext) as? Category {
            categories.icon = category.iconCategory
            categories.name = category.nameCategory
            categories.type = category.typeCategory
            categories.idCategory = id
            do {
                try managedObjectContext.save()
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    func addCategoryAvailale(category: CategoryModel) -> Category? {
        if let categories = dataStored.createRecordForEntity("Category", inManagedObjectContext: managedObjectContext) as? Category {
            categories.icon = category.iconCategory
            categories.name = category.nameCategory
            categories.type = category.typeCategory
            categories.idCategory = category.idCategory
            do {
                try managedObjectContext.save()
                return categories
            } catch let error {
                print(error)
            }
        }
        return nil
    }
}