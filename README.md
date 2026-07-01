# Goal-Line Technology in Soccer

This repository contains an undergraduate final-year MATLAB project that explores a simple computer-vision approach for deciding whether a soccer ball has crossed the goal line.

The project is best read as a prototype/demo rather than a production-ready goal-line technology system. It combines:

- goal-line detection,
- ball detection with Laplacian of Gaussian blob detection,
- geometric distance checks between the detected ball and goal line,
- frame annotation, and
- output video generation.

## Project Overview

The main pipeline lives in `finaltemp.m`.

At a high level, it:

1. Detects or receives the goal-line endpoints through `line1()`.
2. Iterates through extracted `.jpg` video frames.
3. Reads each frame and detects candidate ball blobs.
4. Chooses the most likely ball blob.
5. Computes the ball center/radius relative to the goal line.
6. Marks each frame as goal or no-goal.
7. Writes annotated frames into `goal.avi`.

The GUI entry point is `guif.m`, which appears to be generated with MATLAB GUIDE and wires buttons to the video/frame conversion, processing, and playback steps.

## Repository Contents

| File | Purpose |
| --- | --- |
| `guif.m` | MATLAB GUIDE GUI callbacks for running the demo pipeline and playing the generated result. |
| `finaltemp.m` | Main goal-line decision pipeline. Processes frames, detects the ball, checks goal/no-goal, and writes output video. |
| `detect_blobs.m` | Detects blobs by searching for local maxima in a Laplacian of Gaussian scale space. |
| `create_scale_space.m` | Builds the scale-space representation used by blob detection. |
| `create_gaussian.m` | Helper for generating a Gaussian kernel. |
| `create_circle.m` | Generates circle coordinates used to draw the detected ball overlay. |

## Algorithm Notes

The ball detection code uses a scale-space blob detector:

- input frames are normalized,
- each frame is convolved with Laplacian of Gaussian filters across multiple scales,
- local maxima above a threshold are treated as candidate blobs,
- candidate blobs are pruned and the most likely ball position is selected.

The goal/no-goal decision is based on geometry:

- the goal line is represented by two endpoints,
- the ball is represented by center coordinates and an estimated radius,
- the distance between the ball center and goal line is computed,
- the decision compares the ball position and radius against the line.

## Requirements

This project was written for older MATLAB versions, around the MATLAB R2012a era.

You will likely need:

- MATLAB
- Image Processing Toolbox
- Video processing support, including `VideoWriter`

Some functions in the code are legacy MATLAB APIs, for example `wavread`. On newer MATLAB versions, replace `wavread` with `audioread`.

## Expected Local Inputs

The original project expected several local files and helper functions that are not currently included in this repository:

- `line1.m` for goal-line endpoint detection
- `vid.m` for converting video into frames
- `read_image.m`
- `prune_blobs.m`
- `pad_image.m`
- `is_maximum.m`
- input `.jpg` frames
- `bg.png` for the GUI background
- `goalsound`
- generated/output folders such as `images/`

Because of those missing local assets, the repository is most useful today as readable project code and algorithm reference. To run it end-to-end, restore the missing helpers/assets or replace those calls with your own equivalents.

## Running The Demo

If you have restored the expected input files and helper functions:

1. Open MATLAB.
2. Add this repository to the MATLAB path.
3. Update the hardcoded paths in `finaltemp.m`:

   ```matlab
   base_dir = 'C:\Program Files\MATLAB\R2012a\bin\dagasirr';
   alt_dir = 'C:\Program Files\MATLAB\R2012a\bin\dagasirr\images';
   ```

4. Run the GUI:

   ```matlab
   guif
   ```

5. Or run the processing script directly:

   ```matlab
   finaltemp
   ```

The script writes annotated frames and creates `goal.avi`.

## Modernization Ideas

If you want to revive this project, useful next steps would be:

- remove hardcoded Windows paths and use paths relative to the repository,
- replace missing helper functions with documented implementations,
- include a tiny sample input video or a few test frames,
- update legacy MATLAB APIs such as `wavread`,
- split `finaltemp.m` into smaller functions,
- add comments around the goal/no-goal decision thresholds,
- add screenshots or a short GIF of the expected output.

## License

MIT License. See [LICENSE](LICENSE).
