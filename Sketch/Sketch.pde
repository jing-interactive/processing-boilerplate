PApplet self;

float lastMouseMillis;
float millis; // The value of millis() at the beginning of draw()

void setup() {
    self = this;
    size(displayWidth, displayHeight);
    setupGUI();

    changeState(new IntroState());

    lastMouseMillis = millis();
}

void draw() {
    millis = millis();
    background(122);

    drawGUI();

    if (millis - lastMouseMillis > SWITCH_INTRO_MILLIS) {
        if (!getStateName().equals("IntroState") ) {
            changeState(new IntroState());
        }
    }
    drawState();
}

void drawGUI() {
    if (showGUI) {
        // textFont(sysFont);
        textAlign(LEFT, BASELINE);

        fill(255);
        stroke(255);
        text("State: " + getStateName() + "\n" +
             "=g= GUI\n" +
             "=m= Menu\n" +
             "=i= Intro\n" +
             "\n" +
             "fps: " + int(frameRate), width - 200, 50);

        cp5.draw();
    }
}

void keyReleased() {
    if (key == 'm') changeState(new MenuState());
    else if (key == 'i') changeState(new IntroState());

    if (key == 'g') showGUI = !showGUI;
}

void mouseReleased() {
    lastMouseMillis = millis;
}
