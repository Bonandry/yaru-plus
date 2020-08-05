#!/usr/bin/env bash
# This script creates colored folder icons for Suru+ icon theme
#
# Colors of the folder icon:
#
#   @ - primary color
#	" - secondary color
#	. - color of symbol
#
#     """""""""""""""""
#    """"""""""""""""""""
#    """"""""""""""""""""""""""""""""""""""""
#    """"""""""""""""""""""""""""""""""""""""
#    """"""""""""""""""""@@@@@@@@@@@@@@@@@@@"
#    """"""""""""""""""@@@@@@@@@@@@@@@@@@@@@@
#    .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@....@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@.@@.@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@.@@.@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@.@@.@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@......@@......@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@.@@@@@@@@@@.@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@.@@@@@@@@.@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@..@@..@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@..@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@............@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

set -eo pipefail

THIS_SCRIPT="$(basename "${BASH_SOURCE[0]}")"

if [ -d "$1" ]; then
	TARGET_DIR="$1"
else
	printf "%s\n" "usage: $THIS_SCRIPT <path to icon theme>" >&2
	exit 128
fi

DEFAULT_COLOR="yaru"
SIZES_REGEX="(32)"
COLOR_SIZES_REGEX="(32)"
FILES_REGEX="(folder|user)-"

declare -A COLORS

COLORS=(
	# [0] - primary color – start
	# [1] - primary color – end
	# [2] - shadow
	# [3] - secondary color - start
	# [4] - secondary color - end
	# [5] - secondary highlight
	# [6] - color of icon
	# [7] - user - color 1
	# [8] - user - color 2
	#
	# | name         | [0]      | [1]     | [2]     | [3]     | [4]     | [5]     | [6]     | [7]     | [8]     
	# |--------------|----------|---------|---------|---------|---------|---------|---------|---------|---------
	[yaru]="          #7A7A7A #666666 #491706 #E65524 #55163B #FEC589 #DBDBDB #fb7c38 #9b33ae"
	[adwaita]="				#C9B8A7 #A89888 #472806 #908478 #574F47 #E3D5C8 #D4D1C9 #A89888 #574F47"
	[aubergine]="     #A0649A #AD7AA9 #4F1748 #85377D #BF1449 #EBD3E8 #DDC8DB #AD7AA9 #BF1449"
	[blue]="     			#37A6E6 #6DC7F1 #062a47 #1A7FD4 #3194A4 #B9DAED #C6E9F7 #6DC7F1 #3194A4"
	[bordeaux]="     	#C2655B #D3918A #470d06 #AD4B41 #A13037 #EBBAB5 #EDD3D0 #D3918A #A13037"
	[canonical]="     #925475 #AD7F98 #4C1A35 #853E64 #E77727 #EBB2D0 #DDCAD4 #AD7F98 #E77727"
	[cyan]="     			#31C6B7 #5BDBC1 #06473b #2DAAAA #239BAA #85FFF3 #BAE8D5 #5BDBC1 #239BAA"
	[darkblue]="     	#6D95B0 #97B4C7 #3D5C71 #537E9B #54979C #CCDDE8 #D5E1E8 #97B4C7 #54979C"
	[green]="     		#76C22B #A6D74F #144706 #46A926 #89AA27 #C8FF91 #DCE6B8 #A6D74F #89AA27"
	[manjaro]="    		#16A085 #12816B #083A31 #0C5A4A #2F3F49 #83FCE4 #A6DBD1 #12816B #2F3F49"
	[mint]="       		#7AAF65 #517D40 #3D5E31 #579140 #76C22B #CCE3C3 #D0E3C9 #517D40 #76C22B"
	[orange]="        #F6B069 #F3994A #903906 #EC7223 #ECB622 #F3994A #FAD9B9 #F3994A #ECB622"
	[purple]="     		#8F76E4 #A7A7F1 #320647 #8C59D0 #800080 #C2B2F7 #DCDEF5 #A7A7F1 #800080"
	[red]="     			#F22C42 #F76363 #470606 #DA1636 #5C0A17 #FF99A4 #FAC3BA #F76363 #5C0A17"
	[vermillion]="    #E44739 #EB7B71 #470611 #D12B1D #AB2417 #FFA69E #F7CAC6 #EB7B71 #AB2417"
	[yellow]="     		#FFDA64 #FEE581 #473a06 #FDC92B #8B9702 #FADD84 #403101 #FEE581 #8B9702"
)

headline() 
{
	printf "%b => %b%s\n" "\e[1;32m" "\e[0m" "$*" >&2
}

msg() 
{
	printf "%b [+] %b%s\n" "\e[1;33m" "\e[0m" "$*" >&2
}

recolor() 
{
	# args: <old colors> <new colors> <path to file>
	IFS=" " read -ra old_colors <<< "$1"
	IFS=" " read -ra new_colors <<< "$2"
	local filepath="$3"

	[ -f "$filepath" ] || exit 1

	for (( i = 0; i < "${#old_colors[@]}"; i++ )); do
		sed -i "s/${old_colors[$i]}/${new_colors[$i]}/gI" "$filepath"
	done
}


headline "PHASE 1: Create missing symlinks ..."
# -----------------------------------------------------------------------------
find "$TARGET_DIR" -type f -regextype posix-extended \
	-regex ".*/places/${COLOR_SIZES_REGEX}/${FILES_REGEX}${DEFAULT_COLOR}[-\.].*" \
	-print0 | while read -r -d $'\0' file; do

	target="$(basename "$file")"
	symlink="${file/-$DEFAULT_COLOR/}"

	[ -e "$symlink" ] && continue

	msg "Creating missing symlink '$symlink' ..."
	ln -sf "$target" "$symlink"
done


headline "PHASE 2: Generate color folders ..."
# -----------------------------------------------------------------------------
find "$TARGET_DIR" -type f -regextype posix-extended \
	-regex ".*/places/${SIZES_REGEX}/${FILES_REGEX}${DEFAULT_COLOR}[-\.].*" \
	-print0 | while read -r -d $'\0' file; do

	for color in "${!COLORS[@]}"; do
		[[ "$color" != "$DEFAULT_COLOR" ]] || continue

		new_file="${file/-$DEFAULT_COLOR/-$color}"

		cp -P --remove-destination "$file" "$new_file"
		recolor "${COLORS[$DEFAULT_COLOR]}" "${COLORS[$color]}" "$new_file"
	done
done


headline "PHASE 3: Create symlinks for Folder Color v0.0.80 and newer ..."
# -----------------------------------------------------------------------------
# Icons mapping
FOLDER_COLOR_MAP=(
	# Folder Color icon         | Suru-plus icon
	# --------------------------|---------------------------
	"folder-COLOR-desktop.svg    user-COLOR-desktop.svg"
	"folder-COLOR-downloads.svg  folder-COLOR-download.svg"
	"folder-COLOR-public.svg     folder-COLOR-image-people.svg"
	"folder-COLOR-videos.svg     folder-COLOR-video.svg"
)

for mask in "${FOLDER_COLOR_MAP[@]}"; do
	for color in "${!COLORS[@]}"; do
		IFS=" " read -ra icon_mask <<< "$mask"
		folder_color_icon="${icon_mask[0]/COLOR/$color}"
		icon="${icon_mask[1]/COLOR/$color}"

		find "$TARGET_DIR" -regextype posix-extended \
			-regex ".*/places/${SIZES_REGEX}/${icon}" \
			-print0 | while read -r -d $'\0' file; do

			base_name="$(basename "$file")"
			dir_name="$(dirname "$file")"

			ln -sf "$base_name" "$dir_name/$folder_color_icon"
		done
	done
done