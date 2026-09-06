# SAYELF Photo-to-Postcard v0.4

Local-first photo-to-postcard tool. Upload an image in the browser, keep the original photo faithful, generate a same-scene artistic prompt, and export either a postcard PNG or a combined photo-and-postcard PNG.

## Use

1. Open `sayelf-photo-to-postcard.html` in a modern browser.
2. Upload a local image.
3. Optionally choose an art domain/style or keep **自动随机**.
4. Use **一键生成**, then download the postcard or the composite PNG.

## Optional local vision

For generic filenames, install the browser-local TensorFlow.js vision pack:

```powershell
.\scripts\install-local-vision.ps1
```

Then upload a photo and click **加载并运行本地视觉识别**. See [references/local-vision.md](references/local-vision.md) for model caching, privacy, and licenses.

The default HTML remains usable without the optional model files and falls back to local filename/pixel heuristics. User images are processed in the browser and are not included in this repository.
