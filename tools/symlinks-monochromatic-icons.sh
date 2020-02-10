#!/bin/sh

YARU="$HOME/GitHub/yaru-plus-gusbemacbe/Yaru++"

echo "YARU++"
ln -sfnr $YARU/apps/16/usb-creator.svg                 $YARU/apps/16/woeusbgui-icon.svg
ln -sfnr $YARU/apps/symbolic/usb-creator-symbolic.svg  $YARU/apps/symbolic/woeusbgui-icon-symbolic.svg

echo "YARU++ Dark"
ln -sfnr $YARU-Dark/apps/16/usb-creator.svg                $YARU-Dark/apps/16/woeusbgui-icon-symbolic.svg
ln -sfnr $YARU-Dark/apps/symbolic/usb-creator-symbolic.svg $YARU-Dark/apps/symbolic/woeusbgui-icon-symbolic.svg