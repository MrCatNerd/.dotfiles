sudo apt-get install -y \
    xboxdrv \
    xserver-xorg-input-joystick\
    jstest-gtk

sudo cp xboxdrv /etc/default/xboxdrv

echo "You can test the controller using tools like jstest-gtk: jstest-gtk (yes I this script already installed jstest-gtk)"

echo "Instructions:"
printf "Warning, this guide sucks, for a better guide look at: https://github.com/gotbletu/shownotes/blob/master/xboxdrv.md\nOr watch this video: https://youtu.be/JfcSMRooHLU\n\n\n"

echo "Step 1:"
printf "Go disable xpad in /etc/modprobe.d/blacklist.conf\nblacklist xpad\nNote: add that line into the conf to disable xpad so it won't interfere with other stuff\n\n"

echo "Step 2:"
printf "(WARNING: before u read this next step i just wanna tell ya that the script put a config (based on my preferences that may work))\nGo to /etc/default/xboxdrv and change the settings based on the github repo earlier (section Configuration)\n\n"

echo "Step 3:"
printf "type these two commands when finished:\nsudo systemctl enable xboxdrv.service\nsudo systemctl start xboxdrv.service\nNote: just to be sure restart your computer to apply all the changesd\n"

printf "\nYou're done!\n"
printf "\n\nExtra Information:\nThe Xbox 360 controller does not have an \"off\" button It -\nwill auto shutoff when it idles for about 5-10mins To turn it on just hold the middle Xbox logo button\n"
