#!/usr/bin/env bash
# Regenerates every app icon from the splash logo (`FinoMarkPainter`, the
# finished "F"): Android (adaptive + legacy + themed + notification, per
# flavor), web, iOS, macOS, Windows and Linux. Needs ImageMagick 7 (`magick`).
# Re-run it whenever the logo or the flavor colors change; never edit the
# generated PNGs by hand.
set -euo pipefail
cd "$(dirname "$0")/.."

command -v magick >/dev/null || { echo "ImageMagick 7 (magick) is required." >&2; exit 69; }

work=build/icons
mkdir -p "$work"
OUT="$work/mark.png" flutter test tool/icons/render_mark.dart >/dev/null

# The glyph alone (white on transparent), cropped tight.
mark="$work/mark_trim.png"
magick "$work/mark.png" -trim +repage "$mark"

# Flavor colors: the accent palette's emerald / tangerine / violet.
prod_color='#10B981'
dev_color='#EA580C'
qa_color='#7C3AED'

# glyph <canvas> <fraction> <out>: the F, `fraction` of the canvas wide, on a
# transparent square canvas.
glyph() {
  magick "$mark" -resize "$(( $1 * $2 / 100 ))x" -background none \
    -gravity center -extent "$1x$1" "$3"
}

# tile <color> <fraction> <radius%> <out>: 1024 px full-color icon; the F over a
# flat color, corners rounded by `radius`% (0 = square, opaque).
tile() {
  local s=1024 r=$(( 1024 * $3 / 100 ))
  glyph $s "$2" "$work/_g.png"
  magick -size ${s}x${s} "xc:$1" "$work/_g.png" -compose over -composite "$4"
  (( r == 0 )) && return
  magick "$4" \( -size ${s}x${s} xc:none -fill white \
       -draw "roundrectangle 0,0,$((s - 1)),$((s - 1)),$r,$r" \) \
    -alpha set -compose DstIn -composite "$4"
}

# resize <src> <px> <out>
resize() { magick "$1" -filter Lanczos -resize "${2}x${2}" -depth 8 "$3"; }

# --- Android -----------------------------------------------------------------
res=android/app/src
# density:scale
densities=(mdpi:1 hdpi:1.5 xhdpi:2 xxhdpi:3 xxxhdpi:4)

# Adaptive foreground and its themed (monochrome) twin: the F inside the 66 dp
# safe zone of the 108 dp canvas.
glyph 1728 46 "$work/foreground.png"
# Notification small icon: thickened so the hairlines survive at 24 dp.
glyph 1152 84 "$work/_n.png"
magick "$work/_n.png" -morphology Dilate Disk:13 "$work/notif.png"

for d in "${densities[@]}"; do
  density=${d%%:*}; scale=${d##*:}
  px() { awk -v v="$1" -v s="$scale" 'BEGIN { printf "%d", v * s + 0.5 }'; }
  mkdir -p "$res/main/res/mipmap-$density" "$res/main/res/drawable-$density"
  resize "$work/foreground.png" "$(px 108)" "$res/main/res/mipmap-$density/ic_launcher_foreground.png"
  resize "$work/notif.png" "$(px 24)" "$res/main/res/drawable-$density/ic_stat_fino.png"
  for flavor in main:$prod_color dev:$dev_color qa:$qa_color; do
    dir=${flavor%%:*}; color=${flavor##*:}
    tile "$color" 58 22 "$work/_l.png"
    resize "$work/_l.png" "$(px 48)" "$res/$dir/res/mipmap-$density/ic_launcher.png"
  done
done
rm -f android/app/src/main/res/drawable/ic_stat_fino.xml

mkdir -p "$res/main/res/mipmap-anydpi-v26"
cat > "$res/main/res/mipmap-anydpi-v26/ic_launcher.xml" <<'XML'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background" />
    <foreground android:drawable="@mipmap/ic_launcher_foreground" />
    <monochrome android:drawable="@mipmap/ic_launcher_foreground" />
</adaptive-icon>
XML
for flavor in main:$prod_color dev:$dev_color qa:$qa_color; do
  dir=${flavor%%:*}; color=${flavor##*:}
  mkdir -p "$res/$dir/res/values"
  cat > "$res/$dir/res/values/ic_launcher_background.xml" <<XML
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">$color</color>
</resources>
XML
done

# --- Web ---------------------------------------------------------------------
tile "$prod_color" 58 0 "$work/web_any.png"
tile "$prod_color" 50 0 "$work/web_maskable.png"
tile "$prod_color" 64 22 "$work/web_favicon.png"
resize "$work/web_any.png" 192 web/icons/Icon-192.png
resize "$work/web_any.png" 512 web/icons/Icon-512.png
resize "$work/web_maskable.png" 192 web/icons/Icon-maskable-192.png
resize "$work/web_maskable.png" 512 web/icons/Icon-maskable-512.png
resize "$work/web_favicon.png" 48 web/favicon.png

# --- iOS (opaque, square: the OS rounds it) ------------------------------------
if [[ -d ios/Runner/Assets.xcassets/AppIcon.appiconset ]]; then
  tile "$prod_color" 58 0 "$work/ios.png"
  magick "$work/ios.png" -background "$prod_color" -alpha remove -alpha off "$work/ios.png"
  for f in ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-*.png; do
    name=$(basename "$f" .png)            # Icon-App-83.5x83.5@2x
    size=${name#Icon-App-}; size=${size%%x*}
    scale=${name##*@}; scale=${scale%x}
    [[ $name != *@* ]] && scale=1
    resize "$work/ios.png" "$(awk -v v="$size" -v s="$scale" 'BEGIN { printf "%d", v * s + 0.5 }')" "$f"
  done
fi

# --- macOS (squircle inset in the canvas, as Big Sur+ icons are) ----------------
if [[ -d macos/Runner/Assets.xcassets/AppIcon.appiconset ]]; then
  tile "$prod_color" 58 22 "$work/_m.png"
  magick "$work/_m.png" -resize 824x824 -background none -gravity center \
    -extent 1024x1024 "$work/macos.png"
  for f in macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_*.png; do
    size=$(basename "$f" .png); size=${size##*_}
    resize "$work/macos.png" "$size" "$f"
  done
fi

# --- Windows / Linux ---------------------------------------------------------
tile "$prod_color" 58 22 "$work/desktop.png"
if [[ -d windows/runner/resources ]]; then
  magick "$work/desktop.png" -define icon:auto-resize=256,64,48,32,16 \
    windows/runner/resources/app_icon.ico
fi
mkdir -p linux/runner/resources
resize "$work/desktop.png" 256 linux/runner/resources/app_icon.png

echo "Icons regenerated from the splash logo."
