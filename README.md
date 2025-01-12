
# Android ImageMagick 7.1.0-4

[![Build](https://github.com/cherryleafroad/Android-ImageMagick7/actions/workflows/build.yml/badge.svg?event=push)](https://github.com/cherryleafroad/Android-ImageMagick7/actions/workflows/build.yml) [![CodeQL](https://github.com/cherryleafroad/Android-ImageMagick7/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/cherryleafroad/Android-ImageMagick7/actions/workflows/codeql-analysis.yml)

This is a fully featured imagemagick build compatible with android. All libaries used are the absolute latest versions with the latest and greatest features.

It can be configured to both build as a binary (with shared libaries or statically linked), or as separate shared libraries (and no binary).

It comes compiled with the following features:

- OpenMP(3.1) / OpenCL (Qualcomm)
- HDRI support
- Q16 Quantum depth
- Cipher
- DPC

It comes featured with the following delegates:

 - bzlib
 - libfftw
 - libfreetype
 - libjpeg-turbo
 - libopenjpeg
 - libpng
 - libtiff
 - libwebp
 - libxml2
 - liblzma
 - liblcms2

Also comes with (**but these are not delegates, only support libraries**):
- libicu4c (libicuuc and libicui18n)
- libiconv
- libltdl (required for libOpenCL)

# Android support

**Requires API >= 24 (>= Nougat)**

**Currently, only arm64-v8a is supported**

You can test it with earlier versions, but I offer no support for it. If you're using only the binary, you almost certainly can compile for earlier versions. Nothing is stopping you from theoterically making it compatible with earlier Android versions too. If you get it working for earlier versions, let me know

# Binaries

Check out the release page for the [latest built binaries](https://github.com/cherryleafroad/Android-ImageMagick7/releases). This is built using the [default configuration](https://github.com/cherryleafroad/Android-ImageMagick7/blob/master/Application.mk). If you need a special configuration (for example OpenCL), you will need to build it for yourself from source.

- OpenCL support is available for Qualcomm. OpenCL is recommended over OpenMP. Please [go here](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/libopencl/qualcomm/lib) in order to learn how to setup OpenCL build for the project. You only need to find your own `libOpenCL.so` file and copy it over for your project. I can't host it here due to copyrights. **For OpenCL support, you need to build the library yourself because of copyright issues (I can't host the OpenCL lib here, so GitHub can't build it for me)**. >Btw, Github Actions can do the build for you too, change the config file, and manually run the action.<

# Quick Setup Instructions

- Android app setup code, including gradle files, assets, binary / java code, etc, can all be found under the [app folder](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app). This is not a 100% complete Android app, but rather it contains all the code examples needed for you to adapt it to your own project. Just copy / rewrite / delete code you want / don't need and combine it with your Android Studio project.
- Place your libs under the [libs/arch](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app/libs/arm64-v8a) folder. It's already setup to be noticed when your APK is built.

## How to run the binary

1. Put the generated binary in the [assets bin folder](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app/src/main/assets/usr/bin/arm64-v8a). Put all libs in the [libs/arch](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app/libs/arm64-v8a) folder.
2. Add environment variables before you run the binary.
3. Execute binary with args.

- All example code and setup to do this is can be found in the [example android app folder](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app).

| ENV Variable | Description | Example Value |
|--|--|--|
|`TMPDIR`|Temporary cache directory. Set to a directory writable by your app|`/data/data/com.myapp/files/TMP`|
|`MAGICK_HOME`|The directory containing imagemagick xml config files. Should be set to the base directory, e.g. `/usr` , with config files being in `/usr/etc/ImageMagick-7`.| `/data/data/com.myapp/files/usr`|
|`ICU_DATA_DIR_PREFIX`|The directory containing the folder named `icu` which contains the ICU data files (required by icuuc library). For example, a path of `/usr` will result in `/usr/icu/icu.dat` being loaded. Only required if the `libxml2` delegate is enabled.|`/data/data/com.myapp/files/usr`|
|`LD_LIBRARY_PATH`|Needed in order for the binary to find the `libc++_shared.so` library (or other libraries if you compiled them into shared libraries). Preferable to use the code `context.getApplicationInfo().nativeLibraryDir`|`/data/data/com.myapp/files/usr/lib/arm64-v8a`|

# Building from Source

- Want an easy way to build the project with minimal work? Fork the repo, change the config file, then use github actions to build it, and download the build artifacts. Pretty much almost no setup required in order to build. :)

- In order to understand how to build the project, please [install](https://developer.android.com/studio/projects/install-ndk) and [setup NDK](https://developer.android.com/ndk/guides) as per Google's instructions. Make sure you read how NDK works as it is important to getting your build successfully compiling. The required gradle files for building inside the [app folder](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app).
- Edit your build configuration under [`Application.mk`](https://github.com/cherryleafroad/Android-ImageMagick7/blob/master/Application.mk) to your liking, then (next step below)
- Use your CMD in the root and execute `build-release.bat`. Sorry, the build only currently works on Windows because I didn't have time to test the make files under Linux. Contributions are welcome.

# FAQ

### What is the recommended way to build/run this?

Build it with OpenCL support, statically linked, as a binary. HDRI on, quantum depth at 16. Make sure to use an AsyncTask to run it. Running it on your main thread WILL lock up your main UI. I can't host an OpenCL build here because I can't put the OpenCL lib here for an automatic build. So, only OpenMP builds are released.

### Can I customize the build features?

Yes you can. Just go to [Application.mk](https://github.com/cherryleafroad/Android-ImageMagick7/blob/master/Application.mk) in the root directory and alter the variables inside to your desired configuration. Build configuration has been made very simple! Piece of cake!

### How to build using NDK..? I'm so confused

Check out the Building from Source part above. Also, make sure you thoroughly read the [Google NDK docs](https://developer.android.com/studio/projects/install-ndk). Supporting code, gradle files for building, is all in the [example android app](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app). P.S. if it's too confusing, you COULD just fork the repo and use the same Github Action I use to auto-build it.

### Is there an easier way to build this without so much work?

Actually there is! Fork my repo, change the config to what you want, then use Github Actions to build it. Since I already have the build scripts configured, it's minimal work for you. In the case of wanting to do a openCL build, just follow the openCl instructions, change the config, then use Github Actions like before.

### Why am I getting linking errors?

You probably didn't add the `LD_LIBRARY_PATH` environment variable, so it doesn't know where to find any required libraries. Either that, or you don't have any libraries in your project at all. Check out the [example android app](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app) for where to put your libs. Hint: put it in the `libs` folder. And MAKE sure you went through the example android app and are using the supporting gradle / java code. It's all there.

### Why won't the binary execute properly?

Either you are using the wrong architecture (we only support armv8a), or your source code for running the binary is wrong. Please make sure all the files in the assets are there and you're using the env variables properly. Please also see the example code in the [example android app](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app). Everything you need is here. In the case of API >= 29, see the below answer.

### On API >= 29, I am getting permission denied errors!

[Starting with API 29, Android disallows binary execution in the home directory](https://developer.android.com/about/versions/10/behavior-changes-10#execute-permission). The only remaining location for executable code is the native lib directory.

There are 2 solutions for you on Android 10+:

#### Solution 1 - run the ELF binary from the native libs directory
1. rename your binary file to something like `libmagick.so` and place it in the `jniLibs` folder.
2. Make sure you have `android:extractNativeLibs=true` in your manifest.
3. After this, you can make a bunch of symlinks to the `libmagick.so` binary in your native lib folder from your apps data homedirectory (e.g. `magick`, `convert`, etc). The symlinks allow you to act like you're using the normal `magick` binary.
4. As usual, make sure that your `libmagick.so` has the executable bit set on it `chmod +x`. (This might or might not be the case by default)

Note: This `libmagick.so` is NOT a real shared library. It is the ELF `magick` binary with a different filename, that's all. The naming allows us to copy the binary over with the other real libs.

#### Solution 2 - use this project to create your own JNI lib which links against/integrates with the native imagemagick lib
1. [Read Oracle's documentation for how JNI works](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/spec/jniTOC.html).
2. [Read the official Android mk guide](https://developer.android.com/ndk/guides/android_mk). You can also study the make file setup I already have going. Specifically `Android.mk`, `Application.mk`, and the files under the `make` directory. After you're familiar enough with how it works, you can create your own `mk` file and integrate it into the project and tell it to build and link/integrate your own JNI lib against the real `libmagick.so` lib. You can do a static or shared library build (static meaning that there will be only 1 lib, which is yours, and all other libs like imagemagick will be inside it). Building a native imagemagick lib (shared or static) is already supported with a switch in the settings, so it will take minimal effort for you to integrate your build into it.
3. Program all your C code / Rust code. I STRONGLY recommend using Rust as it's a better and much safer low level language compared to C. It has JNI bindings support already, although you'll still need to interoperate with imagemagick's C code. I STRONGLY recommend you use the [imagemagick magick wand API](https://imagemagick.org/script/magick-wand.php) instead of the other ones since it's much easier to do what you want using it.
4. Do a bunch of Googling for any JNI, make file, imagemagick wand API, or C / Rust errors errors you encounter (as is always the case with programming!)
5. Profit!

### Why no JMagick support?

Well, you see. The thing is that the [jmagick project](https://github.com/techblue/jmagick) hasn't been updated since 2018. Imagemagick has grown and changed so much that it's not even compatible with it anymore. Furthermore, they aren't even using the better magick wand API. JMagick is mostly compatible with IM6, which is an older version. [I once had experimental support for Android and custom C patches for making jmagick](https://github.com/cherryleafroad/Android-ImageMagick7/tree/229070ade452f7d0559ecf158840baffae9138ea/libjmagick-7). It built and compiled of course, however there are so many little bugs and issues that nothing but a full rewrite of jmagick will truly properly support imagemagick. There was no point in maintaining something that technically builds, but isn't that usable in java code since it's buggy and missing so many features. Honestly, it would be much much easier for you to write your own jni lib that integrates the magick wand api. The Magick Wand API isn't even that difficult, and neither is JNI.

### I'm getting some errors about not being able to write TMP files..?

Create a tmpdir in your assets folder (same level as `usr` folder), and call it `tmp` (or something similar). Point to it using the `TMPDIR` environment variable listed in the documentation.

### Why do you only support arm64-v8a?

I didn't have time to test x86, x64, mips, armv7. There are a lot of specific configurations that need to take place such as ssize and so on that are specific to the different architectures. I don't know their required values. I'd also need to overhaul the make system to use different versions of these files in order for it to build properly. *I'd love some contributions to this so we can get more archs working!!*

### It won't build on Linux!!

Only Windows is supported by the build system. The make files assume you have Windows. Use Windows. Or, you could also contribute to testing and fixing the makefile code that only supports Windows. If you want to help with Linux build support, then make a issue and we can work together on it.

### Do you have any examples? / Where are the examples?

You can see all the example code you need for running the binary in the [example android app](https://github.com/cherryleafroad/Android-ImageMagick7/tree/master/example-app/android/app). It also has an entire sample project setup to get you started quick.

Note: This is not a "copy all the files"-"change nothing"-"run it directly without figuring it out"-solution, but rather an example template to help you get yours right with copyable code examples. This won't work directly out of the box. But it is also generally complete, more than enough to even copy over and fix whatever needs fixing if you wanted to. So, you should be using your own project, then just gut out the example project into yours as needed.

# Did this library help you?

![Donate](./readme_files/donate.svg)

If you found this library useful, please consider showing appreciation and sending a donation my way (maybe for a cup of coffee or a donut).
I don't always have the time nor mental energy to keep this updated for free, so any donations will help this project continue to be supported for longer and get more frequent updates! Thanks for your support! <3

| Place                   | Donation Address                                                                                        |
|-------------------------|---------------------------------------------------------------------------------------------------------|
| PayPal                  | [![Donate](https://img.shields.io/badge/Donate-PayPal-green)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BKDN933UM444J) |
| Bitcoin (BTC)           | 19bQFL3y8jz1ssCovPDQ23KyfPDVG9rWSf                                                                      |
| Etherium (ETH)          | 0x7612A7D726be1c91f7082B554a4dAbE5Fb54AB06                                                              |
| Tether (USDT)           | 0x7612A7D726be1c91f7082B554a4dAbE5Fb54AB06                                                              |
| Dogecoin (DOGE)         | DRLMnDHmFNB6s8aLEZhHhbh7Sn5hXyRCyJ                                                                      |
| Binance Coin (BNB)      | bnb15xhakyzlatd22tw9cacaj30jq57cvx2ef75uy3                                                              |
| Hedera Hashgraph (HBAR) | 0.0.397814                                                                                              |
| Cardano (ADA)           | addr1q9sy3nt9eu5fsen0w0ynja20rknrvqyhq24mv8s3dskv20ycl9amw6ehfapvkywzn9fu58edh3n279vhjqxln3p6f3jqalq0nt |
| Polkadot (DOT)          | 14GB7xwxMT95cSfb5o3okdEJNXfdPFYBZe15JKfcdNCgT3Av                                                        |
