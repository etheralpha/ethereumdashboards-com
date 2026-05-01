import yaml
from pathlib import Path
from urllib.parse import urlparse
from PIL import Image
from playwright.sync_api import sync_playwright


# - Reads a list of URLs from `_data/new_links.yml`, for each:
# - Takes a headless 800x500 screenshot
# - Converts it to a compressed WebP
# - Scrapes the page title and meta description
# - Stages entries to `_data/new_entries.yml`
#   - Need to manually copy entries to `_data/dashboards.yml` after completion/review
# - Failed URLs are written back to `_data/failed_links.yml` with errors


REPO_ROOT   = Path(__file__).parent.parent
NEW_LINKS   = REPO_ROOT / "_data/new_links.yml"
FAILED_LINKS   = REPO_ROOT / "_data/failed_links.yml"
NEW_ENTRIES = REPO_ROOT / "_data/new_entries.yml"
OUTPUT_DIR  = REPO_ROOT / "assets/img/dashboards"


def url_to_name(url):
  # Extract the second-to-last hostname segment, e.g. ethgastracker.com -> ethgastracker.
  parts = urlparse(url).hostname.split(".")
  return parts[-2]


def ensure_scheme(url):
  # Prepend https:// if the URL has no scheme.
  if not url.startswith(("http://", "https://")):
    url = "https://" + url
  return url


def scrape_page(page):
  # Return (title, description) scraped from the loaded page.
  title = page.title()
  description = (
    page.get_attribute('meta[name="description"]', "content")
    or page.text_content("h2")
    or ""
  )
  return title.strip(), description.strip()


def take_screenshot(page, output_path):
  # Save a compressed WebP screenshot of the current page.
  png_path = output_path.with_suffix(".png")
  page.screenshot(path=str(png_path))
  img = Image.open(png_path)
  img = img.resize((800, 500), Image.LANCZOS)
  img.save(output_path.with_suffix(".webp"), "webp", quality=80, optimize=True)
  png_path.unlink()  # remove the temporary PNG


def main():
  urls = yaml.safe_load(NEW_LINKS.read_text(encoding="utf-8")) or []
  errors = []

  with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)

    for url_raw in urls:
      print(f"\n[INFO] Processing: {url}")
      url = ensure_scheme(url_raw)
      name = url_to_name(url)
      webp_path = OUTPUT_DIR / f"{name}.webp"
      if webp_path.exists():
          print(f"[WARNING]: Duplicate img name {name}.webp")
          webp_path = OUTPUT_DIR / f"{name}2.webp"

      try:
        page = browser.new_context(viewport={"width": 1600, "height": 1000}).new_page()
        page.goto(url, timeout=45_000, wait_until="networkidle")
        page.wait_for_timeout(2_000)  # extra wait for JS rendering

        title, description = scrape_page(page)
        take_screenshot(page, webp_path)
        page.close()

        # Append new entry to new_entries.yml
        entry = (
          f"- name: {title}\n"
          f"  link: {url}\n"
          f"  description: {description}\n"
          f"  img: /assets/img/dashboards/{name}.webp\n"
          f"  categories: \n"
        )
        with NEW_ENTRIES.open("a", encoding="utf-8") as f:
          f.write(entry + "\n")

        print(f"[OK]   Saved: {webp_path.name}")

      except Exception as exc:
        error_msg = str(exc).replace("\n", " ")[:120]
        print(f"[ERROR] {error_msg}")
        errors.append(f"- {url_raw}  # ERROR: {error_msg}\n")

    browser.close()

  # Write failed_links.yml with only the failed URLs
  if len(errors) > 0:
    FAILED_LINKS.write_text("".join(errors), encoding="utf-8")
    print("Failed links:")
    print("\n".join(errors))
  print("\n[INFO] Done.")


if __name__ == "__main__":
  main()