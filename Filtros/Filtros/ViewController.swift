//
//  ViewController.swift
//  Filtros
//
//  Created by Miguel Muñoz on 11/28/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit

struct Personas {
    let nombre : String
    let genero : String
}

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var personasDatos = [Personas]() //Trae la informacion TODOS
    var personasCeldaFiltro = [Personas]() //Mostrar los datos con un filtro y reacer las celdas
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let val1 = Personas(nombre: "Pedro", genero: "Hombre")
        personasDatos.append(val1)
        
        let val2 = Personas(nombre: "Luis", genero: "Hombre")
        personasDatos.append(val2)
        
        let val3 = Personas(nombre: "Mario", genero: "Hombre")
        personasDatos.append(val3)
        
        let val4 = Personas(nombre: "Maria", genero: "Mujer")
        personasDatos.append(val4)
        
        let val5 = Personas(nombre: "Luz", genero: "Mujer")
        personasDatos.append(val5)
        
        let val6 = Personas(nombre: "Dulce", genero: "Mujer")
        personasDatos.append(val6)
        
        let val7 = Personas(nombre: "Gaby", genero: "Mujer")
        personasDatos.append(val7)
        
        let val8 = Personas(nombre: "Ana", genero: "Mujer")
        personasDatos.append(val8)
        
        personasCeldaFiltro = personasDatos
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personasCeldaFiltro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let persona = personasCeldaFiltro[indexPath.row]
        
        cell.textLabel?.text = persona.nombre
        cell.detailTextLabel?.text = persona.genero
        
        return cell
        
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //Filtro sin opciones
        /*guard !searchText.isEmpty else {
            personasCeldaFiltro = personasDatos
            DispatchQueue.main.async {
                self.tabla.reloadData()
            }
            return
        }
        
        personasCeldaFiltro = personasDatos.filter({ (persona) -> Bool in
            persona.nombre.lowercased().contains(searchText.lowercased())
        })
        
        DispatchQueue.main.async {
            self.tabla.reloadData()
        }*/
        
        personasCeldaFiltro = personasDatos.filter({ (persona) -> Bool in
            
            switch search.selectedScopeButtonIndex{
            case 0 :
                
                if searchText.isEmpty {return true}
                
                return persona.nombre.lowercased().contains(searchText.lowercased())
                
            case 1 :
                
                if searchText.isEmpty {return persona.genero == "Mujer"}

                return persona.nombre.lowercased().contains(searchText.lowercased()) && persona.genero == "Mujer"
                
            case 2 :
                
                if searchText.isEmpty {return persona.genero == "Hombre"}
                
                return persona.nombre.lowercased().contains(searchText.lowercased()) && persona.genero == "Hombre"
                
            default :
                return false
            }
            
        })
        
        DispatchQueue.main.async {
            self.tabla.reloadData()
        }
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope {
        case 0:
            personasCeldaFiltro = personasDatos
        case 1:
            personasCeldaFiltro = personasDatos.filter({ (persona) -> Bool in
                persona.genero == "Mujer"
            })
        case 2:
            personasCeldaFiltro = personasDatos.filter({ (persona) -> Bool in
                persona.genero == "Hombre"
            })
        default:
            print("Nada mas")
        }
        
        DispatchQueue.main.async {
            self.tabla.reloadData()
        }
        
    }
    

}

