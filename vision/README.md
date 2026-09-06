# SAYELF local vision assets

This directory is intentionally small in the default package. Run `../scripts/install-local-vision.ps1` to download the TensorFlow.js, COCO-SSD, and MobileNet browser bundles into `vendor/`. The HTML loader only looks for local files at that path; without them it keeps the built-in heuristic fallback.
