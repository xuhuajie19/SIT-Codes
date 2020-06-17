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
        int p = interval.getX();
        int q = interval.getY();
        int tmp = offset;
        for (int i=p;i<=q;i++) {
            buffer[tmp]=content.charAt(i);
            tmp++;
        }
    }
}