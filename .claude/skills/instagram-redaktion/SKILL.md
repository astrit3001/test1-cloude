---
name: instagram-redaktion
description: Plant, schreibt und veröffentlicht den kompletten Instagram-Auftritt (Flyer-Posts, Baustellen-Reels, Stories, Werbung für lunaceram.com) über Blotato und wertet die Zahlen aus. Verwenden, wenn der Nutzer posten, planen, einen Wochenplan, Flyer veröffentlichen, mehr Follower, Statistiken oder "übernimm Instagram" will.
---

# Instagram-Redaktion (Blotato)

Ziel: mehr Follower **und** mehr Anfragen (Showroom-Termin, WhatsApp, Konfigurator auf lunaceram.com). Follower ohne Anfragen sind kein Erfolg.

## Feste Fakten (geprüft am 03.11.2026)

- Blotato-Konto: **ein** Instagram-Konto `astrit.llukaj` (accountId `83191`). Vor jedem Posten trotzdem `blotato_list_accounts` aufrufen – IDs ändern sich, wenn neu verbunden wird.
- LunaCeram (lunaceram.com): Fliesen aus Spanien & Italien, Feinsteinzeug, XXL-Formate, Holz- und Marmoroptik, Terrassenplatten. Marken: Navarti, AZUVI, Vitacer, APE Grupo, Energieker, Marca Corona. Showroom in **Rheine**. Online-Konfigurator/Badplaner, Angebot, Beratung per WhatsApp. Verlegung über Partner **Unik Fliesen GmbH**.
- Neue Fakten (Preise, Aktionen, Lieferzeiten) nur aus der Website oder vom Nutzer – nie aus dem Gedächtnis.

## Die drei Säulen

| Säule | Format | Wie oft | Zweck |
|---|---|---|---|
| Baustellen-Reels | Reel 9:16 (Skill `reel-vorher-nachher`) | so oft Material kommt, Ziel 3–5/Woche | **Reichweite / neue Follower** |
| Flyer | Bild-Post (oder Karussell) | 1/Tag aus dem aktuellen Dreierset | Angebot, Wiedererkennung |
| LunaCeram | Reel/Karussell/Story mit Fliese, Showroom, Konfigurator | 1–2/Woche | **Anfragen** |

Einschätzung, die dem Nutzer offen gesagt wird: Reels bringen auf Instagram in der Regel deutlich mehr Reichweite bei Nicht-Followern als Einzelbilder (*vermutlich*, von Instagram selbst so kommuniziert, aber nicht für dieses Konto gemessen). Täglich nur Werbe-Flyer wirkt schnell wie Anzeige und kann Follower kosten (*vermutlich*). Deshalb: Flyer dürfen nie die einzige Säule sein. Nach 4 Wochen mit echten Zahlen neu entscheiden.

## Wochenablauf

1. **Bestand prüfen**
   - `blotato_list_schedules` – was ist schon geplant?
   - `blotato_list_posts` (letzte 14 Tage) – was lief, was ist `failed`?
   - Material: neue Flyer-/Video-Dateien des Nutzers (müssen als Datei mit Pfad vorliegen, nicht nur als Chat-Vorschau).
2. **Wochenplan als Tabelle zeigen**: Datum, Uhrzeit (deutsche Zeit), Format, Datei, Einstiegstext, Bildunterschrift (gekürzt).
3. **Freigabe einholen** – einmal für den ganzen Plan („ok“ / „freigegeben“). Ohne Freigabe nichts veröffentlichen oder einplanen. Ausnahme nur, wenn der Nutzer ausdrücklich gesagt hat, dass ein bestimmter Ablauf ohne Rückfrage laufen darf – das dann hier unter „Freigaben“ eintragen.
4. **Hochladen und einplanen** (siehe unten). Danach `blotato_list_schedules` aufrufen und die tatsächlich geplanten Zeiten zurückmelden.

„Automatisch jeden Tag“ heißt hier: **die ganze Woche im Voraus in Blotato einplanen**. Blotato veröffentlicht dann selbst, auch wenn diese Sitzung geschlossen ist (*sicher*, so funktioniert `scheduledTime`). Einen wiederkehrenden geplanten Task nur anlegen, wenn der Nutzer das ausdrücklich will.

## Flyer-Dreierset

- Ein Set = 3 Flyer, pro Tag einer → ein Set reicht für 3 Tage. Rechtzeitig (Tag 2) nach dem nächsten Set fragen.
- Vor dem Posten jeden Flyer ansehen (Read): Rechtschreibung, Telefonnummer/Website korrekt, Text nicht am Rand abgeschnitten, Format 4:5 (1080×1350) bevorzugt, 1:1 geht. 9:16-Flyer sind für Stories, im Feed werden sie beschnitten (*sicher*).
- Fehler auf dem Flyer zuerst melden, nicht posten.
- Die Bildunterschrift erzählt etwas zum Flyer (Nutzen für den Kunden), nicht nur „Jetzt anfragen“.

