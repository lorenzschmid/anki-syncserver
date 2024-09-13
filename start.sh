#!/bin/sh

# Update the Anki sync server package
echo "Updating Anki sync server package..."
pip install --upgrade anki

# Start the Anki sync server
echo "Starting Anki sync server..."
exec python -m anki.syncserver
