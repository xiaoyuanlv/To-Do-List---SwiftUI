//
//  ContentView.swift
//  To Do List
//
//  Created by Xiao Yuan on 1/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newToDo = ""
    @State private var allTodos : [TodoItem] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add todo ...", text: $newToDo).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        guard !self.newToDo.isEmpty else { return }
                        self.allTodos.append(TodoItem(todo: self.newToDo))
                        self.newToDo = ""
                        self.saveTodos()
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding(.leading, 5)
                }.padding()
                
                List {
                    ForEach(allTodos) { todoItem in
                        Text(todoItem.todo)
                    }.onDelete(perform: deleteTodo)
                }
                
            }
            .navigationTitle("Todos")
        }.onAppear(perform: loadTodos)
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        self.allTodos.remove(atOffsets:  offsets)
        saveTodos()
    }
    
    private func loadTodos() {
        if let todosData  = UserDefaults.standard.value(forKey: "todosKey") as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<TodoItem>.self, from: todosData) {
                self.allTodos = todosList
            }
        }
    }
    
    private func saveTodos() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allTodos), forKey: "todosKey")
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TodoItem: Codable, Identifiable {
    var id = UUID()
    let todo: String
}
