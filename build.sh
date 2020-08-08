#!/bin/bash

pip install -r requirements.txt

pushd src; make github
