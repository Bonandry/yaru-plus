Replace dark colour (for light environments) for light colour (forr dark environments):

```
sed -E --in-place --follow-symlinks 's/(#808080|#666|#353945)/#f2f2f7/g' *.svg
```

Following the standard colours recommended by Apple with the finality to respect the accessibility

```
sed -E --in-place --follow-symlinks 's/(#0072f9|#1a7fd4|#1d99f3|#5294e2)/#0084ff/g' *.svg
sed -E --in-place --follow-symlinks 's/(#76c22b|#70c932|#53992c)/#30d158/g' *.svg
sed -E --in-place --follow-symlinks 's/(#da1636|#f22c42|#ed4737|#da4453)/#ff453a/g' *.svg
sed -E --in-place --follow-symlinks 's/(#ffda64)/#ffd60a/g' *.svg
sed -E --in-place --follow-symlinks 's/(#fb7c38|#dd4814)/#ff9f0a/g' *.svg
sed -E --in-place --follow-symlinks 's/(#c43ac4)/#bf5af2/g' *.svg
```