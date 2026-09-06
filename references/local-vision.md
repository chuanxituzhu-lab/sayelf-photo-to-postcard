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

After installation, open `sayelf-photo-to-postcard.html`, upload a photo, and click **加载并运行本地视觉识别**. The browser uses COCO-SSD labels (for example `person`, `cat`, `dog`, `potted plant`, `boat`, `mountain`) and MobileNet classifications as additional evidence. The result is used to update the scene decomposition, the four automatic 03 copy fields (unless manually edited), and the Chinese/English prompts. The original upload remains the source image; the labels never authorize a new subject or a new scene.

The first model load may fetch the model weights required by the official TensorFlow.js model loader. The browser then caches those weights in IndexedDB, so later runs can use the local cache. If the optional files are missing or a model cannot load, the tool falls back to its existing filename and pixel heuristics and continues to export PNGs.

## Privacy and licensing

- Image inference runs in the browser. SAYELF does not upload the image to a SAYELF server.
- The user photo is local/sensitive data and must not be added to a public repository or ZIP release.
- The downloaded runtime and model bundles are open-source dependencies. The installer also attempts to save their licenses in `vision/licenses/`.
- IBM's TensorFlow.js web app is used as a local-first reference pattern; this package uses the official TensorFlow.js model distributions rather than copying IBM application code.

References:

- IBM TensorFlow.js Web App: https://github.com/IBM/tfjs-web-app
- TensorFlow.js models: https://github.com/tensorflow/tfjs-models
- COCO-SSD: https://github.com/tensorflow/tfjs-models/tree/master/coco-ssd
- MobileNet: https://github.com/tensorflow/tfjs-models/tree/master/mobilenet
