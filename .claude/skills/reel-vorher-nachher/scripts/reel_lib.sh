# Bausteine für Instagram-Reels (1080x1920, 30 fps) mit ffmpeg.
# Einbinden mit:  source .claude/skills/reel-vorher-nachher/scripts/reel_lib.sh
# Danach WORK auf ein Arbeitsverzeichnis setzen (z. B. Scratchpad) und die Funktionen nutzen.

: "${WORK:?WORK (Arbeitsverzeichnis) setzen, bevor reel_lib.sh eingebunden wird}"
mkdir -p "$WORK/txt"

FONT_SANS=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
FONT_SERIF="$WORK/Cormorant.ttf"
# Elegante Serifenschrift (OFL-Lizenz) einmalig laden; Fallback: Liberation Serif.
if [ ! -s "$FONT_SERIF" ]; then
  curl -sSL --max-time 30 -o "$FONT_SERIF" \
    "https://raw.githubusercontent.com/google/fonts/main/ofl/cormorantgaramond/CormorantGaramond%5Bwght%5D.ttf" \
    || true
  file "$FONT_SERIF" 2>/dev/null | grep -q "TrueType" || FONT_SERIF=/usr/share/fonts/truetype/liberation/LiberationSerif-Regular.ttf
fi

GRADE_VIDEO="eq=contrast=1.06:saturation=1.10:gamma=1.01,unsharp=5:5:0.5"
GRADE_FOTO="eq=contrast=1.04:saturation=1.06"
ENC="-an -c:v libx264 -crf 18 -preset medium -pix_fmt yuv420p -r 30"

# Text IMMER über Datei übergeben: Doppelpunkt, Prozent und Apostroph brechen sonst drawtext.
# txt NAME "Inhalt"  -> legt $WORK/txt/NAME.txt an
txt() { printf '%s' "$2" > "$WORK/txt/$1.txt"; }

# Eleganter Text (Serif, ohne Kasten, weiches Ein-/Ausblenden)
# tx_elegant NAME GROESSE Y START ENDE
tx_elegant() {
  echo "drawtext=fontfile=$FONT_SERIF:textfile=$WORK/txt/$1.txt:expansion=none:fontsize=$2:fontcolor=white:shadowcolor=black@0.6:shadowx=3:shadowy=3:x=(w-tw)/2:y=$3-th/2:alpha='if(lt(t,$4),0,if(lt(t,$4+0.5),(t-$4)/0.5,if(lt(t,$5-0.4),1,if(lt(t,$5),($5-t)/0.4,0))))'"
}

# Kräftiger Text (fett, mit Kasten, "Pop"-Animation)
# tx_bold NAME GROESSE Y START ENDE [KASTENFARBE]
tx_bold() {
  echo "drawtext=fontfile=$FONT_SANS:textfile=$WORK/txt/$1.txt:expansion=none:fontsize='min($2,$2*0.4+(t-$4)*$2*5)':fontcolor=white:borderw=5:bordercolor=black@0.8:x=(w-tw)/2:y=$3-th/2:box=1:boxcolor=${6:-black@0.6}:boxborderw=20:enable='between(t,$4,$5)'"
}

# Langsamer Zoom (Ken Burns) auf 1080x1920
zp() { echo "zoompan=z='$1':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=1080x1920:fps=30"; }

# Videoclip zuschneiden.  clip AUS QUELLE START DAUER TEMPO CROP "EXTRA-FILTER"
#   TEMPO: 1 = normal, 0.5 = halbe Geschwindigkeit (flüssig interpoliert)
#   CROP:  z. B. "crop=432:768:72:0" für 576x768-Quellen, "-" wenn schon 9:16
clip() {
  local out=$1 src=$2 ss=$3 dur=$4 tempo=$5 crop=$6 extra=$7 f=""
  if [ "$tempo" != "1" ]; then
    f="setpts=PTS/$tempo,minterpolate=fps=30:mi_mode=mci:mc_mode=aobmc:vsbmc=1,"
  fi
  [ "$crop" != "-" ] && f="$f$crop,"
  ffmpeg -v error -y -ss "$ss" -t "$dur" -i "$src" \
    -vf "${f}scale=1080:1920:flags=lanczos,setsar=1,fps=30,$(zp '1.02+0.0006*on'),$GRADE_VIDEO${extra:+,$extra}" $ENC "$out"
}

# Foto als Clip mit langsamer Kamerafahrt.  foto AUS BILD DAUER CROP "EXTRA-FILTER"
#   CROP für 1200x1600-Fotos: "crop=900:1600:150:0" (x-Wert = horizontaler Ausschnitt)
foto() {
  local out=$1 img=$2 dur=$3 crop=$4 extra=$5 n
  n=$(echo "$dur*30/1" | bc)
  ffmpeg -v error -y -i "$img" \
    -vf "$crop,scale=1080:1920:flags=lanczos,setsar=1,zoompan=z='1.0+0.0010*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=$n:s=1080x1920:fps=30,$GRADE_FOTO${extra:+,$extra}" \
    $ENC -frames:v "$n" "$out"
}

# Zwei Clips mit Übergang verbinden.  uebergang AUS CLIP1 CLIP2 TYP [DAUER]
#   Typen: fade, fadewhite, fadeblack, wiperight, wipeleft, slideup, smoothleft,
#          circleopen, radial, zoomin, hblur, pixelize
uebergang() {
  local out=$1 a=$2 b=$3 typ=$4 d=${5:-0.7} len
  len=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$a")
  ffmpeg -v error -y -i "$a" -i "$b" -filter_complex \
    "[0]settb=AVTB,setpts=PTS-STARTPTS[x];[1]settb=AVTB,setpts=PTS-STARTPTS[y];[x][y]xfade=transition=$typ:duration=$d:offset=$(echo "$len-$d" | bc)" \
    $ENC "$out"
}

# Viele Clips mit gleichem Übergang zum fertigen Reel verbinden (mit stiller Tonspur,
# komprimiert auf < 30 MB, damit der Versand klappt).
# reel AUS UEBERGANG DAUER clip1.mp4 clip2.mp4 ...
reel() {
  local out=$1 typ=$2 x=$3; shift 3
  local ins="" filt="" i=0 last cur off k
  local -a D=()
  for c in "$@"; do
    ins="$ins -i $c"
    D+=("$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$c")")
    filt="$filt[$i:v]settb=AVTB,setpts=PTS-STARTPTS,format=yuv420p[v$i];"
    i=$((i+1))
  done
  last="[v0]"; cur=${D[0]}
  for k in $(seq 1 $((i-1))); do
    off=$(echo "$cur-$x" | bc)
    filt="$filt${last}[v$k]xfade=transition=$typ:duration=$x:offset=$off[c$k];"
    last="[c$k]"; cur=$(echo "$cur-$x+${D[$k]}" | bc)
  done
  ffmpeg -v error -y $ins -f lavfi -t 300 -i anullsrc=r=44100:cl=stereo \
    -filter_complex "${filt}${last}format=yuv420p[v]" -map "[v]" -map "$i:a" -shortest \
    -c:v libx264 -crf 23 -preset slow -maxrate 5M -bufsize 10M -c:a aac -b:a 128k \
    -movflags +faststart "$out"
}

# Kontaktbogen zur Kontrolle (alle 2 s ein Bild).  kontrolle VIDEO BILD.jpg
kontrolle() {
  ffmpeg -v error -y -i "$1" -vf "fps=0.5,scale=150:-2,tile=15x3" -frames:v 1 "$2"
}
