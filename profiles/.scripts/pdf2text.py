import sys

import pdftotext

def usage():
    print("Usage: pdftotext filename [password]")

def print_metadata(pdf_file):
    print("The file has %d pages." % len(pdf))

def print_pdf(pdf_file):
    with open(sys.argv[1].replace("pdf", "txt"), "w") as f:
        f.writelines(pdf)

if len(sys.argv) < 2 or len(sys.argv) > 3:
    usage()
    exit(1)

if len(sys.argv) == 2:
    with open(sys.argv[1], "rb") as f:
        pdf = pdftotext.PDF(f)
elif len(sys.argv) == 3:
    with open(sys.argv[1], "rb") as f:
        pdf = pdftotext.PDF(f, sys.argv[2])

print_metadata(pdf)
print_pdf(pdf)
