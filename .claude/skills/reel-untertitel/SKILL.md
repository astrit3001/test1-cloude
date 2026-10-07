---
name: reel-untertitel
description: Erzeugt automatische deutsche Untertitel für Reels mit gesprochenem Text (Talking Head, Erklärungen auf der Baustelle) und brennt sie ins Video. Verwenden, wenn ein Video Sprache enthält oder der Nutzer Untertitel will.
---

# Automatische Untertitel

## Voraussetzung (prüfen, nicht annehmen)

Die Spracherkennung (faster-whisper) lädt ihr Modell von **huggingface.co**. In dieser Cloud-Umgebung war das zuletzt **durch die Netzwerksperre blockiert** (403).

```bash
pip3 install -q faster-whisper
python3 -I .claude/skills/reel-untertitel/scripts/untertitel.py --test
```
- "MODELL OK" → weiter.
- Fehler 403 → dem Nutzer sagen: In den Umgebungs-Einstellungen unter Network access `huggingface.co` und `cdn-lfs.huggingface.co` erlauben (Anleitung: https://code.claude.com/docs/en/cloud-environments#network-access). Alternative: Nutzer schickt den gesprochenen Text selbst, dann Untertitel manuell timen.

## Ablauf

1. Prüfen, ob die Tonspur überhaupt Sprache hat (`ffprobe`, kurz anhören geht nicht → Transkript ansehen).
2. Transkribieren und ASS-Datei erzeugen:
   ```bash
   python3 -I .claude/skills/reel-untertitel/scripts/untertitel.py VIDEO.mp4 untertitel.ass
   ```
3. Transkript dem Nutzer zur Kontrolle zeigen, wenn Fachbegriffe vorkommen (Spracherkennung verschreibt z. B. "Gehrung", "Mikrozement").
4. Einbrennen (Originalton behalten!):
   ```bash
   ffmpeg -i VIDEO.mp4 -vf "ass=untertitel.ass" -c:v libx264 -crf 20 -c:a copy MIT_UT.mp4
   ```
5. Einzelbild kontrollieren: Untertitel lesbar, nicht unter y≈1500 (Instagram-Beschriftung).

Stil: kurze Häppchen (max. ~4 Wörter), fett, weiß mit schwarzem Rand, Bildmitte unten (y≈1350).
