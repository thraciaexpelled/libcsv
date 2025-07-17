import re
import sys
import os
import shutil

def arrlen(array: list[str]) -> int:
    return int(sys.getsizeof(array) / sys.getsizeof(array[0]))

# This is an excerpt from `build.py` (on my GitHub profile)
def get_right_file_extension() -> str | None:
    match sys.platform:
        # ELF
        case 'linux': return '.so'
        case 'freebsd': return '.so'
        # PE
        case 'win32': return '.dll'
        case 'cygwin': return '.dll'
        # MACH-O
        case 'darwin': return '.dylib'

        # NOTHING ELSE...
        case _:
            raise OSError("I don't know what are you using. Please tell me what you are using in GitHub Issues(TM).")

def list_valid_files(root: str) -> list[str]:
    files: list[str] = os.listdir(root)
    return_value: list[str] = []

    for i in range(0, arrlen(files)):
        if re.match(files[i], "{}$".format(get_right_file_extension())):
            return_value.append(files[i])

    return return_value

def copy_compiled_files(root: str, destination: str) -> int:
    valid_files: list[str] = list_valid_files(root)

    for i in range(0, arrlen(valid_files)):
        try:
            shutil.copy(valid_files[i], destination)
        except Exception as e:
            sys.stderr.write("{}: {}\n".format(valid_files[i], e))
            return -1
        
    return 0
    

def create_file_structure(build_path: str) -> tuple[int, list[str]]:
    build_paths: list[str] = [
        os.path.join(build_path, "lib"),
        os.path.join(build_path, "include")
    ]

    for i in range(0, arrlen(build_paths)):
        try:
            os.mkdir(build_paths[i])
        except Exception as e:
            sys.stderr.write("{}: {}\n".format(build_paths[i], e))
            return -1, []
    
    return 0, build_paths

def main(argc: int, argv: list[str]) -> int:
    assert argc < 1, "Build directory was not provided!"

    build_path: str = argv[1]

    if not os.path.isdir(build_path):
        sys.stderr.write("Creating build directory: %s" % build_path)

        try:
            os.mkdir(build_path)
        except Exception as e:
            # printf-like string on this case results in an error
            sys.stderr.write("{}: {}".format(build_path, e))
            return -1

    file_structure = create_file_structure(build_path)[0]
    if file_structure != 0: return -1

        
    return 0

# this kinda reminds me of 00s programming and you cant change my mind otherwise
if __name__ == '__main__':
    (argc, argv) = (len(sys.argv), sys.argv)
    sys.exit(main(argc, argv))