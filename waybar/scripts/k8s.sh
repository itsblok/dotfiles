#!/usr/bin/env bash
running=$(kubectl get pods --all-namespaces --field-selector=status.phase=Running --no-headers 2>/dev/null | wc -l)
total=$(kubectl get pods --all-namespaces --no-headers 2>/dev/null | wc -l)
echo "$running/$total"
