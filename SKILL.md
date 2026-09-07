---
name: sayelf-photo-to-postcard
description: Turn a local photo into a styled postcard preview and export either the postcard alone or a combined original-photo-and-postcard PNG. Optionally install browser-local TensorFlow.js vision models to recognize arbitrary scenes and refresh copy/prompts from current-image evidence.
---

# SAYELF Photo-to-Postcard

Use the bundled `sayelf-photo-to-postcard.html` as the local user interface.

The optional-vision build decision is recorded in `references/build-decision-record.md`; installation and privacy details are in `references/local-vision.md`.

## Workflow

1. Open the HTML file in a modern browser.
2. Ask the user to choose a local image.
3. Let the user adjust style, ratio, language, title, subtitle, phrase, location, and date.
4. On upload, run the local workflow in this order: deconstruct the current image, produce a reconstruction/specification record, then distill the 03 copy fields and generate prompts from that record. Do not start from the previous image's copy or prompt.
5. The reconstruction record should include scene cue, dimensions, orientation/composition, tonal relationship, sampled colors, foreground/midground/background structure, and fidelity anchors. Use it as the only source for the new copy and prompts.
5a. Resolve scene topics in this order: explicit semantic filename cues (for example person/portrait, cat/pet, garden/bridge, tea, or mountain), then known visual-topic rules, then pixel-only inference. Person/portrait is a scene topic, not an art-domain option. Do not promote a generic square/warm/high-detail image to a specific city or landmark without semantic evidence.
5b. For an unfamiliar filename or ambiguous scene, offer the optional local vision pack described in `references/local-vision.md`. After `scripts/install-local-vision.ps1` has placed the local TensorFlow.js, COCO-SSD, and MobileNet bundles under `vision/vendor/`, click **加载并运行本地视觉识别**. Use the model labels as current-upload evidence to override weak filename/pixel guesses, then regenerate the reconstruction record, 03 copy, palette-linked prompt, and scene-specific anchors. If the pack is absent or cannot load, keep the existing browser-only heuristic fallback and say so.
6. Generate all four primary copy fields (Chinese title, English title, subtitle, and phrase) from the current image's local visual evidence. A manual edit may fine-tune the current card, but the next image recognition regenerates all four fields so different images receive different copy; location and date remain automatic metadata and update with each new image.
7. Click **一键生成** after choosing the photo and design settings. It synchronizes the preview, palette, metadata, and both image prompts.
8. Keep the extracted three-color palette synchronized with the preview and both generated prompts.
9. The art-domain and art-style selectors default to **自动随机**. When both remain automatic, choose from the full art-domain × art-style catalog and persist stable combination IDs in local browser storage so the most recent 30 generated combinations are not repeated. The catalog currently contains 32 combinations, which guarantees at least 30 consecutive automatic generations are distinct. If the user locks an art domain but leaves style automatic, apply the same recent-history exclusion within that domain's pool; if the user chooses a style manually, preserve the manual choice and do not consume a random slot.
10. Use the art-domain category selector before choosing a style. Categories include painting, oriental tradition, modern/abstract, drawing, and illustration/design; the selected category and style must be written into both prompts.
11. Make every image prompt contain the current reconstruction record and a consistency contract: keep the source-photo area faithful to the current upload (no repainting, regeneration, replacement, recoloring, stretching, or cropping; proportional scaling and layout padding only). Apply the selected art domain/style only to the lower stylized image, preserving subject count, silhouettes, positions, horizon/architecture relationships, crop, lighting direction, core colors, scene recognizability, and the source's visual spirit. For an external image-to-image/edit tool, start with moderate-low stylization strength around 0.35–0.55 and increase only when the same-scene check passes.
12. Treat the confirmed reference postcard as the fixed design-system and composition master: top source photo, lower-left metadata block, lower-right stylized-image slot, crop, subject placement, proportions, paper, frame, typography, ornaments, swatches and phrase all remain fixed. The selected art domain/style applies only inside the lower-right stylized-image slot.
12a. Fixed master contract: the upper slot uses the current original photo with full content preserved; the lower-left block contains No., English title, Chinese title, Subtitle, LOCATION, DATE, a healing/wisdom phrase and three color swatches; the lower-right slot is an artistic translation of the same photo and scene. Only that lower-right image slot may change through watercolor, illustration, oil, Van Gogh-inspired post-impressionism, sketch, abstract or vintage-poster treatment. Keep the macro structure fixed while matching copy to the recognized subject family: natural landscape (Snow Peak, Valley, River, Forest, Lake), city bridge (Afterglow, City Bridge, River Light), tea terraces (Tea Terraces, Green Hills), animals (Companion, Wilderness, Garden), and travel portraits (Journey, Quiet Moment, Field Note).
12b. Borrow whitespace references as a local visual vocabulary, never as copied content. Choose a breathing pattern such as sketch-air, centered editorial, handwritten-left, quiet portrait, or textile collage from the current scene and art style. The lower-right slot may use large paper margins, asymmetric type, irregular watercolor bleed, brush overflow, fabric/collage texture, or a centered subject, while the source photo, lower-left information block and same-scene identity stay locked.
12c. Offer the distilled template workflows for comparison: **融合默认 / 3:4 50:50** uses the original photo in the upper half and a lower concept poster with typography masking and type–image integration; **固定母版 / 信息明信片** keeps the established lower-left information block and lower-right art slot; **正反面陈列** keeps the upper source evidence and places a front/back postcard pair on warm paper below. Each uploaded photo produces one independent output; never combine separate uploads into a collage.
13. Use the requested download outlet:
   - **图片 + 明信片** exports one composite PNG containing the original photo beside the rendered postcard.
   - **仅明信片** exports the rendered postcard alone as PNG.
