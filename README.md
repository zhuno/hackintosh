# macOS in einer virtuellen Umgebung einrichten (Hackintosh KVM)

## Vorwort
In dieser Repository findest du alles, was du dazu benötigst, um ein Hackintosh-System in einer KVM-Umgebung aufzusetzen. Mein Tutorial beruft sich hierbei auf die öffentlich zur Verfügung gestellten Ressourcen von:

 - Foxlet (https://github.com/foxlet)
 - The Passthrough Post (https://passthroughpo.st)

## Schritt 1: Voraussetzungen
Voraussetzungen:
 - AMD oder Intel-CPU mit SSE4.2-Unterstützung und aktivierter Virtualisierung (ein ausführliches Tutorial kann [hier](https://support.bluestacks.com/hc/de/articles/115003174386-Wie-kann-ich-Virtualisierung-VT-auf-meinem-PC-aktivieren-) gefunden werden.)
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
Nachdem man die Pakete installiert hat, kann man das Repository (welches von [Foxlet](https://twitter.com/foxletfox) stammt, auf den Computer klonen. 

    git clone https://github.com/foxlet/macOS-Simple-KVM.git
    rename macOS-Simple-KVM macos-kvm
    cd macos-kvm 
    ./jumpstart.sh (--catalina, --mojave, --high-sierra)

Standartmäßig wird Catalina heruntergeladen, man kann aber mit den in Klammern gesetzten Argumenten, andere Versionen herunterladen.

WIP
