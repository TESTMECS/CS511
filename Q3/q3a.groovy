
/*
Quiz 3 - Part 1/2 - 14 Jun 2024

You may not add print statements nor additional semaphores.
Add ONLY acquire and release operations to the following code so that the output is:

aabc aabc aabc....

*/

import java.util.concurrent.Semaphore;
Semaphore a = new Semaphore(2);
Semaphore b = new Semaphore(0);
Semaphore c = new Semaphore(0);



Thread.start { // P
    while (true) {
      a.acquire();
      print("a");
      if(a.availablePermits() == 0) {
        b.release();
      }
    }
}

Thread.start { // Q
    while (true) {
      b.acquire();
      print("b")
      c.release();
    }
}


Thread.start { // R

    while (true) {
      c.acquire();
	    print("c");
      a.release();
      a.release();
    }
}
