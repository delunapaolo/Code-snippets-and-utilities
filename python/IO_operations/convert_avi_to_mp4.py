# Convert AVI video to MP4. The original purpose was to convert a AVI captured
# with VLC to a smaller file.

# REFERENCES
# https://stackoverflow.com/q/30509573
# https://stackoverflow.com/q/42163058


import sys
import os
import cv2
from time import time


def main(filename):
    # Start counting time
    t0 = time()

    # Open video
    print('Opening \'%s\'' % filename)
    cap = cv2.VideoCapture(filename)
    frameCount = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    frameWidth = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    frameHeight = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

    # Get frame rate
    # REFERENCE: https://www.learnopencv.com/how-to-find-frame-rate-or-frames-per-second-fps-in-opencv-python-cpp/
    major_ver, minor_ver, subminor_ver = cv2.__version__.split('.')
    if int(major_ver) < 3:
        frames_per_second = cap.get(cv2.cv.CV_CAP_PROP_FPS)
    else:
        frames_per_second = cap.get(cv2.CAP_PROP_FPS)

    # Log info
    print('Info:\n\t%i frames\n\t%i x %i pixels\n\t%.2f frames per second' %
          (frameCount, frameWidth, frameHeight, frames_per_second))

    # Make path for converted file
    path, file_name = os.path.split(filename)
    new_filename = os.path.join(path, os.path.splitext(file_name)[0] + '.mp4')
    print('The converted video will be stored in \'%s\'' % new_filename)

    # Open writer
    # Default solution is to use MP4V. However the following reference suggested
    # to pass MP4V lowercase to avoid an error
    # REFERENCE: https://stackoverflow.com/a/33836463
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    out = cv2.VideoWriter(new_filename, fourcc, frames_per_second, (frameWidth, frameHeight), isColor=True)

    # Keep writing until the VideoCapture will stay open
    while cap.isOpened():
        ret, frame  = cap.read()
        if ret:
            out.write(frame)
        else:
            break

    # Release everything
    cap.release()
    out.release()
    print('Finished conversion in %is' % (time() - t0))


if __name__ == '__main__':
    if len(sys.argv) <= 1:
        filename = r"video.avi"

    else:
        filename = sys.argv[1]

    main(filename)
