# To-Do-List---SwiftUI
SwiftUI - To Do List 

Create Item with Codable 

struct TodoItem: Codable, Identifiable {
    var id = UUID()
    let todo: String
}


Save with Encode

UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allTodos), forKey: "todosKey")


Load List 

if let todosData  = UserDefaults.standard.value(forKey: "todosKey") as? Data {
    if let todosList = try? PropertyListDecoder().decode(Array<TodoItem>.self, from: todosData) {
       self.allTodos = todosList
    }
}

Remove with offsets

self.allTodos.remove(atOffsets:  offsets)


Inside -> NavigationView -> VStack -> HStack -> TextField and Button
Inside -> NavigationView -> List with Delete Func

Enjoy Learning! Changes
