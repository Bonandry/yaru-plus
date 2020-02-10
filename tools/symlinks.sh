#!/bin/sh

YARU="$HOME/GitHub/yaru-plus-gusbemacbe/Yaru++"

echo "Yaru++"
ln -sfnr $YARU/apps/16/ulauncher-indicator.svg                 $YARU/apps/16/ulauncher.svg
ln -sfnr $YARU/apps/scalable/ulauncher-indicator.svg           $YARU/apps/scalable/ulauncher.svg
ln -sfnr $YARU/apps/symbolic/ulauncher-indicator-symbolic.svg  $YARU/apps/symbolic/ulauncher-symbolic.svg

echo "Yaru++ Dark"
ln -sfnr $YARU-Dark/apps/16/ulauncher-indicator.svg                $YARU-Dark/apps/16/ulauncher-symbolic.svg
ln -sfnr $YARU-Dark/apps/symbolic/ulauncher-indicator-symbolic.svg $YARU-Dark/apps/symbolic/ulauncher-symbolic.svg