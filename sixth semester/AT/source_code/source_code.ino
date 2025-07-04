#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

const int btnStop = 3;  
const int btnStart = 4; 

bool isRunning = false;
unsigned long startTime;
float elapsedTime = 0.0;

void setup() {
    lcd.init();
    lcd.backlight();

    pinMode(btnStop, INPUT_PULLUP);
    pinMode(btnStart, INPUT_PULLUP);

    showStartScreen();
}

void loop() {
    unsigned long currentMillis = millis();

    if (!isRunning && digitalRead(btnStart) == LOW) {
        isRunning = true;
        startTime = millis();
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("Stop at 5 sec!");
        delay(300);
    }

    if (isRunning) {
        elapsedTime = (millis() - startTime) / 1000.0;

        lcd.setCursor(0, 1);
        lcd.print("Time: ");
        lcd.print(elapsedTime, 2);
        lcd.print("s ");
    }

    if (isRunning && digitalRead(btnStop) == LOW) {
        isRunning = false;
        showFinalTime();
        delay(2000);
        showStartScreen();
    }
}

void showStartScreen() {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Stop at 5 sec!");
    lcd.setCursor(0, 1);
    lcd.print("D4=Start D3=Stop");
}

void showFinalTime() {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Stopped at:");
    lcd.setCursor(0, 1);
    lcd.print(elapsedTime, 2);
    lcd.print("s ");
}
