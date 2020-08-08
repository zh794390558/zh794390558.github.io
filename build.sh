#!/bin/bash

pip install -r requirements.txt

rm -rf docs/*
pushd src; make github
