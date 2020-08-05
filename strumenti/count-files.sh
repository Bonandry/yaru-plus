
COMMIT="acb92521c1b3db5e52abd6ee77eb1eef85970fe3"
DIRECTORY="places"
ADDED="A"
MODDED="M"

echo "- $(git difftool --no-renames --diff-filter=$ADDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTORY/16 | wc -l) $DIRECTORY 16px icons have been added."
echo "- $(git difftool --no-renames --diff-filter=$ADDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTORY/scalable | wc -l) $DIRECTORY scalable icons have been added."

echo "- $(git difftool --no-renames --diff-filter=$MODDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTORY/16 | wc -l) $DIRECTORY 16px icons have been modified."
echo "- $(git difftool --no-renames --diff-filter=$MODDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTORY/scalable | wc -l) $DIRECTORY scalable icons have been modified."

