### Firefox ESR

`sudo apt-get install firefox-esr firefox-esr-l10n-all`

[Debian Firefox Wiki](https://wiki.debian.org/Firefox)

### Chromium

`sudo apt-get install chromium chromium-l10n`

This is the open source browser behind Google's Chrome.

### Google Chrome

Download [the ".deb" file from Google](https://www.google.com/chrome/).

`sudo dpkg -i /path/to/the/chrome/deb/file && sudo apt-get install -f`

According to [Google documentation](https://www.google.com/linuxrepositories/), installing the package will automatically configure the repository. So the manual steps of adding the Google repository can be skipped.

Here is what happened during the installation:

1. An apt sources file, `/etc/apt/sources.list.d/google-chrome.list`, is added. Here is the content
```
deb [arch=amd64] http://dl.google.com/linux/chrom/deb/ stable main
```
2. A public signing key from Google is added to apt. Run `sudo apt-get list` to see the key. You can manually add the key
```
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
```
3. The package `google-chrome-stable` and its dependencies are installed
