#!/bin/bash
# Install Script for Arch Linux
# SolarDebris

# Function to update to use througout the program
update(){
	sudo pacman -Syy
	sudo pacman -Syu
}

cd ~
mkdir fitsec build development applications src vr vr/ios vr/linux vr/windows vr/browser

# Install languages and lsps
install_langs(){
  echo "Installing languages and lsps"
}


# Install Paru
install_paru(){
	echo "Installing Paru (AUR Helper)\n"

	cd ~/build
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si 
	rustup default stable
}

echo "Installing Desktop Environment and Display Servers"
# Install desktop environments
sudo pacman -S wayland

install_audio(){

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

echo "Installing Browsers and Dependencies"
sudo pacman -S firefox
paru -S brave-bin

# Install Terminal Utils
install_term_utils(){

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

install_extra(){

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

install_python(){
  echo "Installing python packages"
  python3 -m pip install \ 
     angr \
     capstone \
     keystone-engine \
     opencv-python \
     pwntools \
     ropgagdet \
     unicorn \
     z3-solver
  
}

install_docker(){
    echo "Installing Docker"
}

install_qemu(){
  echo "Installing QEMU"
}

install_binja(){
  echo "Installing Binary Ninja"
  # Get the source
  git clone https://github.com/Vector35/binaryninja-api.git ~/build/binaryninja-api
  cd ~/build/binaryninja-api
  git submodule update --init --recursive

  # Configure an out-of-source build setup
  cmake -S . -B build # (additional arguments go here if needed)

  # Compile
  cmake --build build -j8
}

install_arm(){
  echo "Installing ARM tools"
  sudo pacman -S \
    arm-none-eabi-binutils \
    arm-none-eabi-gcc 

}

install_afl(){
  echo "Installing AFL++"
}

install_libraries(){
  echo "Installing extra libraries"
}

install_dbg(){
  echo "Installing gdb multiarch" 

  echo "Installing pwndbg"
  git clone https://github.com/pwndbg/pwndbg ~/build/pwndbg
  cd ~/build/pwndbg
  chmod +x setup.py
  ./setup.py

  echo "Installing lldb"

  echo "Installing Frida"
  pip3 install frida-tools

}

echo "Installing CTF Tools"

