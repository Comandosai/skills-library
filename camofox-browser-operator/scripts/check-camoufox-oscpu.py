#!/usr/bin/env python3
"""Quick Camoufox binary fingerprint check — smoke test for oscpu coherence.

Install deps first (one-time):
  python3 -m venv /tmp/camofox-check-venv
  source /tmp/camofox-check-venv/bin/activate
  pip install camoufox

Then run:
  source /tmp/camofox-check-venv/bin/activate
  DISPLAY=:99 python3 this_script.py
"""
import json, os, sys
from camoufox.sync_api import Camoufox
from browserforge.fingerprints import FingerprintGenerator, Screen

TIMEOUT = 10000
results = []

def check(label, **kw):
    try:
        with Camoufox(headless=False, humanize=False, enable_cache=True, **kw) as browser:
            page = browser.new_page()
            page.goto("https://example.com/", wait_until="domcontentloaded", timeout=TIMEOUT)
            js = page.evaluate("""JSON.stringify({
                ua: navigator.userAgent,
                platform: navigator.platform,
                oscpu: navigator.oscpu,
                webdriver: navigator.webdriver
            })""")
            browser.close()
            return json.loads(js)
    except Exception as e:
        return {"error": f"{type(e).__name__}: {e}"}

# Native
r = check("native-linux", os=["linux"], screen=Screen(max_width=1920, max_height=1080))
print("native:", r)
coherent = r.get("oscpu") == r.get("platform")
print(f"  oscpu == platform: {coherent}")

# BrowserForge Windows
fg = FingerprintGenerator(browser="firefox")
fp = fg.generate(os="windows", screen=Screen(max_width=1920, max_height=1080))
rf = check("forge-windows", os=["windows"], fingerprint=fp,
           screen=Screen(max_width=1920, max_height=1080))
print("forge:", rf)
coherent_f = rf.get("oscpu") == fp.navigator.oscpu
print(f"  oscpu matches fingerprint: {coherent_f}")

if coherent and coherent_f:
    print("\nPASS: Camoufox binary produces coherent fingerprints.")
    sys.exit(0)
else:
    print("\nFAIL: oscpu mismatch detected — binary is likely outdated (v150 bug).")
    print("Fix: update Camoufox binary via `pip install -U camoufox`.")
    sys.exit(1)
