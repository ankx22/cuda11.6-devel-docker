FROM nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04

# Avoid interactive dialogues from apt-get install and tzdata
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

COPY requirements.txt /tmp/requirements.txt

# apt-get update && 
RUN apt-get update && apt-get install -y \
    vim \
    libgl1-mesa-glx \
    libcairo2 \
    libgirepository1.0-dev \
    libgtk-3-dev \
    python3-gi \
    python3-gi-cairo \
    gir1.2-gtk-3.0 \
    python3-tk \
    xvfb \
    xauth \
    xorg \
    dbus-x11 \
    x11-xserver-utils \
    libxext-dev \
    libxrender1 \
    libxtst6 \
    libfreetype6-dev \
    libfontconfig1 \
    libxcb1-dev \
    libx11-dev \
    python3-pip \
    python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Install Python packages
# RUN pip install remotezip tqdm opencv-python einops matplotlib numpy seaborn tensorflow-gpu==2.10 scikit-learn
RUN pip install -r /tmp/requirements.txt

# Add alias to .bashrc
RUN echo "alias lt='ls -lrth'" >> ~/.bashrc

# Set the working directory (optional)
WORKDIR /data