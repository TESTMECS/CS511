package bakery;
/* start the simulation */
public class Assignment2 {
    public static void main(String[] args) {
        Bakery bakery = new Bakery();
        Thread thread = new Thread(bakery);
        thread.start(); 
        try {
            thread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } 
    }
}
