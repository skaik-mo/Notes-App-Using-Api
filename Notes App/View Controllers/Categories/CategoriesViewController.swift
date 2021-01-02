//
//  CategoriesViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoriesTbleView: UITableView!
    
    private var categories: [Category] = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.'
        initializeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indexCategory()
    }
    
    private func initializeView(){
        navigation()
        initializeTableView()
    }
    
    private func navigation(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Quicksand-Medium", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor(named: "474559")!]
    }
    
    @IBAction func settingAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func newCategoryAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewCategoryViewController") as! NewCategoryViewController
        vc.isUpdate = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate, CategoryProtocol{
    
    private func initializeTableView(){
        categoriesTbleView.dataSource = self
        categoriesTbleView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryDelegate = self
        cell.setData(category: categories[indexPath.row])
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        vc.category = categories[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            delete(indexPath: indexPath)
        }
    }
    
    func editCategory(titleCategory: String, descriptionCategory: String, index: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewCategoryViewController") as! NewCategoryViewController
        vc.isUpdate = true
        vc.category = categories[index]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteCategory(indexPath: IndexPath){
        delete(indexPath: indexPath)
    }
    
    private func delete(indexPath: IndexPath) {
        if let id = categories[indexPath.row].id {
            ApiCategory.init().delete(id: id) { (status, message) in
                if status{
                    self.indexCategory()
                }
            }
        }
    }
    
    private func indexCategory(){
        ApiCategory.init().indexCategories { (status, categories) in
            if status{
                self.categories = categories
                self.categoriesTbleView.reloadData()
                UserData.setCategoriesCount(categories_count: categories.count)
            }
        }
    }

    
}
