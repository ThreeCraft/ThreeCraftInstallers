import os
import subprocess
import sys
import urllib.request
import urllib.error
import shutil

# Define URLs
SERVER_JS_URL = "https://cdn.jsdelivr.net/gh/ThreeCraft/ThreeCraftServer/server.js"
PACKAGE_JSON_URL = "https://cdn.jsdelivr.net/gh/ThreeCraft/ThreeCraftServer/package.json"

def download_file(url, destination_path):
    """Helper function to download a file using urllib.request."""
    try:
        print(f"Downloading {os.path.basename(destination_path)} from {url}...")
        with urllib.request.urlopen(url) as response, open(destination_path, 'wb') as out_file:
            shutil.copyfileobj(response, out_file)
        print("Download complete.")
    except urllib.error.HTTPError as e:
        print(f"Error downloading {url}: HTTP Error {e.code} - {e.reason}")
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"Error downloading {url}: {e.reason}")
        sys.exit(1)

def run_command(command, cwd=None):
    """Helper function to run shell commands."""
    try:
        # shell=True is used for simplicity to match the batch script style commands
        subprocess.check_call(command, cwd=cwd, shell=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running command '{command}': {e}")
        sys.exit(1)

def install_threecraft():
    print("ThreeCraft Installer")

    # Select installation directory (default: current directory + /ThreeCraftServer)
    default_dir = os.path.join(os.getcwd(), "ThreeCraftServer")
    install_dir = input(f"Enter installation directory (default: {default_dir}): ") or default_dir

    print(f"\nInstalling ThreeCraft Server to {install_dir}\n")

    # Create directory and change to it
    os.makedirs(install_dir, exist_ok=True)
    
    # Change the current working directory for subsequent actions
    os.chdir(install_dir)

    # Download server.js
    download_file(SERVER_JS_URL, "server.js")
    print("")

    # Download package.json
    download_file(PACKAGE_JSON_URL, "package.json")
    print("")

    # Start npm install
    print("Installing dependencies...")
    run_command("npm install")
    print("")

    print("Installation complete!")
    print("Starting Server...")
    print("")

    # Call node server.js
    run_command("node server.js")

if __name__ == "__main__":
    install_threecraft()
