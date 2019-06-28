
import Foundation

var  ToDoList: [[String: Any]] = [["Name": "Приготовить суп Харчо", "IsCompleted": false], ["Name": "Выкинуть мусор", "IsCompleted": false], ["Name": "Отнести посуду на мойку", "IsCompleted": false]]

// Функция., которая отвечает за добавление новой заметки
func addItem(nameItem: String, IsCompleted: Bool = false){
    ToDoList.append(["Name": nameItem, "IsCompleted": IsCompleted])
    saveData()
}

// Функитя которая удаляет заметку
func removeItem(at index: Int){
    ToDoList.remove(at: index)
    saveData()
}

// Функция слхраняет даныне
func saveData() {
    UserDefaults.standard.set(ToDoList, forKey: "ToDoDataKey")
    UserDefaults.standard.synchronize()
}

// Функция которая загружает даннные
func loadData()  {
    if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]]{
        ToDoList = array
    } else{
        ToDoList = []
    }
    
}

func changeState(at item: Int) -> Bool{
    ToDoList[item]["IsCompleted"] = !(ToDoList[item]["IsCompleted"] as! Bool)
    saveData()
    
    return ToDoList[item]["IsCompleted"] as! Bool
}


func moveItem(fromIndex: Int, toIndex: Int){
    let from = ToDoList[fromIndex]
    ToDoList.remove(at: fromIndex)
    ToDoList.insert(from, at: toIndex)
}
