CURRENT="$HOME/.config/themes/current"
source "$CURRENT/base16.sh"

cat << EOF > "$CURRENT/tofi"
background-color = ${B00}d9
text-color = $B05
prompt-color = $B0D
input-color = $B05
default-result-color = $B05
placeholder-color = $B03
selection-color = $B0D
selection-match-color = $B0A
EOF
