# Build Decision Record: optional local vision

- **Problem:** filenames and pixel heuristics are not enough for arbitrary unfamiliar images.
- **Closest existing solutions:** IBM TensorFlow.js Web App (local browser inference and cache pattern); official TensorFlow.js COCO-SSD and MobileNet packages (maintained browser models).
- **Decision:** Integrate and improve rather than build a new vision model. Add an optional local install script and a browser loader; keep the default postcard path dependency-free with a deterministic fallback.
- **Measurable improvement:** model labels can override weak filename/pixel guesses and refresh scene deconstruction, 03 copy, and bilingual prompts from the current upload; no image leaves the browser.
- **Current copy-matching rule:** COCO-SSD, MobileNet, pixel statistics, composition and bounded local copy history now drive all four 03 fields; each recognized upload receives a new four-field combination when a prior combination already exists.
- **Non-goals:** no cloud vision endpoint, no custom training pipeline, no model weights forced into the single-file default package, and no redesign of the fixed postcard layout.
- **Safety/data boundary:** user images remain local/sensitive; only public open-source model bundles are downloaded by the installer; user photos and generated previews are not published.
