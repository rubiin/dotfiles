Source
How a lifelong Windows user switched to Linux… the hard way

An overview of challenges I encountered setting up Linux using a Debian base system.

February 6, 2017 ☕️☕️  7 min read   linux  

Let me preface this by saying that I’ve always been interested in finding out how things work. If a thing does something, I want to know why, how, and if I can customize it.

It should come as no surprise that Windows 10 drove me crazy.

Seemingly arbitrary updates that made for a long start-up process on any given day, surprise restarts that meant I’d lose my session and thus my thought process from the day before, and the worst part was I never knew what purpose they served. Windows 10 was an impenetrable mysterious hunk of blue screens and decisions I had no part in.

Thankfully for me and others like me, there is an alternative. Well, there are several - many Linux distros exist and the majority are familiar and totally usable when freshly installed. Perhaps one of the most well-known “Windows-like” distros is Ubuntu. It has a desktop similar to Windows 10 and is very graphical and geared generally towards those new to Linux.

I went with Debian, the distro that Ubuntu was forked off of. It doesn’t hold your hand as much as other feature-rich distributions, and is more customizable. I started with the small installation image found here which you can download and use to create a bootable USB.

Not entirely on purpose, thanks mostly to a crappy Internet connection (I’m a digital nomad in Southeast Asia - it’s par for the course) I ended up starting with Debian base system. It’s the most basic Debian install available, and excludes things that I as a previous Windows user take for granted. Among other things, I had to find and install (or at least configure): * A window manager (i3) * An application to let me connect to the Internet (NetworkManager/nm-applet) * A program that lets me control the brightness of my screen (xrandr) * A program that handles sound, called a sound server (pulseaudio) * Event handlers, like telling my laptop to suspend when I close the lid * A display for basic status information (i3bar) * Desktop notifications (dunst) * Basic programs like a graphical file manager (PCmanFM), pdf viewer (Okular), and image editor (Darktable)

If unlike me you’d rather start with a more fully-featured desktop environment, Debian’s Net Install gives you a “Standard system” with the GNOME desktop environment by default. There’s a full installation guide available for Debian that walks you through the process.

I learned a lot doing it the hard way, however. After starting with the base system, I have a much better perspective on what’s going on under the surface. If in the future I run into a problem with one component, I’m much more likely to have an idea of how to begin fixing it, since I put it together in the first place.

I did hit a few potholes along the way, as well as find some things that worked better than others. I’ve discussed some of these events in this post. But first, for motivation, the fully riced screenshot:
So worth it.
So worth it.

I posted all my config files on GitHub in case you want to swipe my sweet, sweet rice.

    What are config files in the first place?
    Where the heck do all these config files go?
    I picked a stupid user name, how do I change it?
    How do I get NetworkManager and Dropbox to start automatically?
    How do I set up OpenVPN with NetworkManager?
    How do I get my VPN status to show in i3bar?
    How do I get my Print Screen/backlight control/volume keys to work?
    I edited my config file, but I don’t see any changes. WTF?

If you’re new to Linux or to coding, these are basically the technical user’s version of “File > Preferences” in GUI programs. Depending on the application you’re configuring, there are a few different formats and languages. Thankfully, there are ample config file samples available with a simple web search.

I found some differing file paths. The below are mine and work:

systemd event handlers:   /etc/systemd/logind.conf
For URxvt:                ~/.Xdefaults
For i3wm:                 ~/.config/i3/config
For i3bar:                ~/.config/i3status/config/i3status.conf
For dunst:                ~/.config/dunst/dunstrc
for Compton:              ~/.config/compton.conf

This was a fun one. Turns out changing my user name messed up a whole bunch of stuff that I then had to go fix/reinstall, among them:

    Dropbox
    Anaconda and pip
    Filepaths written in full in config files

To avoid the hassle I experienced, change your user name before you set up most of your programs. If it’s too late for that, just be aware that many programs involving a filepath with /home/oldusername/... are affected.

To change your user name via the terminal, login as root, then:

$ killall -u oldusername
$ id oldusername
>>> uid=1000(oldusername) gid=1000(oldusername) groups=1000(oldusername),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),108(netdev)
# change login name
$ usermod -l newusername oldusername
# change group name
$ groupmod -n newusername oldusername
# modify home directory
$ usermod -d /home/newusername -m newusername
# add comment with full name
$ usermod -c "New Full Name" newusername
# check that "newusername" replaces "oldusername" in all fields
$ id newusername
>>> uid=1000(newusername) gid=1000(newusername) groups=1000(newusername),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),108(netdev)

If you previously set your background image in i3 and it disappears, don’t forget to check the filepath in your config file.

Dropbox for Linux supposedly has an autostart setting where you can type dropbox autostart y into a terminal and it’ll listen. This didn’t work for me. Instead, I added any applications I wanted to start automatically upon login to my i3 config file with this syntax:

# start apps automatically
exec --no-startup-id /usr/bin/nm-applet
exec --no-startup-id dropbox start

In the above, exec is “execute”, \--no-startup-id basically saves you from watching your cursor do the spinny loading thing, and the last component of the command is the filepath to the program or the syntax to start it, as if typing it into the terminal.

First, make sure you’ve done apt-get install network-manager-openvpn to get the plugin.

You’ll need your client.ovpn file. In my case, I set up my own VPN using Amazon EC2, and downloaded the client.ovpn file from my OpenVPN console page.

Open client.ovpn with a text editor (like vim or gedit) and change any instances of “remote openvpn port xxxx” to read “remote < your ip address > port xxxx” instead.

Use nm-applet to set up a new VPN connection. If you’ve installed the OpenVPN plugin, you’ll see OpenVPN as an option in the dropdown. Choose the option to “Import a saved VPN configuration”.

Once you load up your client.ovpn file and click “Create,” all the settings will be filled out for you except for your user name and password. Plug those in and you’re good to go.

Locate your i3status config file. If you don’t have one yet, you can use an awesome template like mine.

Edit the filepath in the following section of code:

run_watch VPN {
        pidfile = "sys/class/net/yourspecialsetting0"
}

Where “yourspecialsetting” is any one of tap/tun/tun tap depending on your VPN settings. If you don’t know which it is, you can find out in the VPN configuration settings under VPN > Advanced > “Set virtual device type”.

I used key bindings in my i3 config file. The tricky part was finding out what controlled the particular function (and on some occasions, having to install something to control the function).

# brightness adjustment (pre-defined levels)
bindsym $mod+Shift+F6 exec xrandr --output eDP-1 --brightness 1
bindsym $mod+F6       exec xrandr --output eDP-1 --brightness 0.8
bindsym $mod+F5       exec xrandr --output eDP-1 --brightness 0.5
bindsym $mod+F7       exec xrandr --output eDP-1 --brightness 0.1

# volume control (increment)
bindsym $mod+F12 exec amixer -q sset Master 3%+
bindsym $mod+F11 exec amixer -q sset Master 3%-
bindsym $mod+F10 exec amixer -q sset Master toggle

As you can see, in the case of xrandr I could only find a way to set certain levels. For volume control, amixer seems to offer increments.

For some things, like the wallpaper in i3 and dunst notifications, I found I had to either reload the application (for i3, type i3-msg restart in the terminal) or restart my X session (logout and log back in) to see the changes.

The switch to Linux has definitely been worth it. Though some of the process of learning and discovery was finicky and frustrating, I honestly enjoyed every minute. Nothing beats the feeling of figuring something out and making it work!

I hope you’ve found this post useful. Thanks for reading!
