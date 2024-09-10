package bakery;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.concurrent.Semaphore;
import java.util.concurrent.CountDownLatch;
public class Customer implements Runnable {
    private Bakery bakery;
    private Random rnd;
    private List<BreadType> shoppingCart;
    private int shopTime;
    private int checkoutTime;
    /**
     * Initialize a customer object and randomize its shopping cart
     */
    public Customer(Bakery bakery) { 
        this.bakery = bakery;
        this.rnd = new Random();
        this.shoppingCart = new java.util.ArrayList<BreadType>();
        this.shopTime = 1 + rnd.nextInt(3); //shop time.
        this.checkoutTime = 1 + rnd.nextInt(2); //checkout time 
    }
    /**
     * Run tasks for the customer
     */
    public void run() { 
        try{
            this.fillShoppingCart(); 
            Thread.sleep(shopTime * 1000); //simulate shop time 
            Semaphore cashierSemaphore = bakery.getCashierSemaphore();  
            cashierSemaphore.acquire();
            Thread.sleep(checkoutTime * 1000); //simulate checkout time 
            bakery.addSales(this.getItemsValue());
            cashierSemaphore.release();
            System.out.println(this + " has checked out. Total Value $ " + this.getItemsValue());
            CountDownLatch countDown = bakery.getCountDown(); 
            countDown.countDown(); //decrement the countdown
        }catch(InterruptedException ie){
            ie.printStackTrace();
        }
    }
    /**
     * Return a string representation of the customer
     */
    public String toString() {
        return "Customer " + hashCode() + ": shoppingCart=" + Arrays.toString(shoppingCart.toArray()) + ", shopTime=" + shopTime + ", checkoutTime=" + checkoutTime;
    }
    /**
     * Add a bread item to the customer's shopping cart
     */
    private boolean addItem(BreadType bread) {
        // do not allow more than 3 items, chooseItems() does not call more than 3 times
        if (shoppingCart.size() >= 3) {
            return false;
        }
        bakery.takeBread(bread);
        shoppingCart.add(bread);
        return true;
    }
    /**
     * Fill the customer's shopping cart with 1 to 3 random breads
     */
    private void fillShoppingCart() {
        int itemCnt = 1 + rnd.nextInt(3);
        while (itemCnt > 0) {
            int index = rnd.nextInt(BreadType.values().length);
            BreadType bread = BreadType.values()[index];
            Semaphore shelfAccess = bakery.getShelfSemaphore(bread);
            try{
                shelfAccess.acquire(); 
            }catch(InterruptedException ie){
                ie.printStackTrace();
            }
            addItem(bread);
            shelfAccess.release();
            itemCnt--;
        }
    }
    /**
     * Calculate the total value of the items in the customer's shopping cart
     */
    private float getItemsValue() {
        float value = 0;
        for (BreadType bread : shoppingCart) {
            value += bread.getPrice();
        }
        return value;
    } 
}
