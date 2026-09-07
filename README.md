# SAYELF Photo-to-Postcard v0.4

Local-first photo-to-postcard tool. Upload an image in the browser, keep the original photo faithful, generate a same-scene artistic prompt, and export either a postcard PNG or a combined photo-and-postcard PNG. The default master is fixed: original photo on top, metadata and copy at lower left, and same-scene artistic translation at lower right.

## Use

1. Open `sayelf-photo-to-postcard.html` in a modern browser.
2. Upload a local image.
3. Choose a template workflow for comparison: **融合默认 / 3:4 50:50** (typography mask), **固定母版 / 信息明信片**, or **正反面陈列**. The sketch-air, centered-editorial and textile-collage variants are available as lower-area treatments.
4. Optionally choose an art domain/style or keep **自动随机**. Style changes apply only to the selected lower design method; the source photo remains the evidence anchor.
5. Use **一键生成**, then download the postcard or the composite PNG. Each upload produces an independent output.

## Optional local vision

For generic filenames, install the browser-local TensorFlow.js vision pack:

```powershell
.\scripts\install-local-vision.ps1
```

Then upload a photo; the local vision pack runs automatically when available, and **加载并运行本地视觉识别** can run it again. See [references/local-vision.md](references/local-vision.md) for model caching, privacy, and licenses.

The default HTML remains usable without the optional model files and falls back to local filename/pixel heuristics. User images are processed in the browser and are not included in this repository.

## Fixed postcard master

- **Top:** the uploaded original photo, preserved with proportional scaling and layout padding only.
- **Lower left:** No., English title, Chinese title, Subtitle, LOCATION, DATE, a healing/wisdom phrase, and three extracted core colors.
- **Lower right:** an artistic translation of the same photo and scene. Watercolor, illustration, oil, Van Gogh-inspired post-impressionism, sketch, abstract and vintage-poster styles may change the medium inside this slot only. Its internal whitespace rhythm may borrow sketch-air, centered-editorial, handwritten-left, quiet-portrait or textile-collage references and may use irregular edges without changing the macro structure.

Copy is matched from the recognized image family: natural landscape, city bridge, tea terraces, animals, or travel portrait. Different uploads receive different four-field copy combinations through bounded local history.

Reference images supplied locally are used as whitespace inspiration only. Their subjects and artwork are not copied or published.

See [references/template-workflows.md](references/template-workflows.md) for the distilled workflows and comparison templates.
