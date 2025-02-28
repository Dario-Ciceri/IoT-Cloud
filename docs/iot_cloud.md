# Italiano

## Requisiti funzionali e obiettivi

1) Gestione utente:
    - registrazione
    - autenticazione
    - modifica
    - eliminazione account

2) Gestione dispositivo IoT:
    - registrazione
    - autenticazione
    - modifica
    - eliminazione

3) Trasmissione dati, protocolli e OS:
    - riot (arduino, esp32)
    - FreeRTOS (arduino, esp32)
    - json (Serverpod)
    - cbor (Serverpod???)
    - http (Serverpod)
    - gRPC (Remote Procedure Call)
    - zenoh (non compatibile con dart, FFI per C binding)
    - mqtt (non direttamente supportato da Serverpod)
    - matter (non direttamente supportato da Serverpod)
    - thread (non direttamente supportato da Serverpod)
    - zigbee (non direttamente supportato da Serverpod)
    - websockets (Serverpod)
    - Relic (Serverpod WebServer - RFC#2008 <https://github.com/serverpod/serverpod/issues/2008>)

4) Controllo remoto dei dispositivi

5) Salvataggio dati delle schede nel DB

6) Dashboard

7) Alerting e notifiche stile IFTTT

8) OTA per i dispositivi IoT

9) Cloud Storage

---

## Commenti

### Serverpod, ha senso usarlo per il cloud?

Serverpod va bene per l'applicazione flutter, supporta web socket ma bisogna vedere se si possono usare con Arduino / Esp32 ecc...
Si potrebbe fare a meno delle websockets per i dispositivi IoT? Se si vuole un controllo realtime no.
Alternative adatte a sistemi embedded e con risorse ridotte? Usare zenoh oppure mqtt.
Zenoh non supporta Dart, ha delle API in C ma servirebbe FFI e creare l'interfaccia.
MQTT ha supporto Dart e Arduino/Esp32/RPI ecc... leggero, adatto per dispositivi embedded e con risorse limitate.

Serverpod facilita la creazione del backend e genera la libreria client per l'applicazione frontend flutter.
Stanno sviluppando un grosso aggiornamento per Relic, il webserver, che permetterebbe di creare webhooks e REST APIs.
Resta comunque il discorso legato alle performance per i sistemi embedded, la soluzione migliore resta MQTT ma come integrarlo con Serverpod?

Per questa prima implementazione potrebbe aver senso creare una architettura a due livelli:
MQTT per IoT
Serverpod per applicazione flutter, db, ecc...
Bridge tra i due livelli

Come creo un broker mqtt in Dart?
Forse meglio usare Mosquitto, HiveMQ o EMQX.

### Possibile architettura

Serverpod <--> Broker MQTT <---> IoT Device

### Sviluppi futuri

Backend C/Rust/Python + Zenoh + app in flutter
Backend e frontend non devono avere per forza lo stesso linguaggio
Serverpod era comodo per avere la libreria client auto-generata

---

## Registrazione dispositivo IoT

La registrazione del dispositivo IoT avviene tramite applicazione flutter.
All'accensione del dispositivo, se questo non dispone di una configurazione, avvia il servizio BLE.
L'utente fa il login, avvia la procedura di registrazione dalla UI, l'applicazione cerca tramite BLE tutti i dispositivi disponibili e mostra una lista.
L'utente seleziona un dispositivo, l'applicazione si connette al dispositivo e recupera i dati sul modello.
L'applicazione contatta l'endpoint cloud per la registrazione del dispositivo e invia i dati della scheda e dell'utente.
Il cloud registra la scheda e la associa all'utente che ha fatto richiesta.
L'applicazione riceve una chiave da inviare al dispositivo.
Il dispositivo salva la chiave.
La procedura di registrazione si conclude.
