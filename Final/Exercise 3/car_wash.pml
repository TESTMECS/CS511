#define N 3 /* Number of Washing Machines */
#define C 10 /* Number of Cars */

byte permToProcess[N];
byte doneProcessing[N];  
byte station0 = 1; byte station1 = 1; byte station2 = 1;

byte cars_in_station[N];
bool machine_working[N];

inline acquire(s) {
 atomic {
  s>0 -> s--
 }
}

inline release(s) {
 s++
}

proctype Car() {
  /* Go to station 0 */
  acquire(station0);
  atomic { cars_in_station[0]++; assert(cars_in_station[0] <= 1); }
  release(permToProcess[0]);
  acquire(doneProcessing[0]); /* wait for machine to be done */
  /* Move on to station 1 */
  acquire(station1);
  atomic { 
    cars_in_station[0]--; 
    cars_in_station[1]++; 
    assert(cars_in_station[1] <= 1);
  }
  release(station0);
  release(permToProcess[1]);
  acquire(doneProcessing[1]); /* wait for machine to be done */
  /* Move on to station 2 */
  acquire(station2);
  atomic { 
    cars_in_station[1]--; 
    cars_in_station[2]++; 
    assert(cars_in_station[2] <= 1);
  }
  release(station1);
  release(permToProcess[2]);
  acquire(doneProcessing[2]); /* wait for machine to be done */
  atomic { cars_in_station[2]--; }
  release(station2);
}

proctype Machine(int i)  { 
end1:
  do
    :: /* Wait for car to arrive */
       acquire(permToProcess[i]);
      /* Process car when it has arrived */
       atomic {
         machine_working[i] = true;
         assert(cars_in_station[i] > 0);
       }
       release(doneProcessing[i]);
       machine_working[i] = false;
  od
} 

init {
  byte i;
  for (i:0..(N-1)) {
     permToProcess[i]=0;
     doneProcessing[i]=0;
     cars_in_station[i]=0;
     machine_working[i]=false;
   }
  
 atomic {
   for (i:1 .. C ) {
     run Car();
   }
   for (i:0 ..(N-1)) {
     run Machine(i);
   }
 }
}