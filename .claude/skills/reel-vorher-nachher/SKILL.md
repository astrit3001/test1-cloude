---
name: reel-vorher-nachher
description: Schneidet Instagram-Reels (9:16) aus Baustellen-Videos und -Fotos – Vorher/Nachher, Raum für Raum, Entwurf→Umsetzung, Prozess→Ergebnis. Verwenden, sobald der Nutzer Videos oder Fotos schickt und ein Reel, Vorher/Nachher oder "schneide das" will.
---

# Vorher/Nachher-Reels schneiden

Kunde: Handwerksbetrieb (Fliesen, Mikrozement, Trockenbau, Bodenbeläge). Ziel der Reels: neue Follower und Kundenanfragen über Instagram.

## Ablauf (immer in dieser Reihenfolge)

1. **Material prüfen** – zuerst den Skill `reel-material-check` befolgen. Nicht schneiden, bevor klar ist, welches Vorher zu welchem Nachher gehört.
2. **Stil klären, nicht raten** – Wenn der Nutzer kein Beispiel nennt, Standard = **Raum für Raum** (unten). Schickt der Nutzer ein Beispiel-Reel (Screenshot), dessen Stil genau übernehmen.
3. **Schneiden** mit `scripts/reel_lib.sh` (siehe unten).
4. **Selbst kontrollieren**, bevor geschickt wird: Kontaktbogen erstellen (`kontrolle`) und ansehen, zusätzlich 2–3 Einzelbilder in voller Größe. Prüfen: Text abgeschnitten? Text ragt über den Rand? Verwischte Stellen? Schmutz/Werkzeug groß im Bild? Paare korrekt?
5. **Ausliefern** mit SendUserFile aus dem Scratchpad. Datei < 30 MB halten (`reel` komprimiert bereits). Videos **nie** ins Git-Repo legen oder committen – der Nutzer will seine Videos nicht auf GitHub.
6. **Bildunterschrift + Hashtags** über den Skill `reel-texte` mitliefern.

## Formate (was der Nutzer bisher wollte)

**Raum für Raum (Standard):** Pro Raum erst VORHER (≈ 3–4 s, halbe Geschwindigkeit), dann Übergang, dann NACHHER (≈ 4–5 s) – **derselbe Raum, möglichst derselbe Blickwinkel**. Jeder Raum bekommt einen anderen Übergang (circleopen, wiperight, slideup, zoomin, smoothleft, radial). Zwischen Räumen kurzes fadeblack. Einstieg "Raum für Raum." – Ende "Vom Rohbau zum Zuhause." + "Folge für mehr Projekte". Gesamt ≈ 50–60 s.

**Prozess → Ergebnis:** "Der Prozess:" über dem kompletten Rohbau-Rundgang, dann "Das Ergebnis:" über dem fertigen Rundgang. Der Nutzer fand das schlechter als Raum für Raum – nur auf ausdrücklichen Wunsch.

**Entwurf → Umsetzung:** Einstieg mit der Visualisierung ("3D-Visualisierung vom Architekten" – nie behaupten, der Nutzer habe sie selbst entworfen), Vorher, Nachher, Details, am Ende Split-Screen oben Visualisierung / unten Ergebnis.

**Länge:** Der Nutzer will meist ~1 Minute mit viel vom Endergebnis. Kürzer nur auf Wunsch. Länge nie durch Strecken erzeugen – lieber mehr Material oder ruhige Zeitlupe bei Detailaufnahmen.

## Stil-Regeln

- 1080×1920, 30 fps, H.264, stille Tonspur (Musik fügt der Nutzer in Instagram hinzu).
- Vorher-Videos sind oft schnell geschwenkt → **halbe Geschwindigkeit** (`clip ... 0.5`), interpoliert. Verwischte Stellen meiden, ruhigere Sekunde wählen.
- Text-Stil passend zum Wunsch: elegant (`tx_elegant`, Serif, ohne Kasten) **oder** kräftig (`tx_bold`, rot `0xD32F2F@0.95` = Vorher, grün `0x2E7D32@0.95` = Nachher).
- Text nur in sicheren Zonen: Hauptzeile y≈330–500 oder Bildmitte y≈820–1000; unten nicht tiefer als y≈1500 (Instagram-Beschriftung), rechts Platz für Icons lassen.
- Texte ≤ ca. 18 Zeichen pro Zeile bei Größe 100+; längere Sätze auf zwei Zeilen aufteilen.
- Schmutzigen Boden, Werkzeug, Kartons: Ausschnitt höher setzen (Zoom oben verankert) oder andere Sekunde wählen. KI-Retusche nur nach Rückfrage (kostet Credits).

## Werkzeuge: scripts/reel_lib.sh

```bash
export WORK=<scratchpad>/<projekt>      # Arbeitsordner, NICHT im Repo
source .claude/skills/reel-vorher-nachher/scripts/reel_lib.sh
txt vor_bad "Vorher"                    # Texte immer als Datei (Doppelpunkt/Prozent sicher)
clip v1.mp4 QUELLE.mp4 40 2.0 0.5 - "$(tx_elegant vor_bad 120 820 0.2 9)"
foto n1.mp4 bild.jpg 5 "crop=900:1600:150:0" "$(tx_elegant nach_bad 120 820 0.2 9)"
uebergang r1.mp4 v1.mp4 n1.mp4 circleopen
reel FERTIG.mp4 fadeblack 0.5 intro.mp4 r1.mp4 r2.mp4 ende.mp4
kontrolle FERTIG.mp4 bogen.jpg
```

Quellen-Zuschnitt: WhatsApp-Videos sind oft gedreht gespeichert (ffmpeg dreht automatisch). Nach dem Drehen: 576×1024 → kein Crop; 576×768 → `crop=432:768:72:0`; 368×496 → `crop=279:496:44:0`. Fotos 1200×1600 → `crop=900:1600:X:0`.

## Ehrlichkeit gegenüber dem Nutzer

- Erst die unbequeme Wahrheit nennen (z. B. "zu unscharf", "Paar unsicher"), Aussagen mit *sicher / vermutlich / unsicher* kennzeichnen.
- Viralität nie versprechen.
- Nichts erfinden: keine Zahlen (Fliesenanzahl, Bauzeit), keine Kundenzitate ohne Vorlage, keine falschen Urheberschaften.
