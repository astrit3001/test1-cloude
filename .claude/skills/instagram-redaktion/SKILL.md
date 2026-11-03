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
| Flyer (Tagesset) | Karussell (Bild 1–3) + Flyer als Story | 1/Tag nach Freigabe | Angebot, Wiedererkennung |
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
  - Seit 03.11.2026 **vier Bilder, alle 4:5, nur EIN Flyer** (Nutzer: „einer zu viel“):
  - Bild 1: Lifestyle → Karussell Folie 1
  - Bild 2: Unik-Flyer schwarz/gold 4:5 → Karussell Folie 2 **und** Story
  - Bild 3: Nahaufnahme Oberfläche → Karussell Folie 3
  - Bild 4: neutraler Flyer → nur Shopify (erstes Produktbild), nie Instagram
  - Bild 1 Pflicht: genau zwei Hände (Pose beider Hände im Prompt festlegen), Fliese ≥ 40 % des Bildes frei sichtbar, Gesicht/Bart nach den neuesten Fotos (Higgsfield 39a45852…, f528b15c…), Bart im Farbton der Haare.
  - Bildunterschrift: erste Zeile Stimmung, dann ✔️-Fakten, Frage zu den Farben, CTA.
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

## Vorbild-Konten (Montags-Inspiration im Tagestask, Schritt 6)

Vom Nutzer genannt am 03.11.2026. Instagram selbst ist von hier nicht abrufbar (Firecrawl lehnt ab, Container blockiert, influencers-club lieferte 502). Ausgewertet werden nur Suchtreffer-Texte (Bildunterschrift, Datum, Likes) – keine Bilder.

| Gruppe | Konten |
|---|---|
| Händler Kosovo/Albanien | @dinoqeramika, @albaqeramika, @divaqeramika, @billa.albania |
| Händler Deutschland | @afloor_design (wichtigstes Vorbild DE), @fliesenpark.de, @aura_fliesen (am nächsten am eigenen Stil) |
| Fliesenleger (für Reels) | @dmitry__katkov (Nutzer schrieb „dimitry__katkov“), @ardi_qeramike |
| Hersteller | @argentaceramica, @pamesaceramica, @mirage_it, @lafaenzaceramica, @florim_ceramiche, @fiandre_surfaces (die letzten zwei am 03.11. ergänzt) |

**Bild-Vorlagen (seit 03.11.2026):** Instagram ist nicht abrufbar; der Umweg über lookaside.instagram.com wurde von der Sicherheitsprüfung blockiert – nicht erneut versuchen. Stattdessen Bilder von den Websites der Konten/Hersteller (z. B. albaqeramika.net zeigt eigene Instagram-Posts als imgi_..._n.jpg) per Firecrawl/WebFetch finden und mit `mcp__Higgsfield__media_import_url` importieren. Die media_ids stehen im Task-Gedächtnis /areas/unik-fliesen-vorlagen.md; Start (03.11.2026): 17 Vorlagen von 8 Konten – Alba (5), Afloor (2), Fliesenpark (2), La Faenza (2), Florim (2), Fiandre (2), Mirage (1), Pamesa (1); täglich zwei Vorlagen von verschiedenen Konten. Feste KI-Influencerin für Frauen-Tage: Higgsfield-Job f3c2d035-dcb1-476d-a8dd-b7613bdd5a5d (vom Nutzer gewählt, KI-generiert, keine reale Person). Nutzung nur für Bildaufbau/Licht/Stimmung, nie Möbel/Personen/Texte/Logos kopieren.

