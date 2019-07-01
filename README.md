# Activity_2_IOS_Watch
## Student id: C0735979
## NAME: Alay Desai
## Student id: C0737805
## NAME: Dhyanee Bhatt
## Q1> On the IOS side, what function is used to receive messages from the watch?
## Ans: session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void)
## Q2> When receiving messages from the watch, you need to use a closure function. What is the reason why a closure is used?
## Ans: the closure contains the error handling code, so when you encounter an error before receiving the message then the closure will run the error haldling code inside it.
