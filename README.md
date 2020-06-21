
# macOS in einer virtuellen Umgebung einrichten (Hackintosh KVM)

## Vorwort
In dieser Repository findest du alles, was du dazu benötigst, um ein Hackintosh-System in einer KVM-Umgebung aufzusetzen. Mein Tutorial beruft sich hierbei auf die öffentlich zur Verfügung gestellten Ressourcen von:

 - Foxlet (https://github.com/foxlet)
 - The Passthrough Post (https://passthroughpo.st)

## Schritt 1: Voraussetzungen
Voraussetzungen:
 - AMD- oder Intel-CPU mit SSE4.2-Unterstützung und aktivierter Virtualisierung (ein ausführliches Tutorial kann [hier](https://support.bluestacks.com/hc/de/articles/115003174386-Wie-kann-ich-Virtualisierung-VT-auf-meinem-PC-aktivieren-) gefunden werden.)
 - Mindestens 64GB freier Speicher (bestenfalls SSD-Speicher) 
 - grundlegende Linux-Kenntnisse 

Wichtig: 

 - Ich verweise hierbei, dass ich dieses Tutorial nur zu Informationszwecken erstellt habe, und Softwarepiraterie in keinster Weise unterstütze. Der Betrieb von Hackintosh-Systemen mit macOS ist gemäß der Lizenzbestimmungen von Apple nicht vorgesehen.
 - Hackintosh kann recht instabil laufen und ist auch kein einfaches Projekt. 
 - Ich hafte keinesfalls für Schäden an Hard- und Software.

## Schritt 2: Installation von Lubuntu
Ich nutze für die Host-Umgebung **Lubuntu**, welches auf Ubuntu basiert (welch eine Überraschung) und recht sparsam ist. 
Zuerst muss Lubuntu von der [offiziellen Webseite](https://lubuntu.net/) heruntergeladen werden. (AMD64-Variante)
Dann muss die ISO-Datei mithilfe von Balena Etcher ([https://www.balena.io/etcher/](https://www.balena.io/etcher/)) auf einen USB-Stick mit mind. 8GB freiem Speicher geflasht werden. Ist dies erledigt, kann der Computer gestartet werden. Wichtig dabei ist, dass der Computer vom USB-Stick bootet. 
Anschließend folgt man den Anweisungen auf dem Bildschirm um Lubuntu zu installieren.

## Schritt 3: Programme installieren
Zuerst öffnet man das Terminal in welchem man folgende Befehle nacheinander eingibt:

    sudo apt update
    sudo apt install qemu python3 python3-pip kvm git libvirtd 
    pip3 install click request
    
Die Installation muss bei größeren Paketen immer mit einem "J/Y" bestätigt werden.
Nachdem man die Pakete installiert hat, kann man die Repository (welche ich von [Foxlet](https://twitter.com/foxletfox) kopiert und sämtliche Dateien für euch modifiziert habe, auf den Computer klonen. 

    git clone https://github.com/zhuno/hackintosh.git
    cd hackintosh
    ./download.sh (--catalina, --mojave, --high-sierra)

Wenn man keine Argumente (--*) angibt, wird automatisch Catalina heruntergeladen.

Nachdem das Image heruntergeladen wurde, erstellt man eine virtuelle Festplatte mit dem Befehl

    qemu-img create -f qcow2 Disk.qcow2 %%%G

Wichtig ist, dass man das "%%%" mit einer Speichergröße ersetzt. Mindestens sind 64 GB notwendig. 
Beispiel: für 128GB müsste das "%%%" durch 128 ersetzt werden, sodass der Befehl wie folgt aussieht:

    qemu-img create -f qcow2 Disk.qcow2 128G

## Schritt 4: Vorbereitungen für die Nutzung von Apple-Diensten (optional) und Konfiguration der Hardware
Wenn du die Dienste von Apple (z.B. Apple ID) nutzen möchtest, musst du die Datei start.sh (welche du auch dafür verwenden wirst, um die Instanz zu starten), bearbeiten.
Aber bevor du das tust, musst du mit folgendem Befehl eine neue Mac-Adresse generieren:

    openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//'
Die Ausgabe des Befehls kopierst du, oder schreibst diese auf. 
Sollte der Befehl nicht gefunden werden, musst du OpenSSL mit folgendem Befehl installieren:

    sudo apt install openssl

Danach öffnest du die Datei start.sh im Texteditor "Nano"

    nano start.sh
Auf Zeile 29 welche du bei *# Mac-Adresse* finden kannst, entfernst du den bereits voreingestellten Wert 
*(52:54:00:c9:18:27)* und ersetzt ihn mit der vorher kopierten Ausgabe des Befehls.

**Du kannst in der Datei auch Einstellungen der virtuellen Maschine vornehmen.**

 - Auf Zeile 13 kannst du den zugewiesenen Arbeitsspeicher verändern 
 - Auf Zeile 17 kannst du die Anzahl der Prozessorkerne und Threads anpassen. 
  (Wenn du mehr als 8 Kerne zuweisen möchtest, musst du ebenfalls die Anzal der Sockets verändern.)
  Hier ein Beispiel für 16 Kerne und 32 Threads: `-smp cores=16,threads=32,sockets=2 \`
  Ich habe bereits eine CPU-Konfiguration mit 2 Kernen und 4 Threads voreingestellt.

Mit STRG+O speicherst du die Datei und anschließend kannst du den Text-Editor mit STRG+X verlassen.

## Schritt 5: Virtuelle Maschine starten und macOS installieren

Um die virtuelle Maschine zu starten, gebe den nachfolgenden Befehl ein und drücke ENTER.

    ./start.sh

## Schlusswort

Dieses Tutorial zeigt nur, wie man eine virtuelle Maschine mit macOS konfiguriert.
Weitere Informationen über die Vorgänge nach der Installation, findest du in zahlreichen Foren und Anleitungen, oder demnächst auch hier, wenn ich das Tutorial ergänzt habe.

Weitere Informationen findest du (auf Englisch) in der Dokumentation von @Foxlet, welches du hier: https://github.com/foxlet/macOS-Simple-KVM/tree/master/docs
