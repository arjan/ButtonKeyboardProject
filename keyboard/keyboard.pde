/* Arduino USB Keyboard HID 
 *
 * Developed for an installation by Prayas Abhinav
 *
 * Copyright (c) 2011 Arjan Scherpenisse <arjan@miraclethings.nl>
 *
 * Released in the public domain.
 */

uint8_t buf[8] = { 0 };	/* Keyboard report buffer */

void setup();
void loop();

//#define READMASK 31 // inputs 2-7
#define READMASK 5 // inputs 2,4

const char keyMapping[5] = 
{
    0x07, // d
    0x1a, // w
    0x04, // a
    0x16, // s
    0x2c  // space bar
};

char keyState[5];


void setup() 
{
    Serial.begin(9600);
    for (int i=0; i<5; i++) {
        keyState[i] = 0;
        if ((1<<i)&READMASK) {
            pinMode(2+i, INPUT);
        }
    }
    delay(200);
}


void doRead(int i)
{
    char v = digitalRead(2+i);
    
    if (v == keyState[i]) {
        // nothing changed
        return;
    }

    keyState[i] = v;
    if (keyState[i]) {
        buf[2] = keyMapping[i];
    }
    else {
        buf[2] = 0; // key release
    }
	Serial.write(buf, 8);	// Send keypress
    
    // Serial.print(i);
    // Serial.print(keyState[i] ? " ON  " : " off ");
    // Serial.println("");
}

void loop() 
{
    delay(50);
    for (int i=0; i<5; i++) {
        if ((1<<i)&READMASK) {
            doRead(i);
        }
    }
}
