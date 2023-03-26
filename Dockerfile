# Verwende ein offizielles Node-Image als Basis
FROM docker.io/node:18-bullseye

# Installiere die Abhängigkeiten für den Build
RUN apt update
RUN apt install -y python3-venv

# Klone das Git-Repository
RUN git clone https://github.com/cocktailpeanut/dalai.git && cd dalai

# Benutze Torrent zum Download des Models
COPY alpaca-torrent.patch /tmp/alpaca-torrent.patch
RUN git apply /tmp/alpaca-torrent.patch

# Installiere die NPM Abhängigkeiten
RUN npm install

# Führe den Befehl zum Bauen aus
RUN npx dalai alpaca install 7B

# Exponiere den Port, auf dem die Anwendung läuft
EXPOSE 3000

# Starte die Anwendung
CMD ["npx", "dalai", "serve"]
