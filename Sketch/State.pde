import java.lang.reflect.Field;
import java.lang.annotation.Annotation;
import controlP5.*;

void fillScreen(color clr) {
    fill(clr);
    noStroke();
    rect(0, 0, width, height);
}

public class State {
    float mStartMS;

    float elapsedSec() {
        return (millis() - mStartMS) * 0.001;
    }

    void enter() {
    }

    void quit() {
    }

    void draw() {
    }

    void fadeTo(String varName, float duration, float delay, float targetValue) {
        Ani.to(this, duration, delay, varName, targetValue, Ani.LINEAR);
    }

    void fadeInAlpha(String varName, float duration, float delay) {
        fadeTo(varName, duration, delay, 255);
    }

    void fadeInAlpha(String varName, float duration) {
        fadeInAlpha(varName, duration, 0);
    }

    void fadeOutAlpha(String varName, float duration, float delay) {
        fadeTo(varName, duration, delay, 0);
    }

    void fadeOutAlpha(String varName, float duration) {
        fadeOutAlpha(varName, duration, 0);
    }

    void applyAlpha(float alpha) {
        if (alpha < 254) {
            tint(255, alpha);
        }
    }

    float alphaEverything;
    void tryFadeOutEverything(float sec, float duration) {
        if (sec > duration - 3 && alphaEverything > 254) {
            println("sec: " + sec);
            alphaEverything = 254;
            fadeOutAlpha("alphaEverything", 3);
        }
        if (alphaEverything < 254) {
            fillScreen(color(0, 255 - alphaEverything));
        }
    }

    void defaultAlpha() {
        tint(255);
    }

    void postDraw() {
        if (keyPressed) {
            if (key == '1') {
                isControlVisible = true;
            } else if (key == '2') {
                isControlVisible = false;
            }
        }
        if (false && isControlVisible) {
            if (cp5 == null) {
                cp5 = new ControlP5(self);
                cp5.setAutoDraw(false);

                for (Field field : getClass().getDeclaredFields()) {
                    for (Annotation annotation : field.getAnnotations()) {
                        println("name: " + field.getName() + " type: " + field.getType());
                        if (annotation instanceof Parameter) {
                            Parameter param = (Parameter) annotation;
                            println("\tmin: " + param.min());
                            println("\tmax: " + param.max());

                            // field.setAccessible(true);
                            // Object value = field.get(this);
                            // float val = ((Float)value).floatValue();

                            // addGUIValue(field.getName(), val, param.min(), param.max());
                        }
                    }
                }
            }
            cp5.draw();

            for (Field field : getClass().getDeclaredFields()) {
                for (Annotation annotation : field.getAnnotations()) {
                    if (annotation instanceof Parameter) {
                        // addGUIValue(field.getName(), param.min(), param.max());
                    }
                }
            }
        }
    }

    float sliderY = 10;
    Slider addGUIValue(String name, float value, float minValue, float maxValue) {
        return cp5.addSlider(name)
               .setPosition(10, sliderY += 30)
               .setRange(minValue, maxValue)
               .setWidth(200)
               //          .setForeground(color(0, 0, 0))
               ;
    }

    ControlP5 cp5;
    boolean isControlVisible = false;
}

State currentState;

private float lastFrameMilli = 0;
float deltaTimeSec = 0;
// call me from draw()
void drawState() {
    currentState.draw();
    currentState.postDraw();

    deltaTimeSec = (millis() - lastFrameMilli) * 0.001;
    lastFrameMilli = millis();
}

String getStateName() {
    return currentState.getClass().getSimpleName(); // Java reflection is sweet :)
}

// call me when app needs to change its state
void changeState(State newState) {
    float startChangeMillis = millis();
    if (currentState != null) {
        println("- " + getStateName());
        currentState.quit();
        println("- cost " + (millis() - startChangeMillis) + " ms");
        // System.gc();
    }
    currentState = newState;
    println("+ " + getStateName());
    currentState.alphaEverything = 255;
    currentState.enter();
    currentState.mStartMS = millis();
    println("Total cost " + (currentState.mStartMS - startChangeMillis) + " ms");
    lastFrameMilli = millis();
}

