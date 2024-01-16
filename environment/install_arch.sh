#!/bin/bash
# Install Script for Arch Linux
# SolarDebris

# Function to update to use througout the program
update(){
	sudo pacman -Syy
	sudo pacman -Syu
}

cd ~
mkdir -p fitsec build development applications src vr vr/ios vr/linux vr/windows vr/browser

# Install languages and lsps
langs(){
	echo "Installing languages and lsps"
  	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  	sudo pacman -S cmake \
  		haskell \
   		java \
  		julia \
		neovim \
 		nodejs \
  		npm \ 
		python3 \
 		ruby
}


# Install Paru
paru(){
	echo "Installing Paru (AUR Helper)\n"

	cd ~/build
	[ ! -d 'paru' ] && git clone https://aur.archlinux.org/paru.git
	cd paru
 	rustup default stable
	makepkg -si 
	
}

display(){
	echo "Installing Desktop Environment and Display Servers"
    # Install desktop environments
    
    sudo pacman -S wayland \
        sway \
		swaybg \
 		wofi \
  		waybar 

   	sudo pacman -S xorg \
   		xorg-server \
    	xorg-xinit 
}

audio(){

	echo "Installing Audio Server (Pipewire)"
	# Install pipewire
	sudo pacman -S pipewire \
		lib32-pipewire \
		wireplumber \
		pipewire-audio \
		pipewire-pulse \
		pipewire-alsa \
		pipewire-jack \
		pulsemixer \
		qjackctl \
		xdg-desktop-portal
}

# Install Browsers

browser(){
    echo "Installing Browsers and Dependencies"
    sudo pacman -S firefox
    paru -S brave-bin
}

# Install Terminal Utils
term_utils(){

    echo "Installing Terminal Utilities"
    sudo pacman -S alacritty \
	    bat \
	    binutils \
	    binwalk \
	    build-essentials \
	    clang \
	    cronie \
	    curl \
	    docker \
        elfutils \
	    emacs \
	    exa \
	    feh \
	    ffmpeg \
	    file \
	    gcc \
	    gcc-arm \
	    g++ \
	    gdb \
	    make \
      	man \
	    man-db \
	    net-tools \
	    neofetch \
	    openbsd-netcat \
	    p7zip \
	    ripgrep \
	    starship \
	    tar \
	    tmux \
	    wget \
	    xxd
}

extra(){

  echo "Installing Extra Packages"
  # Install extra packages
  sudo pacman -S aircrack-ng \
	  arandr \
	  audacity \
	  feroxbuster \
	  firefox \ 
	  foremost \
	  ghc \
	  gnuradio \
	  gqrx \
	  groff \
	  hashcat \
	  iptables \
	  jq \
	  make \
	  mitmproxy \
	  neofetch \ 
	  nmap \
	  patchelf \
	  qemu \
	  ruby \
	  strace \
	  tcpdump \
	  upx \
	  urh \
	  wget \
	  zathura
}

python(){
  echo "Installing python packages"
  python3 -m pip install \ 
     angr \
     capstone \
     Flask \
     Flask-Cors \
     keystone-engine \
     matplotlib \
     opencv-python \
     numpy \
     pwntools \
     pycryptodome \
     requests \
     ropgagdet \
     unicorn \
     z3-solver
  
}

docker(){
    echo "Installing Docker"
	sudo pacman -S docker \
 		docker-compose
   
}

install_qemu(){
	echo "Installing QEMU and VM Tools"
  	sudo pacman -S qemu-full \
  		dnsmasq \
   		vde2 \
    	dmidecode \
   		virt-manager \
   		virt-viewer \
    	bridge-utils \
    	openbsd-netcat \
    	iptables \
    	ebtables \
		libguestfs 
	sudo systemctl enable libvirtd.service && sudo systemctl start libvirtd.service
https://github.com/godotengine/godot/releases/download/4.2.1-stable/Godot_v4.2.1-stable_linux.x86_64.zip
  	sudo usermod -aG libvirt $(whoami)
   	newgrp libvirt
   	sudo systemctl restart libvirtd.service 
 
}

binja(){
  echo "Installing Binary Ninja"
  # Get the source
  [ ! -d '~/build/binaryninja-api' ] && git clone https://github.com/Vector35/binaryninja-api.git ~/build/binaryninja-api
  cd ~/build/binaryninja-api
  git submodule update --init --recursive

  # Configure an out-of-source build setup
  cmake -S . -B build # (additional arguments go here if needed)

  # Compile
  cmake --build build -j8
}

arm(){
	echo "Installing ARM tools"
  	sudo pacman -S \
	    arm-none-eabi-binutils \
    	arm-none-eabi-gcc 

}

afl(){
  	echo "Installing AFL++"
}

libraries(){
  	echo "Installing extra libraries"
}

dbg(){
	
  	echo "Installing gdb multiarch" 

 	 echo "Installing pwndbg"
  	[ ! -d '~/build/pwndbg' ] && git clone https://github.com/pwndbg/pwndbg ~/build/pwndbg
  	cd ~/build/pwndbg
  	chmod +x setup.py
  	./setup.py

  	echo "Installing lldb"

  	echo "Installing Frida"
 	pip3 install frida-tools

}

ctf() {
    echo "Installing CTF Tools"
}

gamedev(){
	echo "Installing Raylib"
	sudo pacman -S alsa-lib \
 		mesa \
   		libx11 \
	 	libxrandr \
   		libxi \
	 	libxcursor \
   		libxinerama 
	[ ! "~/build/raylib"] && git clone https://github.com/raysan5/raylib.git ~/build/raylib
 	cd ~/build/raylib
  	mkdir build && cd build
   	cmake -DBUILD_SHARED_LIBS=ON -DUSE_WAYLAND=ON
	make 
 	sudo make install

  	echo "Installing Godot"
   	cd ~/build
   	wget https://github.com/godotengine/godot/releases/download/4.2.1-stable/Godot_v4.2.1-stable_linux.x86_64.zip
	7z x Godot_v4.2.1-stable_linux.x86_64.zip
 	mv Godot_v4.2.1-stable_linux.x86_64 Godot
  
}

config() {
    
    [ ! -d 'dotfiles' ] && git clone https://github.com/SolarDebris/dotfiles 
    cp -r ~/dotfiles/.config ~/
    cp -r ~/dotfiles/.doom.d ~/
    cp -r ~/dotfiles/.tmux ~/
    cp -r ~/dotfiles/.bashrc ~/
    cp -r ~/dotfiles/.tmux.conf ~/
    cp -r ~/dotfiles/.vimrc ~/
    cp -r ~/dotfiles/.zshrc ~/
}

