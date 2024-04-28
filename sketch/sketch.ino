#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include "config.h"

ESP8266WebServer server(80);

#define LED 2
#define INPUT_PIN 16

void setup() {

  Serial.begin(115200);

  pinMode(LED, OUTPUT);
  pinMode(INPUT_PIN, INPUT);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    digitalWrite(LED, HIGH);
    delay(100);
    digitalWrite(LED, LOW);
    delay(100);
  }

  Serial.println("Connected to WiFi: " + WiFi.localIP().toString());

  server.on("/", HTTP_GET, handleRoot);
  server.on("/led", HTTP_POST, handleLed);
  server.on("/read", HTTP_GET, handleReadInput);

  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}

// GET:
void handleRoot() {
  sendSuccessEmptyResponse();
}

void handleReadInput() {

  StaticJsonDocument<100> doc;
  doc["input_pin_state"] = digitalRead(INPUT_PIN);

  String response;
  serializeJson(doc, response);
  server.send(200, "application/json", response);
}

// POST:
void handleLed() {

  bool isOn = server.arg("is_on") == "true";
  digitalWrite(LED, isOn ? HIGH : LOW);

  sendSuccessEmptyResponse();
}

// HELPER:
void sendSuccessEmptyResponse() {

  StaticJsonDocument<30> doc;
  doc["status"] = "OK";
  
  String response;
  serializeJson(doc, response);
  server.send(200, "application/json", response);
}