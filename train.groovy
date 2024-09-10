import java.util.concurrent.Semaphore

Semaphore permToLoad = new Semaphore(0)
Semaphore doneLoading = new Semaphore(0)
// Additional semaphores
Semaphore northTrack = new Semaphore(1)
Semaphore southTrack = new Semaphore(1)
Semaphore station = new Semaphore(1)


100.times {
    int dir = (new Random()).nextInt(2) 
    Thread.start { // PassengerTrain travelling in direction dir
	// complete
    if (dir == 0){
        northTrack.acquire() // passenger train on north south track. 
        println "Passenger Train on N-S Track"
        //stopping at station
        station.acquire()
        println "Passenger Train at station"
        Thread.sleep(20)
        station.release()
        println "Passenger Train leaving Station" 
        northTrack.release()
    } else{
        southTrack.acquire()
        println "Passenger Train on S-N Track"
        station.acquire()
        println "Passenger Train at station"
        Thread.sleep(20)
        station.release()
        println "Passenger Train leaving Station"
        southTrack.release()
    }
    }
}

100.times {
    int dir = (new Random()).nextInt(2);
    Thread.start { // Freight Train travelling in direction dir
	// complete
    if(dir == 0){
        northTrack.acquire()
        println "Freight Train on N-S Track"
        station.acquire()
        println "Freight train arriving at station"
        permToLoad.release()
        doneLoading.acquire()
        println "Freight train leaving station"
        station.release()
        northTrack.release()
    }else{
        southTrack.acquire()
        println "Freight Train on S-N Track"
        station.acquire()
        println "Freight Train arriving at station"
        permToLoad.release()
        doneLoading.acquire()
        println "Freight Train leaving station"
        station.release()
        southTrack.release()
    }
    
    
    
    }
}

Thread.start { // Loading Machine
    while (true) {
	permToLoad.acquire();
    println "loading machine loading...."
	// load freight train
    Thread.sleep(20)
    println "loading machine finished loading"
	doneLoading.release();  
    }
}
