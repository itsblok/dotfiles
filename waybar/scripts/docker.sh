#!/usr/bin/env bash
running=$(docker ps -q | wc -l)
total=$(docker ps -aq | wc -l)
echo "$running/$total"
