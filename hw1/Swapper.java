
public class Swapper implements Runnable {
    private int offset;
    private Interval interval;
    private String content;
    private char[] buffer;

    public Swapper(Interval interval, String content, char[] buffer, int offset) {
        this.offset = offset;
        this.interval = interval;
        this.content = content;
        this.buffer = buffer;
    }

    @Override
    public void run() {
        // TODO: Implement me!
        int start = interval.getX();
        int end = Math.min(interval.getY(), content.length() - 1);
        for(int i = start; i <= end; i++){
            buffer[offset + (i - start)] = content.charAt(i);
        }
    }
}
