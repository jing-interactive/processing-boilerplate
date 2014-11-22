public class IntroState extends State {
    float idleStartMillis;
    void enter() {
        idleStartMillis = millis;
    }

    void quit() {
    }

    void draw() {
        ellipse(noise(millis*0.001) * width, noise(millis*0.002) * height, 20, 20);
        if (lastMouseMillis > idleStartMillis) {
            changeState(new MenuState());
        }
    }
}
