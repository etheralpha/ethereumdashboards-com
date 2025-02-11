import os
from PIL import Image, ImageOps


repo_root = os.path.abspath(__file__ + '/../../')
# path of directory containing images to be processed
input_dir = repo_root + '/assets/img/dashboards/_originals-new'
# path of directory processed images are saved
output_processed_dir = repo_root + '/assets/img/dashboards'
# path of directory original images are saved
output_original_dir = repo_root + '/assets/img/dashboards/_originals'
max_size = 800
# used to crop image, useful for fullscreen screenshots that include black webcam bar
# you will need to edit the crop values below
crop=True
# crop=False


# for testing
# input_dir = repo_root + '/assets/img/dashboards-test/_originals-new'
# output_processed_dir = repo_root + '/assets/img/dashboards-test'
# output_original_dir = repo_root + '/assets/img/dashboards-test/_originals'


def convert_images_to_webp():
  total_files = len(os.listdir(input_dir))
  processed_files = 0
  for filename in os.listdir(input_dir):
    processed_files += 1
    if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
      filepath = os.path.join(input_dir, filename)
      try:
        img = Image.open(filepath)
        if crop:
          width, height = img.size
          # https://pillow.readthedocs.io/en/stable/reference/Image.html#PIL.Image.Image.crop
          # crop coordinates
          crop_left = 0
          crop_top = 75 # for macbook pro M1
          crop_right = width
          crop_bottom = height
          img = img.crop((crop_left, crop_top, crop_right, crop_bottom))
        # resize
        img.thumbnail((max_size, max_size))
        webp_filename = os.path.splitext(filename)[0] + ".webp"
        webp_filepath = os.path.join(output_processed_dir, webp_filename)
        img.save(webp_filepath, "webp", quality=80, optimize=True)
        # os.remove(filepath)
        os.rename(filepath, os.path.join(output_original_dir, filename))
        print(f"Converted {filename} to {webp_filename}")
      except Exception as e:
        print(f"Error converting {filename}: {e}")
    percentage_complete = round((processed_files/total_files)*100, 2)
    print(f"progress: {processed_files} / {total_files} ({percentage_complete}%)")


convert_images_to_webp()


