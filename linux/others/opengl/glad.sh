CURRENT_DIR="$PWD"

echo "Unzipping glad.zip"
unzip -qq glad.zip -d glad

sudo cp -R glad/include/* /usr/include/
printf "Success\nNow copy the file glad.c inside the src folder to your current working directory\n"

cd "$CURRENT_DIR"
