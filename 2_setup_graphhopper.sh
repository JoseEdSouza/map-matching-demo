#!/bin/sh

set -e

echo "WARNING: This script erases any current setup of GraphHopper! If you alredy have a GraphHopper setup, abort then just run 'make run-graphhopper' instead."

read -p "Do you want to continue? (y/n) " choice
if [ "$choice" != "y" ]; then
    echo "Aborting setup."
    exit 1
fi

echo "Setting up GraphHopper..."

make setup-graphhopper

echo "GraphHopper setup completed."

make run-graphhopper