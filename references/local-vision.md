# Optional local vision pack

SAYELF Photo-to-Postcard keeps its default path dependency-free. For arbitrary uploads whose filenames contain no useful meaning, install the optional browser-local vision pack:

```powershell
Set-Location .\sayelf-photo-to-postcard-v0.4
.\scripts\install-local-vision.ps1
```

The installer places the open-source browser bundles under `vision/vendor/`:

- TensorFlow.js 4.22.0 runtime
- TensorFlow.js COCO-SSD 2.2.3 object detector
- TensorFlow.js MobileNet 2.1.1 image classifier

After installation, open `sayelf-photo-to-postcard.html` and upload a photo. The browser automatically runs the local vision pack when available; the button **加载并运行本地视觉识别** can run it again. It combines COCO-SSD labels (for example `person`, `cat`, `dog`, `potted plant`, `boat`, `mountain`) with MobileNet classifications and local pixel evidence. The result updates the scene decomposition, regenerates all four 03 copy fields for the current image, and refreshes the Chinese/English prompts. A bounded local copy history prevents the same four-field combination from repeating. The original upload remains the source image; the labels never authorize a new subject or a new scene.

The first model load may fetch the model weights required by the official TensorFlow.js model loader. The browser then caches those weights in IndexedDB, so later runs can use the local cache. If the optional files are missing or a model cannot load, the tool falls back to its existing filename and pixel heuristics and continues to export PNGs.

## IBM Granite Vision (optional, stronger local evidence)

The WebUI can optionally call IBM Granite 3.2 Vision through a local Ollama service. Install Ollama, then run:

```powershell
.\\scripts\\install-ibm-vision.ps1
```

The default model is `ibm/granite3.2-vision:2b-q4_K_M`. In **视觉后端**, choose **自动融合 · 浏览器 + IBM Granite** to keep the browser detector and add IBM scene, subject, lighting, composition and color evidence, or choose **IBM Granite Vision · Ollama 本地** to prefer IBM and fall back to the browser models if the local service is unavailable. The adapter uses `http://127.0.0.1:11434/api/chat`, resizes the current image locally, and never sends it to a cloud endpoint. IBM output is treated as visible-image evidence only: exact locations, identities, dates and unseen objects are discarded.

## Privacy and licensing

- Browser inference runs in the browser; when IBM Granite is selected, the resized image is sent only to the user's local Ollama service at `127.0.0.1:11434`. SAYELF does not upload the image to a SAYELF server or cloud vision API.
- The user photo is local/sensitive data and must not be added to a public repository or ZIP release.
- The downloaded runtime and model bundles are open-source dependencies. The installer also attempts to save their licenses in `vision/licenses/`.
- IBM's TensorFlow.js web app is used as a local-first reference pattern; this package uses the official TensorFlow.js model distributions rather than copying IBM application code.

References:

- IBM TensorFlow.js Web App: https://github.com/IBM/tfjs-web-app
- IBM Granite Vision model family: https://github.com/ibm-granite/granite-vision-models
- IBM Granite 3.2 Vision for Ollama: https://ollama.com/ibm/granite3.2-vision
- TensorFlow.js models: https://github.com/tensorflow/tfjs-models
- COCO-SSD: https://github.com/tensorflow/tfjs-models/tree/master/coco-ssd
- MobileNet: https://github.com/tensorflow/tfjs-models/tree/master/mobilenet
