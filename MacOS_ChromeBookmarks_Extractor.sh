#!/usr/bin/env bash

# Ashraful Hoda, 21st March 2025

if [[ "$OSTYPE" == "darwin"* ]]; then
    BOOKMARKS_FILE="$HOME/Library/Application Support/Google/Chrome/Default/Bookmarks"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ -f "$HOME/.config/google-chrome/Default/Bookmarks" ]]; then
        BOOKMARKS_FILE="$HOME/.config/google-chrome/Default/Bookmarks"
    elif [[ -f "$HOME/.config/chromium/Default/Bookmarks" ]]; then
        BOOKMARKS_FILE="$HOME/.config/chromium/Default/Bookmarks"
    else
        echo "[!] No Chrome or Chromium bookmarks found!"
        exit 1
    fi
else
    echo "[!] Unsupported OS!"
    exit 1
fi

echo "[+] Bookmark file found successfully."
echo "[*] Do you want to save bookmarks to a separate file? (Y/n)"
read in
in=${in,,} 

if [[ "$in" == "y" ]]; then
    echo "Enter output file name:"
    read BookmarkFileOutputName
    awk -F'"' '/"url":/ {print $4}' "$BOOKMARKS_FILE" > "$BookmarkFileOutputName"
    echo "[+] Bookmarks written to '$BookmarkFileOutputName' successfully."
elif [[ "$in" == "n" ]]; then
    awk -F'"' '/"url":/ {print $4}' "$BOOKMARKS_FILE"
else
    echo "[!] Invalid input. Please enter 'Y' or 'n'."
    exit 1
fi
