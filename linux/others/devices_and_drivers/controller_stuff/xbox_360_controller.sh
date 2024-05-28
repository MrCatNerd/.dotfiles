sudo apt-get install -y --install-recommends\
    jstest-gtk\
    joystick\
    xboxdrv\
    xserver-xorg-input-joystick

sudo cp xboxdrv /etc/default/xboxdrv

echo "blacklist xpad" | sudo tee -a /etc/modprobe.d/blacklist.conf
sudo rmmod xpad  # unload module if already loaded
# xboxdrv --silent
# jstest-gtk

printf "start on filesystem\nexec xboxdrv -D\nexpect fork\n" | sudo tee -a /etc/init/xboxdrv.conf

echo "Changed files in /etc/init/xboxdrv.conf /etc/modprobe.d/blacklist.conf /etc/default/xboxdrv and probably in other places"


echo "You can test the controller using tools like jstest-gtk: jstest-gtk (yes I this script already installed jstest-gtk)"

printf "Go look at: https://github.com/gotbletu/shownotes/blob/master/xboxdrv.md\nOr watch this video: https://youtu.be/JfcSMRooHLU\n\n\n to understand what the hell you are doing"
echo "You should also look at: https://askubuntu.com/questions/165210/how-do-i-get-an-xbox-360-controller-working#180044"
