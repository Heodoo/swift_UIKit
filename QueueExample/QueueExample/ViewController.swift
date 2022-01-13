import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var finishLabel: UILabel!
    //dispatch queue
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ timer in
            self.timerLabel.text = Date().timeIntervalSince1970.description
        }//0.1초씩 반복
    }
    
    
    @IBAction func action1(_ sender: Any) {
        simpleClosure {
            DispatchQueue.main.async {
                self.finishLabel.text = "끝"
            }
        }
    }//이런 써놓는 로직은 모두 메인스레드에서 실행됨
    
    //escaping closure 클로저가 함수의 인자로 전달됐을 때, 함수의 실행이 끝나고 클로저가 실행됨
    
    //그렇지 않은 경우(메인스레드가 아닌 형태로 실행될 떄)
    func simpleClosure(completion: @escaping () -> Void){
        DispatchQueue.global().async {
            for index in 0..<10{
                Thread.sleep(forTimeInterval: 0.2)
                //메인스레드가 멈춰버려 앱이 멈춰진것 처럼 보임
                //스레드를 여러개 만들면 해결가능->Dispatchqueue
                print(index)
            }
        }
        
        
        completion()
    }
    
    //따라서 바뀌지 않아야 할 부분이나 계속 갱신이 필요한 부분,UI작업은 메인스레드에서 작동되어야한다
    
    
    @IBAction func action2(_ sender: Any) {
        let dispatchGroup = DispatchGroup()
        
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")
        
        //async 같은 큐끼리는 다음 작업이 와도 이전 작업이 끝나야 작동가능
        //qos 우선순위
        queue1.async(group: dispatchGroup,qos: .background){
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        queue2.async(group: dispatchGroup,qos: .userInteractive){
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        queue3.async(group: dispatchGroup){
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 20..<30 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        //수동으로 쓰레드 조절 enter() 와 leave(), 둘이 개수를 꼭 맞춰야함 leave()가 하나비면 계속 메모리를 차지 할 수 있음
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }

    }
    
    
    @IBAction func action3(_ sender: Any) {
        let queue1 = DispatchQueue(label: "q1")
        //let queue2 = DispatchQueue(label: "q2")
        
        
        
        //sync를 사용하면 이전작업이 다 락이 걸림, 작업이 끝날때까지 기다림, 요즘엔 sync를 잘 사용안함
        //sync는 언제 사용하냐 -> 순차적으로 작업을 해야하는데 락을 걸어야 할떄
        //B:
        queue1.sync{
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            
            //Deadlock -> 상대 작업이 끝날떄까지 서로 계속 기다리는 상황
            /*
             //A:
            queue1.sync{
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
            }*/
            //B가 끝나야 A가 실행가능한데 A는 작업을 기다리고 있으므로 B가 끝나지 않음
        }
        
        queue1.sync{
            for index in 10..<20 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            
        }
        //sync는 다른 작업을 멈추고 작업을 사용할 필요가 있을때만 사용을 하자
    }
    
}

