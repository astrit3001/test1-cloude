---
name: reel-material-check
description: Prüft hochgeladene Baustellen-Videos und -Fotos vor dem Schneiden – Auflösung, Länge, Inhalt pro Sekunde, Vorher/Nachher-Paare, Störendes im Bild. Verwenden, sobald der Nutzer neues Material für ein Reel schickt.
---

# Material prüfen, bevor geschnitten wird

## 1. Technische Daten

```bash
ffprobe -v error -show_entries format=duration:stream=codec_type,width,height:stream_side_data=rotation -of compact DATEI
md5sum DATEIEN   # gleiche Datei mehrfach geschickt? Dann sagen, nicht neu verarbeiten.
```

- Unter 720 px Breite (nach Drehung) = **wird im Reel weich** → dem Nutzer sagen (sicher) und um das Original bitten.
- Dateinamen mit "WhatsApp" = von WhatsApp verkleinert. Tipp: Originale direkt hochladen, nicht über WhatsApp.
- Clips unter 1 s sind unbrauchbar.

## 2. Inhalt Sekunde für Sekunde ansehen

```bash
ffmpeg -v error -y -i DATEI -vf "fps=1,scale=130:-2,drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='%{n}':fontsize=22:fontcolor=red:x=3:y=3,tile=12x5" -frames:v 1 bogen.jpg
```
Dann den Bogen ansehen (Read). Für Details einzelne Sekunden in voller Größe ziehen.

Notieren: welcher Raum ab welcher Sekunde, ruhige vs. verwischte Stellen, Hände im Bild, Werkzeug/Schmutz/Kartons.

## 3. Vorher ↔ Nachher zuordnen

Paare an **festen Merkmalen** prüfen, nicht am Gefühl:
- Fensterlage (links/rechts/mittig, Höhe, Anzahl Flügel)
- Türen und Durchgänge, Treppenposition
- Vorwand-/WC-Elemente (Geberit-Kasten), Dachschrägen, Steckdosen-Reihen
Vergleichsbogen bauen (Vorher- und Nachher-Bilder nebeneinander) und ansehen. Unsichere Paare dem Nutzer als *vermutlich* nennen.

## 4. Was fehlt?

- Kein Nachher → kein Vorher/Nachher-Reel möglich (sicher). Stattdessen Skill `dreh-anleitung` nutzen und Teaser anbieten.
- Bilder, die nur im Chat als Vorschau ankamen (kein Dateipfad), sind **nicht verwendbar** → Nutzer bitten, sie mit @ als Datei anzuhängen.

## 5. Kurz berichten, dann schneiden

Dem Nutzer in wenigen Zeilen sagen: was erkannt wurde, welche Paare, was nicht passt oder fehlt. Danach direkt schneiden (Skill `reel-vorher-nachher`), nicht auf Bestätigung warten, außer ein Paar ist reine Vermutung und zentral für das Reel.
