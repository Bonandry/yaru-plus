
echo "Following the Apple's standard colours"

echo "Replace dark colour (for light environments) for light colour (forr dark environments):"

sed -E --in-place --follow-symlinks 's/(#808080|#666|#353945|#4d4d4d|#fff)/#f2f2f7/g' *.svg

echo "Following the standard colours for dark mode, recommended by Apple, with the finality to respect the accessibility"

echo "Blue"
sed -E --in-place --follow-symlinks 's/(#0072f9|#1a7fd4|#1d99f3|#5294e2|#02a8f3|#049ef5)/#0084ff/g' *.svg
echo "Green"
sed -E --in-place --follow-symlinks 's/(#76c22b|#70c932|#53992c|#46a926|#1ea362|#7ad42b|#61a83d)/#30d158/g' *.svg
echo "Orange"
sed -E --in-place --follow-symlinks 's/(#fb7c38|#dd4814)/#ff9f0a/g' *.svg
echo "Pink"
sed -E --in-place --follow-symlinks 's/(#f504c7)/#ff375f/g' *.svg
echo "Purple"
sed -E --in-place --follow-symlinks 's/(#c43ac4)/#bf5af2/g' *.svg
echo "Red"
sed -E --in-place --follow-symlinks 's/(#da1636|#d33636|#f22c42|#ed4737|#da4453|#e00|#cb4848|#ff3f3f)/#ff453a/g' *.svg
echo "Yellow"
sed -E --in-place --follow-symlinks 's/(#ffda64|#fdc92b|#f9c440|#ffc500)/#ffd60a/g' *.svg