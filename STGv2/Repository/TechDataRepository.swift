//
//  TechDataRepository.swift
//  STGv2
//
//  Created by Daniil Savva on 28.10.2022.
//

import CoreData

class TechDataRepository {
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    public func getAccessToken() -> String? {
        
        var isAccessTokenRowExist: Bool = false
        
        do {
            let techDatas: [TechData] = try self.context.fetch(TechData.fetchRequest())
            if techDatas.count == 0 {
                //print("Нет записей")
            }
            
            for techData in techDatas {
                //print("techdata (\(techData as AnyObject).name): (\(techData as AnyObject).value as Any)")
                
                if techData.name == "access_token" {
                    isAccessTokenRowExist = true
                    return techData.str_value
                }
                
                /*
                if (techData as AnyObject).name == "access_token" {
                    isAccessTokenRowExist = true
                    if (techData as AnyObject).str_value != nil {
                        //return (techData as AnyObject).value
                    }
                }
                 */
            }
            
            if !isAccessTokenRowExist {
                if self.add(name: "access_token", value: nil) {
                    
                }
            }
             
        } catch {
            return nil
        }
        return nil
    }
    
    public func isAccessTokenExist() -> Bool {
        do {
            let techDatas: [TechData] = try self.context.fetch(TechData.fetchRequest())
            
            if techDatas.count == 0 {
                return false
            }
            
            for techData in techDatas {
                if (techData as AnyObject).name == "access_token" {
                    let jwt : String = (techData as AnyObject).str_value ?? ""
                    if jwt != "" {
                        //print("isAccessTokenExist jwt: \((techData as AnyObject).str_value)")
                        return true
                    }
                }
            }
             
        } catch {
            return false
        }
        return false
    }
    
    
    private func add(name: String, value: String?) -> Bool{
        let newTechData = TechData(context: self.self.context)
        
        newTechData.name = name
        newTechData.str_value = value
        
        do {
            try self.self.context.save()
            return true
        } catch {
            return false
        }
    }
    
    
    public func updateAccessToken(value: String?) -> Bool {
        self.checkExistRowDataInsertIfNot()
        
        do {
            let techDatas: [TechData] = try self.context.fetch(TechData.fetchRequest())
            
            for techData in techDatas {
                if (techData as AnyObject).name == "access_token" {
                    //(techData as TechData).setValue(value, forKey: "str_value")
                    (techData as TechData).str_value = value
                    try! self.self.context.save()
                    return true
                }
            }
            
        } catch {
            return false
        }
        return false
    }
    
    
    private func checkExistRowDataInsertIfNot(){
        do {
            let techDatas: [TechData] = try self.context.fetch(TechData.fetchRequest())
            if techDatas.count == 0 {
                if self.add(name: "access_token", value: nil) { }
                return
            }
            
            for techData in techDatas {
                if (techData as AnyObject).name == "access_token" {
                    return
                }
            }
            
            if self.add(name: "access_token", value: nil) { }
             
        } catch {
            return
        }
        return
    }
}
