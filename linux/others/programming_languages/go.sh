#!/bin/env bash

# add golang repo
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get update

sudo apt-get install -y golang-go
