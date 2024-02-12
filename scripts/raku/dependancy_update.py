import toml
import subprocess
import re
import sys

def get_latest_version(library):
    """Fetch the latest version of a library using cargo search."""
    try:
        output = subprocess.check_output(['cargo', 'search', library], text=True)
        # Extract the version from the cargo search output
        match = re.search(r'"([^"]+)"', output)
        if match:
            return match.group(1)
    except subprocess.CalledProcessError as e:
        print(f"Error fetching version for {library}: {e}")
    return None

def update_library_versions(filename):
    """Update library versions in the TOML file."""
    with open(filename, 'r') as file:
        data = toml.load(file)

    dependencies = data.get('dependencies', {})
    for lib, version in dependencies.items():
        # Handle both plain version strings and complex structures with version fields
        if isinstance(version, str):
            old_version = version
        elif isinstance(version, dict) and 'version' in version:
            old_version = version['version']
        else:
            print(f"Skipping {lib}: unsupported format")
            continue

        new_version = get_latest_version(lib)
        if new_version and new_version != old_version:
            print(f"Updating {lib}: {old_version} -> {new_version}")
            if isinstance(version, str):
                dependencies[lib] = new_version
            elif isinstance(version, dict):
                version['version'] = new_version
        else:
            print(f"No update required or new version not found for {lib}.")

    with open(filename, 'w') as file:
        toml.dump(data, file)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <path/to/TOMLfile.toml>")
        sys.exit(1)
    filename = sys.argv[1]
    update_library_versions(filename)
