import UIKit

protocol InterchangeViaElevatorProtokol {
    func cookOrder(order: String) -> Bool
}

class Waiter {
    
    var receiverOfOrderViaElevator: InterchangeViaElevatorProtokol?
    var order: String?
    
    func takeOrder(_ food: String) {
        print("What would you like?")
        print("Yes, of cource we have \(food)!")
        order = food
        sendOrderToCook()
    }
    
    private func sendOrderToCook() {
        //Добавим вызов метода cookOrder у нашего "получателя заказов через лифт":
        receiverOfOrderViaElevator?.cookOrder(order: order!)
    }
    
    private func serveFood() {
        print("Your \(order!). Enjoy your meal!")
    }
    
}

// Создаем класс шеф-повара
class Chief: InterchangeViaElevatorProtokol {
    
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
    
    // Шеф-повар умеет нанимать официантов в свое кафе:
    func hireWaiter() -> Waiter {
        return Waiter()
    }
    
}

// Создаем экземпляр шеф-повара (шеф-повар открывает кафе):
let chief = Chief()

// Шев-повар нанимает официанта:
let waiter = chief.hireWaiter()

// Добавим официанту заказ:
waiter.takeOrder("Chiken")

//Далее все по старинке:
// Обучаем официанта, что его "получатель заказа через лифт" - это наш шеф-повар:
waiter.receiverOfOrderViaElevator = chief
// Теперь официант может нашего "получателя заказа через лифт" попросить приготовить заказ:
waiter.receiverOfOrderViaElevator?.cookOrder(order: waiter.order!)



// Отлично, теперь представим, что появился новый шеф-повар, который рассказывает официанту еще при найме на работу, что его получателем заказа через лифт будет сам шеф-повар.

class SmartChief: Chief {
    
    override func hireWaiter() -> Waiter {
        let waiter = Waiter()
        waiter.receiverOfOrderViaElevator = self // Сразу же настраивает официанту свойство получателя заказа через лифт
        return waiter
    }
    
}

//: Таким образом, нет необходимости как-то отдельно указывать официанту, кто его получатель заказа через лифт. Он с самого начала работы уже об этом знает.

let smartChief = SmartChief()
let smartWaiter = smartChief.hireWaiter()
smartWaiter.takeOrder("Fish")
/*
 What would you like?
 Yes, of cource we have Fish!
 Let's take a pan
 Let's put Fish on the pan
 Let's put the pan on the stove
 Wait a few minutes
 Fish is ready!
 */


/// Класс талантливого официанта
class TalentedWaiter {
    
    var order: String?
    
    // Добавим опциональное свойство функционального  типа. Это функция, которая принимает на вход аргумент с типом String и возвращает результат с типом Bool.
    var doEverything: ((String) -> Bool)?
    
    func takeOrder(_ food: String) {
        print("What would you like?")
        print("Yes, of cource we have \(food)!")
        order = food
        // Вместо передачи заказа шев-повару официант попытается сделать сам:
        doOwnself()
    }
    
    private func doOwnself() -> Bool {
        // Если инструкция существует, то он ее выполнит:
        if let doEverything = doEverything {
            let doOwnself = doEverything(order!)
            return doOwnself
        } else {
            return false
        }
    }
    
}

// Создаем класс ленивого шев-повара
class LazyChief {
    
    private let pan: Int = 1
    private let stove: Int = 1
    
    private func cookFood(_ food: String) -> Bool {
        print("I have \(pan) pan")
        print("Let's put \(food) on the pan!")
        print("I have \(stove) stove. Let's put the pan on the stove!")
        print("Wait a few minutes...")
        print("\(food) is ready!")
        return true
    }
    
    // Умение нанимать талантливых официантов:
    func hireWaiter() -> TalentedWaiter {
        let talentedWaiter = TalentedWaiter()
        
        // Повар учит официанта готовить самому. Он передает ему инструкцию в виде замыкания, в котором прописывает свой собственный метод cookFood:
        talentedWaiter.doEverything = { [weak self] order in
            self!.cookFood(order)
        }
        return talentedWaiter
    }
    
}

let lazyChief = LazyChief()
let talentedWaiter = lazyChief.hireWaiter()
talentedWaiter.takeOrder("Meat")
/*
 What would you like?
 Yes, of cource we have Meat!
 I have 1 pan
 Let's put Meat on the pan!
 I have 1 stove. Let's put the pan on the stove!
 Wait a few minutes...
 Meat is ready!
 */

