//
//  ViewController.swift
//  LocalCacheExample
//
//  Created by Pradeep kumar on 19/9/23.
//

import UIKit

struct Tickets {
    let number: Int
    let name: String
}

class ViewController: UIViewController {
    
    let url = "https://saurav.tech/NewsAPI/everything/cnn.json"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // req1
        // req2
        // req3
        // req4
        // req5
        //AlgoDemoDS()

        //print("getAPIData() == \(String(describing: getAPIData()))")
        
        
        bookTickets(data)
    }
    
    let data = [Tickets(number: 3, name: "Ram"),
                Tickets(number: 2, name: "Shyam"),
                Tickets(number: 4, name: "Shiv"),
                Tickets(number: 2, name: "Laxman")]

    var totalNumber = 5
    let queue = DispatchQueue(label: "testing.semaphore", qos: .utility, attributes: .concurrent )
    let semaphore = DispatchSemaphore(value: 1)
    
    func bookTickets(_ data: [Tickets]) {
        for ele in data {
            queue.async { [weak self] in
                self?.bookTicketWithNumber(ele)
            }
        }
    }
    
    func bookTicketWithNumber(_ ticket: Tickets) {
        semaphore.wait()
        print("booking ticket for \(ticket.name)")
        sleep(1)
        if ticket.number <= totalNumber {
            totalNumber -= ticket.number
            print("successfully booked for \(ticket.name)")
        } else {
            print("unsuccessfully booked for \(ticket.name)")
        }
        semaphore.signal()
    }
    
    //without wait and signal .. will go in sequence but it may not be come in order as well
//    booking ticket for Ram
//    booking ticket for Laxman
//    booking ticket for Shiv
//    booking ticket for Shyam
//    successfully booked for Ram -- 2
//    successfully booked for Laxman -- 1
//    unsuccessfully booked for Shyam
//    successfully booked for Shiv -- 2
    
    // with wait and signal ... will go in sequenece
//    booking ticket for Ram
//    successfully booked for Ram
//    booking ticket for Shyam
//    successfully booked for Shyam
//    booking ticket for Shiv
//    unsuccessfully booked for Shiv
//    booking ticket for Laxman
//    unsuccessfully booked for Laxman
    
    
    let dispatchSema = DispatchSemaphore(value: 0)
    
    
    func getAPIData() -> [ListElement]? {
        
        var dataList : [ListElement] = []
        
        let session = URLSession.shared
        // Start async work on background thread, current function's thread
        // execution point will then immediately move to the line
        // after the closing brace
        session.dataTask(with: URL(string: url)!) { [weak self] data, response, error in
            if let error = error {
                print(error.localizedDescription)
                self?.dispatchSema.signal()
            }
            if let data = data {
                do {
                    let list = try JSONDecoder().decode(ListData.self, from: data)
                    print(list.articles.count)
                    dataList = list.articles
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            // Tell the original function's thread that it is OK to continue
            self?.dispatchSema.signal()
        }
        .resume()
        
        //Decrement the counting semaphore. If the resulting value is less than zero, this function waits for a signal to occur before returning.
        // so by default you have to give 0 as default value for semaphore.
        dispatchSema.wait()
        
        // Once the semaphore.signal() call happens in the async closure execution
        // resumes, and the response variable can now be returned with the updated
        // value.
        return dataList
    }

}

struct ListData: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ListElement]
}

struct ListElement: Decodable {
    let author: String?
    let title: String?
    let description: String?
}


class FailureHandler {
    
    var taskDetails: [TaskDetails] = []

    func addTask(_ task: TaskDetails) {
        taskDetails.append(task)
        task.increaseRetry()
    }
    
    func timer() {
        // will run for every 10 second
        //10
        //30
        //40
        //10
        //1000
    }
    
    
    func checkCurrentFailedJobs() {
        for task in taskDetails {
            // calculate
            print(task)
        }
    }
}


class TaskHandler {
    
    let session: URLSession
    let taskDetails: TaskDetails
    
    init(session: URLSession, taskDetails: TaskDetails) {
        self.session = session
        self.taskDetails = taskDetails
        sendData()
    }
    
    var completionHandler: ((Result<Bool, Error>) -> Void)?
    
    func sendData() {
        var taskDemo = session.dataTask(with: taskDetails.url) { [weak self] data, response, error in
            guard let this = self else { return }
            if error != nil {
                this.completionHandler?(.failure(error!))
            }
            this.completionHandler?(.success(true))
        }
        
        //t/askDemo.ca
        
        
    }
    
}


class TaskDetails: Hashable {
    
    static func == (lhs: TaskDetails, rhs: TaskDetails) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(url)
    }
    
    let url: URL
    var params: [String: String] = [:]
    var retryCount = 1
    
    init(url: URL, params: [String : String] = [:]) {
        self.url = url
        self.params = params
    }
    
    func increaseRetry() {
        retryCount *= 2
    }
}
