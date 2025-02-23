#!/bin/bash
# Install Script for Arch Linux
# SolarDebris

# Function to update to use througout the program
update(){
	sudo pacman -Syy --noconfirm
	sudo pacman -Syu --noconfirm
}

cd ~
mkdir -p fitsec build development applications src vr vr/ios vr/linux vr/windows vr/browser

# Install languages and lsps
devtools(){
	echo "Installing devtools languages and lsps"
  	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  	sudo pacman -S --noconfirm autoconf \
        automake \
        clang \
        cmake \
        gdb \
        gdb-common \
        ghc \
        gnupg \
        go \
  		haskell \
   		java \
  		julia \
        llvm \
        lua \
        make \
        meson \
		neovim \
        ninja \
 		nodejs \
  		npm \ 
    	pkgconfig \
		python3 \
        ripgrep \
 		ruby \
        tree-sitter \
        ttf-firacode-nerd \
        ttf-nerd-fonts-symbols \
        zoxide
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
    
    sudo pacman -S --noconfirm glfw-wayland \
        sway \
		swaybg \
        qt5-wayland \
 		wofi \
  		waybar \
        wayland 
        

   	sudo pacman -S xorg \
   		xorg-server \
    	xorg-xinit \
        xorg-xwayland
}

audio(){

	echo "Installing Audio Server (Pipewire)"
	# Install pipewire
	sudo pacman -S  --noconfirm pipewire \
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
    sudo pacman -S --noconfirm firefox
    paru -S brave-bin
}

# Install Terminal Utils
term_utils(){

    echo "Installing Terminal Utilities"
    sudo pacman -S --noconfirm alacritty \
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
  sudo pacman -S --noconfirm aircrack-ng \
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
  python3 -m pip install --break-system-packages angr \
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
	sudo pacman -S --noconfirm docker \
 		docker-compose
   	sudo usermod -aG docker $(whoami)
	newgrp docker
	sudo systemctl enable docker
 	sudo systemctl start docker
}

qemu(){
	echo "Installing QEMU and VM Tools"
  	sudo pacman -S --noconfirm qemu-full \
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
  	sudo pacman -S --noconfirm \
	    arm-none-eabi-binutils \
    	arm-none-eabi-gcc 

}

afl(){
  	echo "Installing AFL++"
    cd ~/build/
    git clone https://github.com/AFLplusplus/AFLplusplus
    cd AFLplusplus
    make all
    sudo make install
 
    sudo pacman -S --noconfirm base-devel \
        flex \
        bison 
    
    cd ~/build
    git clone --recursive https://github.com/AFLplusplus/AFLplusplus 
    
    cd ~/build/AFLplusplus
    make all 
    sudo make install

    
    cd ~/build
    git clone --recursive https://github.com/AFLplusplus/LibAFL

}

libraries(){
  	echo "Installing extra libraries"
}


frida(){
    echo "Installing Frida"
    cd ~/build
    git clone --recurse-submodules https://github.com/frida/frida
    cd ~/build/frida
    make core-linux-x86_64 NODE=$(which node) PYTHON=$(which python3)
    make python-linux-x86_64 NODE=$(which node) PYTHON=$(which python3)
}

webdev(){
    echo "Installing web development tools"
    sudo pacman -S --noconfirm \
        nodejs \
        npm
}

dbg(){
	
  	echo "Installing gdb multiarch" 

 	 echo "Installing pwndbg"
  	[ ! -d '~/build/pwndbg' ] && git clone https://github.com/pwndbg/pwndbg ~/build/pwndbg
  	cd ~/build/pwndbg
  	chmod +x setup.py
  	./setup.py

  	echo "Installing lldb"
    sudo pacman -S lldb

 	pip3 install frida-tools

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

webdev(){
    echo "Installing web development tools"
    sudo pacman -S nodejs \
        npm

    pip3 install --break-system-packages flask \
        flask-cors \
        django

}


creative(){
    echo "Installing creative tools"
    sudo pacman -S blender \
        imagemagick \
        gimp 
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
    cp -r ~/dotfiles/emacs ~/.emacs.d
}

discord(){
    paru -S discord

    cd ~/.config/discord

    echo "{ SKIP_HOST_UPDATE: true }" > settings.json

}

