"""Deutsche Untertitel als ASS-Datei für 1080x1920-Reels erzeugen.

Aufruf:
  python3 -I untertitel.py --test                 # nur prüfen, ob das Modell geladen werden kann
  python3 -I untertitel.py VIDEO.mp4 AUSGABE.ass  # transkribieren und ASS schreiben
"""
import sys

MODELL = "small"
WOERTER_PRO_ZEILE = 4

KOPF = """[Script Info]
ScriptType: v4.00+
PlayResX: 1080
PlayResY: 1920

[V4+ Styles]
Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
Style: Reel,DejaVu Sans,78,&H00FFFFFF,&H00FFFFFF,&H00000000,&H64000000,1,0,0,0,100,100,0,0,1,6,2,2,80,80,520,1

[Events]
Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text
"""


def zeit(sek):
    h = int(sek // 3600)
    m = int(sek % 3600 // 60)
    s = sek % 60
    return f"{h}:{m:02d}:{s:05.2f}"


def lade_modell():
    from faster_whisper import WhisperModel
    return WhisperModel(MODELL, device="cpu", compute_type="int8")


def main():
    if len(sys.argv) == 2 and sys.argv[1] == "--test":
        lade_modell()
        print("MODELL OK")
        return
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(1)
    video, ausgabe = sys.argv[1], sys.argv[2]
    segmente, _ = lade_modell().transcribe(video, language="de", word_timestamps=True, vad_filter=True)
    woerter = [w for seg in segmente for w in (seg.words or [])]
    zeilen = []
    for i in range(0, len(woerter), WOERTER_PRO_ZEILE):
        gruppe = woerter[i:i + WOERTER_PRO_ZEILE]
        text = " ".join(w.word.strip() for w in gruppe).upper()
        zeilen.append(f"Dialogue: 0,{zeit(gruppe[0].start)},{zeit(gruppe[-1].end)},Reel,,0,0,0,,{text}")
    with open(ausgabe, "w", encoding="utf-8") as f:
        f.write(KOPF + "\n".join(zeilen) + "\n")
    print(f"{len(zeilen)} Untertitel-Zeilen geschrieben: {ausgabe}")
    print("\n".join(z.split(",,")[-1] for z in zeilen))


if __name__ == "__main__":
    main()
