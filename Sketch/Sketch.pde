
float lastMouseMillis;
float millis; // The value of millis() at the beginning of draw()

void setup() {
    size(displayWidth, displayHeight);
    setupGUI();

    changeState(new IntroState());

    lastMouseMillis = millis();

    // setupOsc();
}

void draw() {
    millis = millis();
    background(122);

    drawGUI();

    if (millis - lastMouseMillis > CFG_SWITCH_INTRO_SECONDS * 1000) {
        if (!getStateName().equals("IntroState") ) {
            changeState(new IntroState());
        }
    }
    drawState();
}

void drawGUI() {
    if (SHOW_GUI) {
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

    if (key == 'g') SHOW_GUI = !SHOW_GUI;
}

void mouseReleased() {
    lastMouseMillis = millis;
}