14. Confirm the browser reports that the PNG was generated. Do not claim success if the user has not uploaded a readable image.

## GitHub distillation and differentiation

The implementation was compared with public projects and guidance for image-to-image editing and local canvas export:

- [Hugging Face Diffusers img2img](https://github.com/huggingface/diffusers/blob/main/docs/source/en/using-diffusers/img2img.md): use the uploaded image as the content anchor and control stylization strength. Adopted as prompt guidance only; no model or runtime dependency is bundled.
- [Bernini prompt enhancer](https://github.com/bytedance/Bernini/blob/main/bernini/prompt_enhancer.py): separate requested modifications from explicit preservations. Adopted in the bilingual prompt's preservation/negative-constraint block.
- [StyleStudio](https://github.com/Westlake-AGI-Lab/StyleStudio) and [Arsenal style transfer](https://github.com/shubhamgoel27/arsenal-style-transfer): protect layout and subject positions while changing style. Adopted as same-scene, subject-count, silhouette, horizon and lighting constraints.
- [EbSynth](https://github.com/jamriska/ebsynth): guided style transfer preserves source detail. Not bundled because this product is a single-file, local-first postcard tool and does not require a model runtime for its deterministic preview/export path.
- [IBM TensorFlow.js Web App](https://github.com/IBM/tfjs-web-app): local-first browser inference with model caching. Adopted as an architectural reference for the optional installable vision pack, while using the official [TensorFlow.js models](https://github.com/tensorflow/tfjs-models) distributions for COCO-SSD object detection and MobileNet classification instead of copying IBM application code.

SAYELF remains differentiated by the fixed second-reference postcard design system, dynamic image decomposition and 03 copy matching, local PNG exports with two download outlets, bilingual copy/prompt generation, and 30-combination random style history. No third-party code, model weights, or remote assets are copied into the package.

## Constraints

- Keep photo decoding, palette extraction, preview, and PNG rendering inside the browser. Do not upload the image or add telemetry.
- Preserve the original photo's full content in exports with proportional scaling; do not center-crop the original/source-photo areas.
- For every original-photo/source-photo area, use proportional contain/letterbox rendering rather than center-crop rendering so the full uploaded image remains visible and its scene is not altered. The stylized area may be artistically processed, but must remain the same recognizable scene with unchanged subject identity and visual spirit.
- Export at the selected postcard ratio and use high-resolution canvas dimensions.
- Keep the two download buttons bound to distinct functions and filenames so users can identify each output.
- Keep `promptZh` and `promptEn` as separate, read-only image-prompt outputs. The one-click action must populate both in the same run.
- Place a copy action beside each prompt. On success, give immediate visible feedback such as `复制成功`; keep a local fallback for browsers that block the asynchronous clipboard API.
- Prefer native browser APIs; do not add a remote script, framework, or font dependency for the export path.
- Keep local vision optional and installable: the default HTML must not require a remote script or model. The installer may download public open-source bundles into `vision/vendor/`; runtime inference stays in the browser, and model weights are cached by the browser after first load.
- Treat the user's local image as private unless they explicitly classify it otherwise.
- Keep scene recognition evidence-bound: semantic topic matches are observations, while pixel-only scene labels remain hypotheses and must use neutral copy when confidence is low.
- The recent random-design history is local UI state only; it is bounded to 30 combination IDs, safely ignores malformed storage, and never leaves the browser.

## Output contract

- Postcard-only filename: `<source-name>-postcard.png`
- Composite filename: `<source-name>-photo-and-postcard.png`
- Both files must be PNG images generated locally.
