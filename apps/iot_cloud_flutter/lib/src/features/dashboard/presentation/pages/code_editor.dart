import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/arduino.dart';
import 'package:intl/intl.dart';

@RoutePage()
class CodeEditorPage extends StatefulWidget {
  const CodeEditorPage({super.key});

  @override
  State<CodeEditorPage> createState() => _CodeEditorPageState();
}

class _CodeEditorPageState extends State<CodeEditorPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CodeController _codeController;
  late TextEditingController _searchController;
  late FocusNode _editorFocusNode;

  bool _isDarkMode = true;
  bool _isCompiling = false;
  bool _isUploading = false;
  double _compilationProgress = 0.0;
  double _uploadProgress = 0.0;
  String _consoleOutput = '';
  bool _isShowingConsole = false;

  // Progetti aperti
  List<Map<String, dynamic>> _openTabs = [];

  // Indice del tab attualmente attivo
  int _activeTabIndex = -1;

  // Template di codice
  final Map<String, String> _codeTemplates = {
    'blink_led': '''
// Esempio di sketch per far lampeggiare un LED
// Per Arduino e ESP

#define LED_PIN 13

void setup() {
  // Inizializza il pin LED come output
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  // Accendi il LED
  digitalWrite(LED_PIN, HIGH);
  // Aspetta un secondo
  delay(1000);
  // Spegni il LED
  digitalWrite(LED_PIN, LOW);
  // Aspetta un secondo
  delay(1000);
}
''',
    'dht_sensor': '''
// Esempio di sketch per leggere dati da un sensore DHT
// Per Arduino e ESP con libreria DHT

#include <DHT.h>

#define DHTPIN 2     // Pin digitale collegato al sensore
#define DHTTYPE DHT22  // DHT 22 (AM2302, AM2321)

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600);
  Serial.println(F("Test sensore DHT!"));

  dht.begin();
}

void loop() {
  // Attendi qualche secondo tra le misurazioni
  delay(2000);

  // Leggi umidità
  float h = dht.readHumidity();
  // Leggi temperatura in Celsius
  float t = dht.readTemperature();
  // Leggi temperatura in Fahrenheit
  float f = dht.readTemperature(true);

  // Controlla se le letture sono valide
  if (isnan(h) || isnan(t) || isnan(f)) {
    Serial.println(F("Errore nella lettura dal sensore DHT!"));
    return;
  }

  // Calcola l'indice di calore in Fahrenheit
  float hif = dht.computeHeatIndex(f, h);
  // Calcola l'indice di calore in Celsius
  float hic = dht.computeHeatIndex(t, h, false);

  Serial.print(F("Umidità: "));
  Serial.print(h);
  Serial.print(F("%  Temperatura: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(f);
  Serial.print(F("°F  Indice di calore: "));
  Serial.print(hic);
  Serial.print(F("°C "));
  Serial.print(hif);
  Serial.println(F("°F"));
}
''',
    'wifi_client': '''
// Esempio di connessione WiFi
// Per ESP8266 o ESP32

#ifdef ESP8266
  #include <ESP8266WiFi.h>
#else
  #include <WiFi.h>
#endif

const char* ssid = "NomeReteWiFi";
const char* password = "PasswordWiFi";

void setup() {
  Serial.begin(115200);
  delay(10);

  // Connessione alla rete WiFi
  Serial.println();
  Serial.println();
  Serial.print("Connessione a ");
  Serial.println(ssid);
  
  WiFi.begin(ssid, password);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connesso");
  Serial.println("Indirizzo IP: ");
  Serial.println(WiFi.localIP());
}

void loop() {
  // Qui puoi inserire il codice che deve essere eseguito continuamente
}
''',
    'mqtt_example': '''
// Esempio di client MQTT
// Per ESP8266 o ESP32 con libreria PubSubClient

#ifdef ESP8266
  #include <ESP8266WiFi.h>
#else
  #include <WiFi.h>
#endif
#include <PubSubClient.h>

// Configurazione WiFi
const char* ssid = "NomeReteWiFi";
const char* password = "PasswordWiFi";

// Configurazione MQTT
const char* mqtt_server = "broker.example.com";
const int mqtt_port = 1883;
const char* mqtt_user = "utente";
const char* mqtt_password = "password";
const char* mqtt_client_id = "ESP_Client";
const char* mqtt_topic = "sensors/data";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connessione a ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connesso");
  Serial.println("Indirizzo IP: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Messaggio ricevuto [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();
}

void reconnect() {
  // Loop finché non siamo connessi
  while (!client.connected()) {
    Serial.print("Tentativo di connessione MQTT...");
    // Prova a connetterti
    if (client.connect(mqtt_client_id, mqtt_user, mqtt_password)) {
      Serial.println("connesso");
      // Sottoscrizione
      client.subscribe("inTopic");
    } else {
      Serial.print("fallito, rc=");
      Serial.print(client.state());
      Serial.println(" riprovo tra 5 secondi");
      // Attendi 5 secondi prima di riprovare
      delay(5000);
    }
  }
}

void setup() {
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  long now = millis();
  if (now - lastMsg > 2000) {
    lastMsg = now;
    ++value;
    snprintf(msg, 50, "hello world #%ld", value);
    Serial.print("Pubblicazione messaggio: ");
    Serial.println(msg);
    client.publish(mqtt_topic, msg);
  }
}
''',
  };

  // Lista di progetti salvati
  final List<Map<String, dynamic>> _savedProjects = [
    {
      'id': 'proj001',
      'name': 'Termostato WiFi',
      'description': 'Progetto per controllare un termostato tramite WiFi',
      'device': 'ESP32',
      'lastModified': DateTime.now().subtract(const Duration(days: 2)),
      'code': '''
// Progetto: Termostato WiFi
// Dispositivo: ESP32
// Descrizione: Controllo remoto della temperatura

#include <WiFi.h>
#include <PubSubClient.h>
#include <DHT.h>

// Configurazione WiFi
const char* ssid = "MiaReteWiFi";
const char* password = "MiaPassword";

// Config MQTT
const char* mqtt_server = "broker.example.com";
const int mqtt_port = 1883;
const char* mqtt_user = "user";
const char* mqtt_password = "password";
const char* temp_topic = "casa/termostato/temperatura";
const char* setpoint_topic = "casa/termostato/setpoint";
const char* relay_topic = "casa/termostato/relay";

// Pin
#define DHTPIN 4
#define DHTTYPE DHT22
#define RELAY_PIN 5

// Variabili
float temperatura = 0;
float setpoint = 22.0;  // Temperatura target predefinita
bool riscaldamentoAttivo = false;

// Inizializzazione oggetti
WiFiClient espClient;
PubSubClient client(espClient);
DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(115200);
  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, LOW);  // Relay spento all'avvio
  
  // Inizializza sensore
  dht.begin();
  
  // Connessione WiFi
  setup_wifi();
  
  // Configura MQTT
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
}

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connessione a ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connesso");
  Serial.println("Indirizzo IP: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  String message;
  for (int i = 0; i < length; i++) {
    message += (char)payload[i];
  }
  
  if (String(topic) == setpoint_topic) {
    setpoint = message.toFloat();
    Serial.print("Nuovo setpoint: ");
    Serial.println(setpoint);
  }
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Connessione MQTT...");
    if (client.connect("ThermostatClient", mqtt_user, mqtt_password)) {
      Serial.println("connesso");
      client.subscribe(setpoint_topic);
    } else {
      Serial.print("fallito, rc=");
      Serial.print(client.state());
      Serial.println(" riprovo tra 5 secondi");
      delay(5000);
    }
  }
}

void loop() {
  // Gestione MQTT
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // Leggi temperatura ogni 2 secondi
  static unsigned long lastTemperatureRead = 0;
  if (millis() - lastTemperatureRead > 2000) {
    lastTemperatureRead = millis();
    
    float newTemp = dht.readTemperature();
    if (!isnan(newTemp)) {
      temperatura = newTemp;
      
      // Pubblica temperatura
      char tempString[8];
      dtostrf(temperatura, 5, 2, tempString);
      client.publish(temp_topic, tempString);
      
      // Controlla riscaldamento
      if (temperatura < setpoint - 0.5) {
        if (!riscaldamentoAttivo) {
          riscaldamentoAttivo = true;
          digitalWrite(RELAY_PIN, HIGH);
          client.publish(relay_topic, "ON");
          Serial.println("Riscaldamento ON");
        }
      } else if (temperatura > setpoint + 0.5) {
        if (riscaldamentoAttivo) {
          riscaldamentoAttivo = false;
          digitalWrite(RELAY_PIN, LOW);
          client.publish(relay_topic, "OFF");
          Serial.println("Riscaldamento OFF");
        }
      }
      
      // Debug
      Serial.print("Temperatura: ");
      Serial.print(temperatura);
      Serial.print(" °C, Setpoint: ");
      Serial.print(setpoint);
      Serial.print(" °C, Relay: ");
      Serial.println(riscaldamentoAttivo ? "ON" : "OFF");
    }
  }
}''',
    },
    {
      'id': 'proj002',
      'name': 'Monitor Umidità Piante',
      'description': 'Monitoraggio umidità terreno e invio dati tramite WiFi',
      'device': 'ESP8266',
      'lastModified': DateTime.now().subtract(const Duration(days: 5)),
      'code': '''
// Progetto: Monitor Umidità Piante
// Dispositivo: ESP8266
// Descrizione: Monitoraggio umidità terreno e invio dati tramite WiFi

#include <ESP8266WiFi.h>
#include <PubSubClient.h>

// Configurazione WiFi
const char* ssid = "MiaReteWiFi";
const char* password = "MiaPassword";

// Configurazione MQTT
const char* mqtt_server = "broker.example.com";
const char* mqtt_topic = "casa/piante/umidita";

// Pin sensore umidità terreno
#define MOISTURE_PIN A0
#define LED_PIN 2

// Variabili
int soilMoisture = 0;
int dryThreshold = 30;  // Percentuale sotto la quale il terreno è considerato secco

WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
  Serial.begin(115200);
  pinMode(LED_PIN, OUTPUT);
  
  // Connessione WiFi
  setup_wifi();
  
  // Configurazione server MQTT
  client.setServer(mqtt_server, 1883);
}

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connessione a ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connesso");
  Serial.println("Indirizzo IP: ");
  Serial.println(WiFi.localIP());
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Connessione MQTT...");
    if (client.connect("PlantMonitorClient")) {
      Serial.println("connesso");
    } else {
      Serial.print("fallito, rc=");
      Serial.print(client.state());
      Serial.println(" riprovo tra 5 secondi");
      delay(5000);
    }
  }
}

int readSoilMoisture() {
  // Leggi valore raw
  int sensorValue = analogRead(MOISTURE_PIN);
  
  // Converti in percentuale (adatta questi valori in base al tuo sensore)
  // Assumendo che 1023 sia completamente secco e 0 sia in acqua
  int percentValue = map(sensorValue, 1023, 0, 0, 100);
  
  // Limita il range a 0-100%
  percentValue = constrain(percentValue, 0, 100);
  
  return percentValue;
}

void loop() {
  // Gestione MQTT
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // Leggi umidità ogni 10 minuti
  static unsigned long lastReadTime = 0;
  if (millis() - lastReadTime > 600000 || lastReadTime == 0) {
    lastReadTime = millis();
    
    // Leggi umidità del terreno
    soilMoisture = readSoilMoisture();
    
    // Pubblica su MQTT
    char moistureString[8];
    sprintf(moistureString, "%d", soilMoisture);
    client.publish(mqtt_topic, moistureString);
    
    // Accendi LED se terreno secco
    if (soilMoisture < dryThreshold) {
      digitalWrite(LED_PIN, HIGH);  // LED ON (low per ESP8266 built-in LED)
    } else {
      digitalWrite(LED_PIN, LOW);   // LED OFF
    }
    
    // Debug
    Serial.print("Umidità terreno: ");
    Serial.print(soilMoisture);
    Serial.println("%");
  }
  
  // DeepSleep per risparmio energia (opzionale)
  // ESP.deepSleep(10e6); // 10 secondi in microsecondi
}''',
    },
    {
      'id': 'proj003',
      'name': 'Stazione Meteo',
      'description':
          'Monitoraggio temperatura, umidità e pressione atmosferica',
      'device': 'ESP32',
      'lastModified': DateTime.now().subtract(const Duration(days: 10)),
      'code': '''
// Progetto: Stazione Meteo
// Dispositivo: ESP32
// Descrizione: Monitoraggio temperatura, umidità e pressione atmosferica con display

#include <Wire.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <Adafruit_SSD1306.h>

// Configurazione WiFi
const char* ssid = "MiaReteWiFi";
const char* password = "MiaPassword";

// Endpoint API per inviare dati
const char* serverName = "http://example.com/api/weather";

// Configurazione display OLED
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define OLED_RESET    -1
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

// Configurazione BME280
Adafruit_BME280 bme;
float temperature, humidity, pressure, altitude;

// Intervallo di lettura sensori (15 minuti)
const unsigned long readInterval = 15 * 60 * 1000;

void setup() {
  Serial.begin(115200);
  
  // Inizializza BME280
  if (!bme.begin(0x76)) {
    Serial.println("Errore: sensore BME280 non trovato!");
    while (1);
  }
  
  // Inizializza display OLED
  if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    Serial.println("Errore: display SSD1306 non trovato!");
    for(;;);
  }
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  
  // Connessione WiFi
  connectToWifi();
}

void connectToWifi() {
  display.clearDisplay();
  display.setCursor(0, 0);
  display.println("Connessione WiFi...");
  display.display();
  
  WiFi.begin(ssid, password);
  int attempts = 0;
  
  while (WiFi.status() != WL_CONNECTED && attempts < 20) {
    delay(500);
    Serial.print(".");
    attempts++;
  }
  
  if (WiFi.status() == WL_CONNECTED) {
    display.clearDisplay();
    display.setCursor(0, 0);
    display.println("WiFi connesso!");
    display.println(WiFi.localIP().toString());
    display.display();
    Serial.println("WiFi connesso");
    Serial.println(WiFi.localIP());
    delay(2000);
  } else {
    display.clearDisplay();
    display.setCursor(0, 0);
    display.println("WiFi non connesso");
    display.println("Modalità offline");
    display.display();
    Serial.println("WiFi non connesso");
    delay(2000);
  }
}

void readSensors() {
  temperature = bme.readTemperature();
  humidity = bme.readHumidity();
  pressure = bme.readPressure() / 100.0F; // hPa
  altitude = bme.readAltitude(1013.25); // Livello del mare standard in hPa
  
  Serial.print("Temperatura: ");
  Serial.print(temperature);
  Serial.println(" °C");
  
  Serial.print("Umidità: ");
  Serial.print(humidity);
  Serial.println(" %");
  
  Serial.print("Pressione: ");
  Serial.print(pressure);
  Serial.println(" hPa");
  
  Serial.print("Altitudine appross.: ");
  Serial.print(altitude);
  Serial.println(" m");
}

void updateDisplay() {
  display.clearDisplay();
  
  // Intestazione
  display.setCursor(0, 0);
  display.println("Stazione Meteo");
  display.drawLine(0, 10, display.width(), 10, SSD1306_WHITE);
  
  // Temperatura
  display.setCursor(0, 15);
  display.print("Temp: ");
  display.print(temperature, 1);
  display.println(" C");
  
  // Umidità
  display.setCursor(0, 25);
  display.print("Umid: ");
  display.print(humidity, 1);
  display.println(" %");
  
  // Pressione
  display.setCursor(0, 35);
  display.print("Pres: ");
  display.print(pressure, 1);
  display.println(" hPa");
  
  // Stato WiFi
  display.setCursor(0, 50);
  if (WiFi.status() == WL_CONNECTED) {
    display.print("WiFi: ");
    display.print(WiFi.RSSI());
    display.println(" dBm");
  } else {
    display.println("WiFi: disconnesso");
  }
  
  display.display();
}

void sendDataToServer() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(serverName);
    http.addHeader("Content-Type", "application/json");
    
    // Crea JSON con i dati
    String httpRequestData = "{\"temperature\":" + String(temperature) + 
                           ",\"humidity\":" + String(humidity) + 
                           ",\"pressure\":" + String(pressure) + 
                           ",\"altitude\":" + String(altitude) + "}";
                         
    int httpResponseCode = http.POST(httpRequestData);
    
    if (httpResponseCode > 0) {
      Serial.print("HTTP Response code: ");
      Serial.println(httpResponseCode);
    } else {
      Serial.print("Error code: ");
      Serial.println(httpResponseCode);
    }
    
    http.end();
  } else {
    Serial.println("WiFi disconnesso, impossibile inviare dati");
  }
}

void loop() {
  static unsigned long lastReadTime = 0;
  
  // Verifica connessione WiFi periodicamente
  if (WiFi.status() != WL_CONNECTED) {
    connectToWifi();
  }
  
  // Leggi sensori e aggiorna ogni intervallo
  if (millis() - lastReadTime > readInterval || lastReadTime == 0) {
    lastReadTime = millis();
    
    readSensors();
    updateDisplay();
    sendDataToServer();
  }
  
  delay(1000); // Piccolo ritardo per non sovraccaricare il sistema
}''',
    },
  ];

  // Lista di librerie disponibili
  final List<Map<String, dynamic>> _availableLibraries = [
    {
      'name': 'DHT Sensor Library',
      'author': 'Adafruit',
      'version': '1.4.4',
      'description': 'Libreria per sensori DHT11, DHT22, ecc.',
      'installed': true,
    },
    {
      'name': 'PubSubClient',
      'author': 'Nick O\'Leary',
      'version': '2.8.0',
      'description': 'Client MQTT per Arduino e ESP',
      'installed': true,
    },
    {
      'name': 'ESP8266WiFi',
      'author': 'Ivan Grokhotkov',
      'version': '1.0.0',
      'description': 'Libreria WiFi per ESP8266',
      'installed': true,
    },
    {
      'name': 'Adafruit BME280 Library',
      'author': 'Adafruit',
      'version': '2.2.2',
      'description':
          'Libreria per sensori BME280 (temperatura, umidità, pressione)',
      'installed': false,
    },
    {
      'name': 'Adafruit SSD1306',
      'author': 'Adafruit',
      'version': '2.5.7',
      'description': 'Libreria per display OLED SSD1306',
      'installed': false,
    },
    {
      'name': 'ArduinoJson',
      'author': 'Benoit Blanchon',
      'version': '6.21.3',
      'description': 'Libreria JSON per Arduino e ESP',
      'installed': true,
    },
    {
      'name': 'FastLED',
      'author': 'Daniel Garcia',
      'version': '3.6.0',
      'description': 'Libreria per LED WS2812B, NeoPixel, ecc.',
      'installed': false,
    },
    {
      'name': 'WiFiManager',
      'author': 'tzapu',
      'version': '2.0.15-rc.1',
      'description': 'Configurazione WiFi con portale captive',
      'installed': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Inizializza il controller del codice con supporto per C++/Arduino
    _codeController = CodeController(
      language: arduino,
    );

    _searchController = TextEditingController();
    _editorFocusNode = FocusNode();

    // Carica progetto di default
    _newFile();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _codeController.dispose();
    _searchController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  // Crea un nuovo file
  void _newFile() {
    final id = 'tab_${DateTime.now().millisecondsSinceEpoch}';
    final defaultCode = '''// Nuovo sketch
// Creato il ${DateTime.now().toString().split('.')[0]}

void setup() {
  // Inizializzazione
  Serial.begin(9600);
  Serial.println("Hello, IoT Cloud!");
}

void loop() {
  // Ciclo principale
  delay(1000);
}
''';

    setState(() {
      _openTabs.add({
        'id': id,
        'name': 'Nuovo Sketch',
        'type': 'arduino',
        'saved': false,
        'code': defaultCode,
      });

      _activeTabIndex = _openTabs.length - 1;
      _codeController.text = defaultCode;
    });
  }

  // Apri un progetto esistente
  void _openProject(Map<String, dynamic> project) {
    final id = 'tab_${DateTime.now().millisecondsSinceEpoch}';

    setState(() {
      _openTabs.add({
        'id': id,
        'name': project['name'],
        'type': 'arduino',
        'saved': true,
        'projectId': project['id'],
        'code': project['code'],
      });

      _activeTabIndex = _openTabs.length - 1;
      _codeController.text = project['code'];
    });

    Navigator.pop(context);
  }

  // Apri un template
  void _openTemplate(String templateName, String templateCode) {
    final id = 'tab_${DateTime.now().millisecondsSinceEpoch}';

    setState(() {
      _openTabs.add({
        'id': id,
        'name': 'Template: $templateName',
        'type': 'arduino',
        'saved': false,
        'code': templateCode,
      });

      _activeTabIndex = _openTabs.length - 1;
      _codeController.text = templateCode;
    });

    Navigator.pop(context);
  }

  // Compila lo sketch corrente
  void _compileSketch() {
    if (_activeTabIndex < 0) return;

    setState(() {
      _isCompiling = true;
      _compilationProgress = 0.0;
      _consoleOutput = '';
      _isShowingConsole = true;
    });

    // Simulazione della compilazione
    _simulateCompilationProgress();
  }

  // Simula il progresso della compilazione
  void _simulateCompilationProgress() {
    if (!_isCompiling) return;

    if (_compilationProgress < 1.0) {
      setState(() {
        _compilationProgress += 0.1;

        // Aggiungi output alla console
        switch ((_compilationProgress * 10).toInt()) {
          case 1:
            _addConsoleOutput(
                'Avvio compilazione sketch "${_openTabs[_activeTabIndex]['name']}"...');
            break;
          case 2:
            _addConsoleOutput('Raccolta dipendenze...');
            break;
          case 3:
            _addConsoleOutput('Verifica librerie...');
            break;
          case 4:
            _addConsoleOutput('Compressione sketch...');
            break;
          case 5:
            _addConsoleOutput('Compilazione codice sorgente...');
            break;
          case 6:
            _addConsoleOutput('Controllo dimensioni...');
            break;
          case 7:
            _addConsoleOutput('Ottimizzazione...');
            break;
          case 8:
            // Simula un problema
            if (math.Random().nextInt(10) < 2) {
              _addConsoleOutput('ERRORE: "DHT.h: No such file or directory"',
                  isError: true);
              _addConsoleOutput(
                  'ERRORE: Controllare che la libreria DHT sia installata',
                  isError: true);
              _isCompiling = false;
              return;
            } else {
              _addConsoleOutput('Compilazione completata con successo.');
            }
            break;
          case 9:
            _addConsoleOutput(
                'Sketch utilizza ${(math.Random().nextInt(20) + 10)}% della memoria di programma e ${(math.Random().nextInt(10) + 5)}% della memoria dinamica.');
            break;
          case 10:
            _addConsoleOutput(
                'Binary sketch size: ${(math.Random().nextInt(200) + 300)} KBytes');
            break;
        }
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        _simulateCompilationProgress();
      });
    } else {
      // Compilazione completata
      setState(() {
        _isCompiling = false;
      });
    }
  }

  // Carica lo sketch su un dispositivo
  void _uploadSketch() {
    if (_activeTabIndex < 0) return;

    // Prima compila, poi carica
    if (!_isCompiling && _compilationProgress < 1.0) {
      _compileSketch();

      // Dopo la compilazione, carica
      Future.delayed(const Duration(seconds: 3), () {
        if (_compilationProgress >= 1.0) {
          _startUpload();
        }
      });
    } else if (_compilationProgress >= 1.0) {
      // Se è già compilato, inizia upload direttamente
      _startUpload();
    }
  }

  // Inizia il processo di upload
  void _startUpload() {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    _addConsoleOutput('\nInizio caricamento sketch sul dispositivo...');

    // Simula il processo di upload
    _simulateUploadProgress();
  }

  // Simula il progresso dell'upload
  void _simulateUploadProgress() {
    if (!_isUploading) return;

    if (_uploadProgress < 1.0) {
      setState(() {
        _uploadProgress += 0.1;

        // Aggiungi output alla console
        switch ((_uploadProgress * 10).toInt()) {
          case 1:
            _addConsoleOutput('Ricerca dispositivo...');
            break;
          case 2:
            _addConsoleOutput('Dispositivo trovato sulla porta COM3.');
            break;
          case 3:
            _addConsoleOutput('Preparazione per il caricamento...');
            break;
          case 4:
            _addConsoleOutput('Avvio bootloader...');
            break;
          case 5:
            _addConsoleOutput('Trasferimento sketch: 50%');
            break;
          case 6:
            // Simula un problema
            if (math.Random().nextInt(10) < 2) {
              _addConsoleOutput('ERRORE: Timeout durante il trasferimento',
                  isError: true);
              _addConsoleOutput(
                  'ERRORE: Verificare la connessione al dispositivo',
                  isError: true);
              _isUploading = false;
              return;
            } else {
              _addConsoleOutput('Trasferimento sketch: 100%');
            }
            break;
          case 7:
            _addConsoleOutput('Verifica integrità...');
            break;
          case 8:
            _addConsoleOutput('Avvio sketch...');
            break;
          case 9:
            _addConsoleOutput('Sketch caricato con successo!');
            break;
          case 10:
            _addConsoleOutput('Dispositivo riavviato e pronto all\'uso.');
            break;
        }
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        _simulateUploadProgress();
      });
    } else {
      // Upload completato
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Aggiungi testo all'output della console
  void _addConsoleOutput(String text, {bool isError = false}) {
    setState(() {
      _consoleOutput += '${isError ? '\x1B[31m' : ''}$text\n';
    });
  }

  // Cambia il tab attivo
  void _setActiveTab(int index) {
    if (index >= 0 && index < _openTabs.length) {
      setState(() {
        // Salva il codice corrente prima di cambiare tab
        if (_activeTabIndex >= 0) {
          _openTabs[_activeTabIndex]['code'] = _codeController.text;
          _openTabs[_activeTabIndex]['saved'] = false;
        }

        _activeTabIndex = index;
        _codeController.text = _openTabs[_activeTabIndex]['code'];
      });
    }
  }

  // Chiudi un tab
  void _closeTab(int index) {
    if (index < 0 || index >= _openTabs.length) return;

    final tab = _openTabs[index];

    if (!tab['saved']) {
      // Chiedi conferma se non salvato
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('File non salvato'),
          content: Text(
              'Vuoi salvare i cambiamenti a "${tab['name']}" prima di chiudere?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Implementare salvataggio

                // Quindi chiudi il tab
                setState(() {
                  _openTabs.removeAt(index);
                  if (_activeTabIndex >= _openTabs.length) {
                    _activeTabIndex =
                        _openTabs.isEmpty ? -1 : _openTabs.length - 1;
                  }
                  if (_activeTabIndex >= 0) {
                    _codeController.text = _openTabs[_activeTabIndex]['code'];
                  }
                });
              },
              child: const Text('Salva'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                // Chiudi senza salvare
                setState(() {
                  _openTabs.removeAt(index);
                  if (_activeTabIndex >= _openTabs.length) {
                    _activeTabIndex =
                        _openTabs.isEmpty ? -1 : _openTabs.length - 1;
                  }
                  if (_activeTabIndex >= 0) {
                    _codeController.text = _openTabs[_activeTabIndex]['code'];
                  }
                });
              },
              child: const Text('Non salvare'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annulla'),
            ),
          ],
        ),
      );
    } else {
      // Chiudi direttamente
      setState(() {
        _openTabs.removeAt(index);
        if (_activeTabIndex >= _openTabs.length) {
          _activeTabIndex = _openTabs.isEmpty ? -1 : _openTabs.length - 1;
        }
        if (_activeTabIndex >= 0) {
          _codeController.text = _openTabs[_activeTabIndex]['code'];
        }
      });
    }
  }

  // Mostra dialog per aprire progetto
  void _showOpenProjectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apri Progetto'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Cerca progetti...',
                  border: OutlineInputBorder(),
                ),
                controller: _searchController,
                onChanged: (value) {
                  // TODO: Implementare ricerca
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _savedProjects.length,
                  itemBuilder: (context, index) {
                    final project = _savedProjects[index];
                    return ListTile(
                      leading: const Icon(Icons.file_copy),
                      title: Text(project['name']),
                      subtitle: Text(
                        '${project['device']} - Ultima modifica: ${DateFormat('dd/MM/yyyy HH:mm').format(project['lastModified'])}',
                      ),
                      onTap: () => _openProject(project),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
        ],
      ),
    );
  }

  // Mostra dialog per i template
  void _showTemplatesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Template di Codice'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.lightbulb_outline),
                title: const Text('Lampeggio LED'),
                subtitle: const Text('Esempio base per far lampeggiare un LED'),
                onTap: () => _openTemplate(
                    'Lampeggio LED', _codeTemplates['blink_led']!),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.thermostat),
                title: const Text('Sensore DHT'),
                subtitle:
                    const Text('Lettura temperatura e umidità da sensore DHT'),
                onTap: () =>
                    _openTemplate('Sensore DHT', _codeTemplates['dht_sensor']!),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.wifi),
                title: const Text('Client WiFi'),
                subtitle:
                    const Text('Connessione a rete WiFi per ESP8266/ESP32'),
                onTap: () => _openTemplate(
                    'Client WiFi', _codeTemplates['wifi_client']!),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.cloud_outlined),
                title: const Text('Client MQTT'),
                subtitle: const Text('Comunicazione con broker MQTT'),
                onTap: () => _openTemplate(
                    'Client MQTT', _codeTemplates['mqtt_example']!),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
        ],
      ),
    );
  }

  // Mostra dialog per le librerie
  void _showLibrariesDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Gestione Librerie'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Cerca librerie...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // TODO: Implementare ricerca
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: _availableLibraries.length,
                    itemBuilder: (context, index) {
                      final library = _availableLibraries[index];
                      return ListTile(
                        title: Text(library['name']),
                        subtitle: Text(
                          '${library['author']} - v${library['version']}',
                        ),
                        trailing: library['installed']
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    _availableLibraries[index]['installed'] =
                                        false;
                                  });
                                },
                                child: const Text('Rimuovi'),
                              )
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    _availableLibraries[index]['installed'] =
                                        true;
                                  });
                                },
                                child: const Text('Installa'),
                              ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(library['name']),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Autore: ${library['author']}'),
                                  Text('Versione: ${library['version']}'),
                                  const SizedBox(height: 8),
                                  Text(
                                      'Descrizione: ${library['description']}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Chiudi'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chiudi'),
            ),
          ],
        ),
      ),
    );
  }

  // Mostra dialog per i dispositivi di output
  void _showDevicesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleziona Dispositivo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.developer_board),
              title: const Text('ESP32'),
              subtitle: const Text('COM3 - Silicon Labs CP210x'),
              onTap: () {
                Navigator.pop(context);
                _uploadSketch();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.developer_board),
              title: const Text('Arduino Nano'),
              subtitle: const Text('COM4 - Arduino Nano'),
              onTap: () {
                Navigator.pop(context);
                _uploadSketch();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.developer_board),
              title: const Text('ESP8266'),
              subtitle: const Text('COM5 - Silicon Labs CP210x'),
              onTap: () {
                Navigator.pop(context);
                _uploadSketch();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Usa i temi della libreria flutter_highlight per l'editor
    final editorTheme = _isDarkMode ? monokaiSublimeTheme : githubTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Editor'),
        actions: [
          // Pulsanti azioni principali
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Salva',
            onPressed: () {
              if (_activeTabIndex >= 0) {
                // Salva il file corrente
                setState(() {
                  _openTabs[_activeTabIndex]['code'] = _codeController.text;
                  _openTabs[_activeTabIndex]['saved'] = true;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sketch salvato con successo')),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Compila',
            onPressed:
                _activeTabIndex >= 0 && !_isCompiling ? _compileSketch : null,
          ),
          IconButton(
            icon: const Icon(Icons.upload),
            tooltip: 'Carica su dispositivo',
            onPressed: _activeTabIndex >= 0 && !_isUploading
                ? () => _showDevicesDialog()
                : null,
          ),
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: _isDarkMode ? 'Modalità chiara' : 'Modalità scura',
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'IoT Cloud IDE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Versione 1.0.0',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Arduino, ESP8266, ESP32',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.create_new_folder),
              title: const Text('Nuovo Progetto'),
              onTap: () {
                Navigator.pop(context);
                _newFile();
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: const Text('Apri Progetto'),
              onTap: () {
                Navigator.pop(context);
                _showOpenProjectDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: const Text('Template'),
              onTap: () {
                Navigator.pop(context);
                _showTemplatesDialog();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Gestione Librerie'),
              onTap: () {
                Navigator.pop(context);
                _showLibrariesDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Impostazioni'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementare impostazioni
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Documentazione'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementare documentazione
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Riferimento Arduino'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementare riferimento
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Tabs editor
          if (_openTabs.isNotEmpty)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _openTabs.length,
                itemBuilder: (context, index) {
                  final tab = _openTabs[index];
                  final isActive = index == _activeTabIndex;

                  return Container(
                    margin: const EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      color: isActive
                          ? colorScheme.primaryContainer
                          : colorScheme.surfaceVariant,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: InkWell(
                      onTap: () => _setActiveTab(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              tab['name'],
                              style: TextStyle(
                                color: isActive
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            if (!tab['saved'])
                              Text(
                                ' *',
                                style: TextStyle(
                                  color: isActive
                                      ? colorScheme.onPrimaryContainer
                                      : colorScheme.onSurfaceVariant,
                                ),
                              ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () => _closeTab(index),
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: isActive
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          if (_activeTabIndex >= 0) ...[
            // Editor principale con CodeField
            Expanded(
              child: Row(
                children: [
                  // Editor - Usando CodeField per l'editing vero
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorScheme.outlineVariant,
                        ),
                      ),
                      child: CodeField(
                        controller: _codeController,
                        focusNode: _editorFocusNode,
                        textStyle: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                        gutterStyle: GutterStyle(
                          width: 48,
                          margin: 0,
                          textAlign: TextAlign.right,
                          textStyle: TextStyle(
                            color: _isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                            fontSize: 12,
                          ),
                          background: _isDarkMode
                              ? const Color(0xFF2D2D2D)
                              : const Color(0xFFF5F5F5),
                        ),
                        expands: true,
                        onChanged: (text) {
                          // Marca il file come non salvato quando modificato
                          if (_activeTabIndex >= 0 &&
                              _openTabs[_activeTabIndex]['saved']) {
                            setState(() {
                              _openTabs[_activeTabIndex]['saved'] = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Nessun file aperto
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.code, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Nessun file aperto',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Crea un nuovo file o apri un progetto esistente',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _newFile,
                          icon: const Icon(Icons.add),
                          label: const Text('Nuovo File'),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton.icon(
                          onPressed: _showOpenProjectDialog,
                          icon: const Icon(Icons.folder_open),
                          label: const Text('Apri Progetto'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Console
          if (_isShowingConsole &&
              (_isCompiling || _isUploading || _consoleOutput.isNotEmpty))
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: _isDarkMode
                    ? const Color(0xFF1E1E1E)
                    : const Color(0xFFF5F5F5),
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Barra della console
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Console',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.clear_all),
                          tooltip: 'Pulisci console',
                          onPressed: () {
                            setState(() {
                              _consoleOutput = '';
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          tooltip: 'Chiudi console',
                          onPressed: () {
                            setState(() {
                              _isShowingConsole = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Output della console
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: SelectableText.rich(
                        TextSpan(
                          children: _parseConsoleOutput(),
                        ),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 40,
        padding: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Stato compilazione
              if (_isCompiling)
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                        'Compilazione: ${(_compilationProgress * 100).toInt()}%'),
                  ],
                )
              // Stato upload
              else if (_isUploading)
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Upload: ${(_uploadProgress * 100).toInt()}%'),
                  ],
                )
              else if (_activeTabIndex >= 0)
                Row(
                  children: [
                    Text('Linee: ${_codeController.text.split('\n').length}'),
                    const SizedBox(width: 16),
                    Text('Caratteri: ${_codeController.text.length}'),
                  ],
                )
              else
                const Text('Pronto'),

              const Spacer(),

              // Mostra/nascondi console
              if (!_isShowingConsole && _consoleOutput.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _isShowingConsole = true;
                    });
                  },
                  icon: const Icon(Icons.terminal, size: 16),
                  label: const Text('Mostra Console'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Analizza l'output della console per colorare gli errori
  List<InlineSpan> _parseConsoleOutput() {
    final List<InlineSpan> spans = [];

    // Dividi per righe
    final lines = _consoleOutput.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Cerca codici di colore ANSI
      if (line.contains('\x1B[31m')) {
        // Errore (rosso)
        spans.add(TextSpan(
          text: line.replaceAll('\x1B[31m', '') +
              (i < lines.length - 1 ? '\n' : ''),
          style: const TextStyle(color: Colors.red),
        ));
      } else {
        // Testo normale
        spans.add(TextSpan(
          text: line + (i < lines.length - 1 ? '\n' : ''),
        ));
      }
    }

    return spans;
  }
}
