#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <ArduinoJson.h>

const char* ssid = "2.4G Tower"; // Your Wi-Fi network SSID
const char* password = ""; // Your Wi-Fi network password

ESP8266WebServer server(80);
MDNSResponder mdns;

#define LED 4
#define INPUT_PIN 5

void setup() {

  Serial.begin(115200);

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    
    Serial.println(WiFi.status());
    Serial.println("Connecting to WiFi...");
    delay(1000);
  }

  Serial.println("Connected to WiFi");
  Serial.println(WiFi.localIP());

  if (MDNS.begin("nodemcu", WiFi.localIP())) {

    Serial.println("MDNS responder started");
  }

  // Define routes and handlers
  server.on("/", HTTP_GET, handleRoot);

  server.on("/on", HTTP_GET, handleOn);
  server.on("/off", HTTP_GET, handleOff);
  server.on("/led", HTTP_GET, handleLed);
  server.on("/read", HTTP_GET, handleReadInput);

  server.begin();
  Serial.println("HTTP server started");

  MDNS.addService("http", "tcp", 80);

  pinMode(LED, OUTPUT);
  pinMode(INPUT_PIN, INPUT);
}

void loop() {

  server.handleClient();
}

void handleRoot() {

  String response = "Hello from your NodeMCU!";
  server.send(200, "text/plain", response);

  Serial.println("handleRoot");
}

void handleOn() {

  digitalWrite(LED, HIGH);
  server.send(200, "text/plain", "LED is ON");
  Serial.println("handleOn");
}

void handleOff() {

  digitalWrite(LED, LOW);
  server.send(200, "text/plain", "LED is OFF");
  Serial.println("handleOff");
}

void handleLed() {
  StaticJsonDocument<100> doc;
  String isOn = server.arg("is_on");
  if (isOn == "true") {
    digitalWrite(LED, HIGH);
    doc["led_status"] = "ON";
  } else {
    digitalWrite(LED, LOW);
    doc["led_status"] = "OFF";
  }
  String response;
  serializeJson(doc, response);
  server.send(200, "application/json", response);
}

void handleReadInput() {
  StaticJsonDocument<100> doc;
  int pinState = digitalRead(INPUT_PIN);
  doc["input_pin_state"] = pinState;
  String response;
  serializeJson(doc, response);
  server.send(200, "application/json", response);
}