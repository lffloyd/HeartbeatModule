

#define PROCESSING_VISUALIZER 1
#define SERIAL_PLOTTER  2

//  Variables
int pulsePin = 0;                 // Pulse Sensor purple wire connected to analog pin 0
int blinkPin = 13;                // pin to blink led at each beat
int fadePin = 5;                  // pin to do fancy classy fading blink at each beat
int fadeRate = 0;                 // used to fade LED on with PWM on fadePin



// Volatile Variables, used in the interrupt service routine!
volatile int BPM;                   // int that holds raw Analog in 0. updated every 2mS
volatile int Signal;                // holds the incoming raw data
volatile int IBI = 600;             // int that holds the time interval between beats! Must be seeded!
volatile boolean Pulse = false;     // "True" when User's live heartbeat is detected. "False" when not a "live beat".
volatile boolean QS = false;        // becomes true when Arduoino finds a beat.
  char sendBuffer[16];

#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <string.h>

// ------------------------------ Conectando a internet----------------------

const char* ssid = "Midiacom2";
const char* password =  "apm1d14c0m";

//---------------------------------------Parametros para conexao com o Cloud MQTT
const char* mqttServer = "m11.cloudmqtt.com";
const int mqttPort = 17639;
const char* mqttUser = "ghpqajfd";
const char* mqttPassword = "LxnxmMcKgIYt";
//#define mqtt_topic        "nodeMCU/sinal"

static int outputType = SERIAL_PLOTTER;

unsigned long lastTime; // used to time the Pulse Sensor samples
unsigned long thisTime; // used to time the Pulse Sensor samples
unsigned long fadeTime; // used to time the LED fade


WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
  pinMode(blinkPin, OUTPUT);        // pin that will blink to your heartbeat!
  pinMode(fadePin, OUTPUT);         // pin that will fade to your heartbeat!
  Serial.begin(115200);             // we agree to talk fast!
  lastTime = micros();              // get the time so we can create a software 'interrupt'

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Connecting to WiFi..");
  }
  Serial.println("Connected to the WiFi network");
  client.setServer(mqttServer, mqttPort);

  while (!client.connected()) {
    Serial.println("Connecting to MQTT...");
    if (client.connect("ESP8266Client", mqttUser, mqttPassword )) {
     Serial.println("connected");} 
     else {
      Serial.print("failed with state ");
      Serial.print(client.state());
      delay(2000);}
  }
  client.publish("arduino", "Conexão ");
}


void loop() {

serialOutput();
  thisTime = micros();            // GET THE CURRENT TIME
  if (thisTime - lastTime > 2000) { // CHECK TO SEE IF 2mS HAS PASSED
    lastTime = thisTime;          // KEEP TRACK FOR NEXT TIME
    getPulse();                   //CHANGE 'ISR(TIMER2_COMPA_vect)' TO 'getPulse()' IN THE INTERRUPTS TAB!
  }

  if (QS == true) {    // A Heartbeat Was Found
    // BPM and IBI have been Determined
    // Quantified Self "QS" true when arduino finds a heartbeat
    fadeRate = 255;         // Makes the LED Fade Effect Happen
    // Set 'fadeRate' Variable to 255 to fade LED with pulse
    fadeTime = millis();    // Set the fade timer to fade the LED
    QS = false;                      // reset the Quantified Self flag for next time
  }

  if (millis() - fadeTime > 20) {
    fadeTime = millis();
    ledFadeToBeat();                      // Makes the LED Fade Effect Happen
  }


} // end of loop


void ledFadeToBeat() {
  fadeRate -= 15;                         //  set LED fade value
  fadeRate = constrain(fadeRate, 0, 255); //  keep LED fade value from going into negative numbers!
  analogWrite(fadePin, fadeRate);         //  fade LED
}
