---
name: dreh-anleitung
description: Erstellt eine Dreh-Anleitung mit Standpunkt-Bildern, damit das Nachher-Video aus denselben Positionen wie das Vorher gefilmt wird. Verwenden, wenn nur Vorher-Material da ist oder der Nutzer fragt, wie er filmen soll.
---

# Dreh-Anleitung für passende Vorher/Nachher-Aufnahmen

## 1. Standpunkte aus dem Vorher-Video wählen

Pro Raum eine **ruhige, scharfe** Sekunde wählen (Bogen mit `fps=1` ansehen, verwischte Bilder verwerfen). Ziel: 8–12 Standpunkte.

## 2. Referenzbild bauen

```bash
# pro Standpunkt: Nummer + "Sek. X" (KEIN Doppelpunkt im drawtext-Text!)
ffmpeg -v error -y -ss T -i VORHER.mp4 -frames:v 1 -vf "scale=288:512,drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='N':fontsize=60:fontcolor=white:borderw=4:bordercolor=black:x=12:y=8,drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='Sek. S':fontsize=28:fontcolor=white:box=1:boxcolor=black@0.6:boxborderw=8:x=12:y=h-48" pN.png
# dann 5er-Reihen mit hstack, Reihen mit vstack -> Standpunkte_Nachher_filmen.jpg
```
Per SendUserFile schicken.

## 3. Tabelle für den Nutzer

| Nr. | Raum (vermutlich) | Wo stehen | Wohin schauen | Neigung |

Höhe aus Fluchtpunkt/Horizont schätzen (Türen ≈ 2,0 m, Terrassentüren ≈ 2,2 m als Maßstab). Bisher ermittelt: ca. **1,30 m** (Brusthöhe), Unsicherheit ±15 cm – immer als Schätzung kennzeichnen.

## 4. Feste Dreh-Regeln (mitgeben)

- Gleiche Höhe, gleiche Richtung, gleiches Objektiv (0,5x oder 1x – an einem Raum testen und mit dem Referenzbild vergleichen).
- Hochkant, kein Zoom, pro Standpunkt 5–8 s: erst 2 s still halten, dann langsam schwenken (dieselbe Richtung wie im Vorher).
- Kanten (Türrahmen, Fensterkanten, Ecken) an dieselbe Bildstelle legen – wichtiger als der exakte Standpunkt.
- Vorher Werkzeug, Kartons, Eimer wegräumen, Boden fegen, Fensterscheiben putzen.
- Originaldateien direkt hochladen, **nicht über WhatsApp**.
- Alles in einem Durchgang in derselben Reihenfolge wie das Vorher filmen.
