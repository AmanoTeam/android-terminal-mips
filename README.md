# Android Terminal on MIPS

This is a minimal Android MIPS system root packaged as a Docker container. It includes the Bionic C library and core system shell utilities.

## Usage

Set up the emulation layer using binfmt:

```
docker run --rm --privileged aptman/qus -s -- -p mips64el mipsel
```

Build the image and then create the container:

```
docker build -t android-terminal:mips "${PWD}"
docker run -ti --privileged android-terminal:mips
```
