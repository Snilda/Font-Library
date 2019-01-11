!/bin/bash

osdetect=$(uname)
file_path="unknown"
if [[ "$osdetect" == 'Darwin' ]]; then
  file_path="/Library/Fonts/"
elif [[ "$osdetect" == 'Linux' ]]; then
  if [[ -d /usr/local/share/fonts/Snilda/ ]]; then # Debian/Ubuntu and others.
    file_path="/usr/local/share/fonts/Snilda/"
  elif [[ -d /usr/share/fonts/ ]]; then # OpenSUSE, Arch and other distros using this directory structure
    sudo mkdir -p /usr/share/fonts/Snilda/
    file_path="/usr/share/fonts/Snilda/"
  else # Fallback to installing fonts locally to the user, this is a safe bet, as several distros use this location.
    mkdir -p ~/.fonts
    file_path="~/.fonts/"
  fi
fi

clear
echo "Installing all Fonts onto your System"
echo "Downloading the fonts..."
curl -L https://github.com/Snilda/Font-Library/tree/master/tarball/Cyrillic -o /tmp/master.tar.gz
echo "Extracting the fonts..."
mkdir -p /tmp/fonts
tar -zxf /tmp/master.tar.gz -C /tmp/goog-fonts/fonts
sudo find /tmp/fonts/ -type f -name "*.ttf" -exec cp {} $file_path \;

echo "Fonts installed; Cleaning up files..."
rm -f /tmp/master.tar.gz
rm -rf /tmp/fonts
echo "All done! All Fonts installed."