## Reels

Ablauf über die vorhandenen Skills: `reel-material-check` → `reel-vorher-nachher` → `reel-texte` (Bildunterschrift, Hashtags) → hier veröffentlichen. Reels haben Vorrang vor Flyern: Kommt an einem Tag ein Reel, wird der Flyer dieses Tages in die Story verschoben oder einen Tag später gepostet.

## Werbung für lunaceram.com

- Links in Bildunterschriften sind auf Instagram **nicht klickbar** (*sicher*). Darum: „Link in Bio“ + Konfigurator/Website in die Bio, in Stories den Link-Sticker nutzen.
- `firstComment` mit Link ist ebenfalls nicht klickbar – nur als Text-Hinweis sinnvoll.
- Baustellen-Reels mit LunaCeram-Fliese: im Text Marke/Serie nur nennen, wenn der Nutzer sie bestätigt hat.
- Gute Aufhänger: „Diese Fliese aus Spanien – verlegt in …“, Showroom-Rundgang Rheine, Badplaner/Konfigurator am Handy zeigen, Größenvergleich XXL-Fliese.

## Veröffentlichen mit Blotato

```text
1. blotato_list_accounts (platform: instagram) → accountId
2. Lokale Datei: blotato_create_presigned_upload_url(filename) →
   curl -sS -X PUT "<presignedUrl>" --data-binary "@<datei>"  → publicUrl
3. blotato_create_post:
   Flyer:  { accountId, platform:"instagram", text, mediaUrls:[publicUrl], altText }
   Reel:   { ..., mediaType:"reel", shareToFeed:true, coverImageUrl (optional) }
   Story:  { ..., mediaType:"story" }   (kein firstComment bei Stories)
   Karussell: mehrere Bild-URLs in mediaUrls
   Geplant: scheduledTime als UTC-ISO-Zeit
4. Bei sofortigem Post: Ergebnis prüfen, bei Bedarf blotato_get_post_status.
```

- Zeitzone: Deutschland ist im Winter UTC+1, im Sommer UTC+2. 18:00 Uhr deutsche Zeit im November = `17:00:00Z`. Immer beide Zeiten nennen.
- Startzeiten zum Testen (keine bewiesenen Bestzeiten): Werktags 7:30 oder 18:00, am Wochenende 10:00. Nach 3–4 Wochen aus den eigenen Zahlen ersetzen.
- `trial` (Probe-Reels nur für Nicht-Follower) erst ab 1.000 Followern möglich.
- Videos nie ins Git-Repo legen; Arbeitsdateien im Scratchpad.

## Zahlen auswerten (einmal pro Woche)

- `blotato_list_top_posts` (sortBy `views_count` und `reach_count`, letzte 30 Tage) und `blotato_list_posts`.
- Bericht kurz: Top 3 und Flop 3 mit echten Werten, was sie unterscheidet (Format, Einstieg, Uhrzeit), **eine** konkrete Änderung für nächste Woche.
- Blotato liefert keine Follower-Entwicklung pro Post und Analysen kommen zeitverzögert (`analytics: null` bei frischen Posts) – das so sagen, nichts schätzen und als Zahl ausgeben.
- Erst ab ca. 10 Posts pro Format Schlüsse ziehen; vorher als *unsicher* kennzeichnen.

## Interaktion

- Kommentare und DMs können über Blotato gelesen/beantwortet werden. Antworten nur nach Freigabe des Nutzers senden – sie gehen öffentlich bzw. an echte Kunden.
- Täglich 10–15 Minuten selbst auf Kommentare antworten und lokale Konten (Rheine, Münsterland, Bauträger, Architekten) kommentieren bringt Reichweite, die kein Planungstool ersetzt (*vermutlich*).

## Freigaben (vom Nutzer erteilt)

- *(noch keine – jeder Plan braucht eine Freigabe)*

## Grenzen (immer ehrlich sagen)

- Follower-Zahlen oder Viralität kann niemand versprechen.
- Kein Kauf von Followern/Likes, keine Follow/Unfollow-Tricks, keine Bots – verstößt gegen Instagram-Regeln und gefährdet das Konto.
- Keine erfundenen Kundenstimmen, Zahlen, Preise oder Rabatte. Kunden und Häuser nur mit Erlaubnis zeigen (Hausnummern, Kennzeichen, Gesichter unkenntlich).
- Fremde Musik und fremde Bilder nicht ohne Rechte verwenden.
