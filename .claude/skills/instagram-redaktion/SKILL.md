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
| Flyer (Tages-Dreierset) | Bild 1 Feed + Bild 2 Story | 1/Tag nach Freigabe | Angebot, Wiedererkennung |
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

## Flyer: Tages-Dreierset (läuft schon als geplanter Task)

- Geplanter Task **„Unik Fliesen Tages-Dreierset“** (`trig_01WuVZXrKuZukXbPpExw2i5m`), täglich 5:38 Uhr deutsche Zeit. Er erzeugt mit Higgsfield drei Bilder derselben Fliese:
  - Bild 1: Lifestyle 4:5 → **Feed**
  - Bild 2: Unik-Flyer 9:16 schwarz/gold → **Story**
  - Bild 3: neutraler Flyer → nur Shopify (erstes Produktbild), nie Instagram
- Seit 03.11.2026 (Schritt 5 im Task) schreibt der Task auch die Bildunterschrift und wartet auf „posten“ in **seiner** Sitzung. Ohne Freigabe wird nichts gepostet (so vom Nutzer gewünscht).
- Den Ablauf nur über `update_trigger` (Prompt) ändern, **nicht löschen und neu anlegen**: Neu angelegte Tasks bekommen hier keine Verbindungen (Higgsfield, Shopify), das wurde am 03.11. getestet (*sicher*).
- Blotato ist im Task **nicht** verbunden (Stand 03.11.). Ist es noch nicht ergänzt, kommt die Freigabe hierher: Ergebnis-Links aus dem Bericht nehmen, Feed + Story wie unten posten.
- Die Bilder sind KI-generiert und werden vom Task nicht angesehen. Hinweis an den Nutzer: vor „posten“ die Links öffnen (Gesicht, Schrift, Telefonnummer).
- Bildunterschrift: nur belegte Angaben aus dem Task-Bericht (Farben, Formate), keine Preise, genau 5 Hashtags mit #fliesenrheine.

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

- **Grundregel (03.11.2026, ausdrücklich vom Nutzer): Niemals selbst posten.** Jeder Post, jede Story, jeder Kommentar und jede DM erst nach ausdrücklicher Freigabe des Nutzers für genau diesen Inhalt („posten“, „ok“, „freigegeben“). Kein Einplanen auf Vorrat, kein „läuft automatisch, wenn du nicht widersprichst“.
- Eine Freigabe gilt nur für den gezeigten Inhalt. Wird ein Bild neu erzeugt oder der Text geändert, braucht es eine neue Freigabe.
- KI-Bilder sind oft fehlerhaft (Beispiel 03.11.2026: Bild 1 des Testlaufs war defekt). Vor jeder Freigabe den Nutzer ausdrücklich bitten, die Bilder selbst anzusehen.

## Grenzen (immer ehrlich sagen)

- Follower-Zahlen oder Viralität kann niemand versprechen.
- Kein Kauf von Followern/Likes, keine Follow/Unfollow-Tricks, keine Bots – verstößt gegen Instagram-Regeln und gefährdet das Konto.
- Keine erfundenen Kundenstimmen, Zahlen, Preise oder Rabatte. Kunden und Häuser nur mit Erlaubnis zeigen (Hausnummern, Kennzeichen, Gesichter unkenntlich).
- Fremde Musik und fremde Bilder nicht ohne Rechte verwenden.
