https://medium.com/shakuro/introduction-to-ios-concurrency-a5db1cf18fa6

#   What Is a Dispatch Queue?

Dispatch Queues. As we'll see, they allow you to easily send executable blocks of code to a BACKGROUND thread without the overhead associated with creating and managing those threads yourself.

 What is a queue? A queue is basically line. If you've ever studies data structures you would probably describe a queue as a First In, First Out data structure.
     
    So what are dispatch queues? Well first of all, they're queues. They're First In, First Out data structures that store chunks of code that need to be executed. Those chunks of code are most often stored as blocks in the queue.
 
 There are two types of dispatch queues:
   serial queues and concurrent queues. Serial queues execute one task at a time, while concurrent queues are capable of executing multiple tasks at once.

 In most cases the blocks of code you add to a dispatch queue will execute on a thread other than the one that added the block to the queue. The most common scenario is that you will add blocks to a dispatch queue from the main UI thread so that the work can be performed on a background thread leaving the main thread free to respond to additional user input.

# Serial Queues 
 
- Create your own serial queues;
- Even though the task in an individual serial queue only executes one at a time, they are still executing on a background thread. The user interface of your app will remain responsive while the tasks execute one after the other.
-  Another important point is that the tasks only execute serially with respect to the other tasks in the queue. 

you will normally have a very specific reason for using a serial queue instead of a concurrent queue.
- One reason to use a serial queue, is to serialize access to some shared resource. This is a way of preventing race conditions.

- Another reason you might choose to use a serial queue instead of a concurrent queue is to definitively control the order in which the tasks finish. Tasks added to any dispatch queue will begin executing in the same order they were added to the queue, but that doesn't mean they will complete their execution in that order. Some may take longer than others to complete, however, the amount of time any task in a serial queue takes to execute is irrelevant since the next task will never begin executing until the previous one has completed.

# Concurrent Queues

Concurrent or multithreaded, when the system pulls a closure at the top of the queue and initiates its execution in a certain thread.

Let's now talk about concurrent dispatch queues. Blocks of code added to concurrent queues will still begin their execution in the same order they were added to the queue, however, they will execute concurrently with respect to the other blocks in the same queue. The operating system will manage all of the underlying threads required to execute as many blocks as possible, as efficiently as possible. Let's return to our ticket booth example. This time we have three ticket booths, which you can think of as three threads available to perform work. The operating system can now pull as many blocks from the front of the queue as it can efficiently execute at one time. We can't know how long a given block will take to execute, but as they complete and the system has more resources available, it will continue removing blocks from the queue and sending them to available threads. Concurrent queues have similarities and differences with respect to serial queues. One difference is that you don't have to create your own concurrent queues. You can if you need to, but you should be able to accomplish just about anything you need to do with one of the four global queues available to each app. You simple call the dispatch_get_global_queue function to get a reference to one of the available global queues. The first parameter you pass to that function is one of these constants, which specify the particular queue you want. The four queues differ only in their execution priority. Obviously, the system will attempt to execute items in the high priority queue before those in the default, or low priority queues, and so forth. The background queue has the lowest priority of all of the global queues. Like serial queues, all of the blocks in the queue will be executed on background threads, helping keep your user interface responsive. As I've already stated, the primary difference between serial and concurrent queues is that the items in a concurrent queue will execute concurrently with respect to the other items in the queue. However, the exact number of tasks that can execute at any given time is variable and managed by the system. It's dependent on a lot of factors such as the number of cores available, memory, and other tasks occurring in the app.

Highest priority:
let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let utilityQueue = DispatchQueue.global(qos: .utility)

Lowest priority:
let backgroundQueue = DispatchQueue.global(.background)
