### Google Chrome

Open `Terminal` and use the command below to edit sources.list,

`sudo gedit /etc/apt/sources.list`

Append the text below to the list end,

`deb http://dl.google.com/linux/chrome/deb/ stable main`

Then use `wget` to download the public key,

`wget https://dl-ssl.google.com/linux/linux_signing_key.pub`

Install the public key,

`sudo apt-key add linux_signing_key.pub`

Now update local package and install chrome stable version,

`sudo apt-get update`

`sudo apt-get install google-chrome-stable`
