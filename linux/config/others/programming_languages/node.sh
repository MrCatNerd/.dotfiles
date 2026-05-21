#!/bin/env bash

# installs NVM (Node Version Manager)
curl -o- -s https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# download and install Node.js
nvm install 24

# verifies the right Node.js version is in the environment
node -v # should print `v24.x.x`

# verifies the right NPM version is in the environment
npm -v # should print `11.x.x`

# magic stuff
nvm alias default node
