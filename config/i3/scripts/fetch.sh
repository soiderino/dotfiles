#!/bin/sh

read -r host < /proc/sys/kernel/hostname
read -r kernel < /proc/sys/kernel/osrelease

. /etc/os-release

mem=$(free --mega | awk 'NR == 2 { print $3" / "$2" MB" }')
pkgs=$(pacman -Q | wc -l)

# weather, lul
weather=$(curl -sS "wttr.in/?format=%C+%t+%h")

condition=$(echo "$weather" | grep -oE '^[[:alpha:] ]+[[:alpha:]]')
temperature=$(echo "$weather" | grep -oE '[+-]?[0-9]+°C')
humidity=$(echo "$weather" | grep -oE '[0-9]+%')

cpu=$(lscpu | awk -F: '/Model name/ {gsub(/^ +/, "", $2); print $2}')

while read -r line; do
  [ "${line#exec }" = "$line" ] || wm="${line#exec }"
done < "$HOME/.xinitrc"

if [ -x "$(command -v tput)" ]; then
  bold="$(tput bold)"
  accent="$(tput setaf 5)"
  reset="$(tput sgr0)"
fi

lc="${reset}${bold}${accent}"
nc="${reset}${bold}${accent}"
ic="${reset}"

cat <<EOF
${nc}${USER}@${host}
${lc}os: ${ic}${PRETTY_NAME}
${lc}kernel: ${ic}${kernel}
${lc}pkgs: ${ic}${pkgs}
${lc}cpu: ${ic}${cpu}
${lc}shell: ${ic}${SHELL}
${lc}wm: ${ic}${wm}
${lc}mem: ${ic}${mem}

${lc}weather: ${ic}$condition (${temperature} ${humidity})





EOF
