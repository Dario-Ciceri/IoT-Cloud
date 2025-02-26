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

3) Trasmissione dati e protocolli:
    - json (Serverpod)
    - http (Serverpod)
    - zenoh (non compatibile con dart, FFI per C binding)
    - mqtt (non direttamente supportato da Serverpod)
    - matter (non direttamente supportato da Serverpod)
    - thread (non direttamente supportato da Serverpod)
    - zigbee (non direttamente supportato da Serverpod)
    - websockets (Serverpod)

4) Controllo remoto dei dispositivi

5) Salvataggio dati delle schede nel DB

6) Dashboard

7) Alerting e notifiche stile IFTTT

8) OTA per i dispositivi IoT

9) Cloud Storage

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