**Video (seit 03.11.2026):** Zweimal pro Woche ein 6-s-Video als Karussell-Folie 2 (Reihenfolge Bild 1, Video, Flyer, Nahaufnahme):
- **Dienstag – „Moodboard → Raum“** (Format von @senay_florim/@eera_bagno): Astrits Hand mit schwarzer Apple Watch legt die Muster (Startbild mit Hand, Hautton nach Astrit-Foto), Ende in einem Badezimmer – jedes Mal ein anderer Bad-Typ und Stil. Higgsfield `flux_3_video`, 3:4, 720p, Start-/Endbild + Moodboard als Referenz (ca. 36 Credits + 3 Bilder).
- **Freitag – „Farbwechsel – welche nehmt ihr?“**: derselbe Raum wechselt von Farbe A zu Farbe B der Serie; `minimax_h3_max`, 3:4, 768p, nur Start-/Endbild (MiniMax erlaubt keine Referenz zusammen mit Start/Ende; ca. 15 Credits + 2 Bilder). Zweite Zeile der Bildunterschrift: „[Farbe A] oder [Farbe B] – welche würdet ihr nehmen? 👇“.
- Astrit-Fotos 39a45852 und f528b15c (03.11.2026) sind bei Higgsfield defekt (400 „Eingabebild konnte nicht gelesen werden“, Upload unvollständig, URL liefert 403) – weglassen, bis Astrit sie neu hochlädt; Ersatz b7918426 ff.
- Beide Videos klein beschriftet: 'UNIK FLIESEN' oben links, 'LUNACERAM.COM' oben rechts (in Start- und Endbild eingebaut; Test 03.11.2026 von Astrit abgenommen: Hand und Schrift korrekt – trotzdem jedes Mal prüfen lassen).
- Gemischtes Karussell (Bild + Video) über Blotato noch ungetestet; bei Fehler Video separat als Reel anbieten.

**Vorschlag des Tages:** Jeder Morgenbericht enthält genau einen neuen, konkreten Wachstums-Vorschlag (Format, Thema, Uhrzeit, Einstieg) mit Begründung und Label; Astrit entscheidet. Nicht vorschlagen: Hersteller-Konten markieren (abgelehnt 03.11.2026). Dazu eine Story-Umfrage-Frage zur Tagesfliese – den Umfrage-Sticker kann Blotato nicht setzen, Astrit fügt ihn nach dem Posten in der Instagram-App hinzu.
**Story:** Nie das 4:5-Bild als Story – Instagram schneidet es links/rechts ab (03.11.2026 passiert). Stattdessen `mcp__Higgsfield__outpaint_image` auf 9:16 mit width 1080, height 1920.
**Instagram-Daten (offizieller Weg):** Supermetrics „Instagram Public Data“ (IGPD2, Report BusinessDiscoveryMedia: post_media_url, post_likes, post_caption) – Testphase am 25.10.2026 abgelaufen, braucht bezahltes Abo.

Regeln: Ideen und Machart übernehmen, nie Texte/Bilder/Layouts kopieren; keine politischen Anspielungen; Likes im Verhältnis zu Followern bewerten. Neue Konten: per Suche prüfen, dann den Task-Prompt per `update_trigger` ändern (nicht neu anlegen).

## Freigaben (vom Nutzer erteilt)

- **Grundregel (03.11.2026, ausdrücklich vom Nutzer): Niemals selbst posten.** Jeder Post, jede Story, jeder Kommentar und jede DM erst nach ausdrücklicher Freigabe des Nutzers für genau diesen Inhalt („posten“, „ok“, „freigegeben“). Kein Einplanen auf Vorrat, kein „läuft automatisch, wenn du nicht widersprichst“.
- Eine Freigabe gilt nur für den gezeigten Inhalt. Wird ein Bild neu erzeugt oder der Text geändert, braucht es eine neue Freigabe.
- KI-Bilder sind oft fehlerhaft (Beispiel 03.11.2026: Bild 1 des Testlaufs war defekt). Vor jeder Freigabe den Nutzer ausdrücklich bitten, die Bilder selbst anzusehen.

## Grenzen (immer ehrlich sagen)

- Follower-Zahlen oder Viralität kann niemand versprechen.
- Kein Kauf von Followern/Likes, keine Follow/Unfollow-Tricks, keine Bots – verstößt gegen Instagram-Regeln und gefährdet das Konto.
- Keine erfundenen Kundenstimmen, Zahlen, Preise oder Rabatte. Kunden und Häuser nur mit Erlaubnis zeigen (Hausnummern, Kennzeichen, Gesichter unkenntlich).
- Fremde Musik und fremde Bilder nicht ohne Rechte verwenden.
