// TODO: data driven
// Save config per State

import controlP5.*;

ControlP5 cp5;

float sliderY = 10;
void addValue(String name, float maxValue) {
    cp5.addSlider(name)
    .setPosition(10, sliderY += 30)
    .setRange(0, maxValue)
    .setWidth(200)
    //          .setForeground(color(0, 0, 0))
    ;
    ;
}

void loadConfig() {
    println("loading config");
    String[] items = loadStrings("config.txt");
    if (items.length > 0) {
        int idx = 0;

        // BODY_COUNT = float(items[idx++]);
        // MAX_AGE = float(items[idx++]);
    } else {
        saveConfig();
    }
}

void saveConfig() {
    String[] items = new String[11];
    int idx = 0;

    // items[idx++] = "" + BODY_COUNT;
    // items[idx++] = "" + MAX_AGE;

    saveStrings("config.txt", items);
}

void setupGUI() {
    cp5 = new ControlP5(this);
    cp5.setAutoDraw(false);

    // addValue("BODY_COUNT", 500);
    // addValue("MAX_AGE", 10);

    sliderY += 60;

    cp5.addBang("SAVE")
    .setPosition(10, sliderY += 60)
    .setWidth(200)
    ;
}

void SAVE() {
    saveConfig();
}
