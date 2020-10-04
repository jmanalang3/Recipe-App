//
//  RecipeTypeXML.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import Foundation

class RecipeTypeXML: NSObject, XMLParserDelegate {
    
    var recipeTypes: [RecipeType] = []
    
    private var elementName: String = ""
    private var title: String = ""
    
    enum Value: String {
        case elementName = "type"
        case title = "title"
    }
    
    init(contentsOf path: URL) {
        super.init()
        guard let parser = XMLParser(contentsOf: path) else {
            return
        }
        parser.delegate = self
        parser.parse()
    }
    
}

extension RecipeTypeXML {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        guard elementName == Value.elementName.rawValue else {
            return self.elementName = elementName
        }
        title = String()
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?) {
        guard elementName == Value.elementName.rawValue else {
            return
        }
        let type = RecipeType(title: title)
        recipeTypes.append(type)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        guard data.isEmpty == false, self.elementName == Value.title.rawValue  else {
            return
        }
        title += data
        
    }
    
}
