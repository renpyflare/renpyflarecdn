#!/bin/sh

echo "Activating i386 Architecture..."
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y libssl-dev:i386
echo "Done!"
