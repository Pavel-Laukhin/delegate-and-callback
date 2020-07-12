import UIKit

protocol InterchangeViaElevatorProtokol {
    func cookOrder(order: String) -> Bool
}

class Waiter {
    
    // Далее официанту добаим свойство "получатель заказа через лифт". Официанту известно, что этот получатель знает правила и приготовит то, что в записке.
    var receiverOfOrderViaElevator: InterchangeViaElevatorProtokol?
    
    var order: String?
    
    func takeOrder(_ food: String) {
        print("What would you like?")
        print("Yes, of cource!")
        order = food
        sendOrderToCook()
    }
    
    private func sendOrderToCook() {
        // ??? Как передать повару заказ?
    }
    
    private func serveFood() {
        print("Your \(order!). Enjoy your meal!")
    }
    
}

// Создаем класс повара
class Cook: InterchangeViaElevatorProtokol {
    
    private let pan: Int = 1
    private let stove: Int = 1
    
    private func cookFood(_ food: String) -> Bool {
        print("Let's take a pan")
        print("Let's put \(food) on the pan")
        print("Let's put the pan on the stove")
        print("Wait a few minutes")
        print("\(food) is ready!")
        return true
    }
    
    // Необходимый метод, согласно правилу(протоколу):
    func cookOrder(order: String) -> Bool {
        cookFood(order)
    }
    
}

// Нанимаем на работу официанта и повара:
let waiter = Waiter()
let cook = Cook()

// Добавим официанту заказ:
waiter.takeOrder("Chiken")

// Теперь скажем официанту, что его "получатель заказа через лифт" - это наш повар:
waiter.receiverOfOrderViaElevator = cook

// Как уже говорилось ранее, официант знает, что этот получатель знает правила и приготовит то, что в записке.

// Теперь официант может нашего "получателя заказа через лифт" попросить приготовить заказ:
waiter.receiverOfOrderViaElevator?.cookOrder(order: waiter.order!)
/*
 What would you like?
 Yes, of cource!
 Let's take a pan
 Let's put Chiken on the pan
 Let's put the pan on the stove
 Wait a few minutes
 Chiken is ready!
 */
