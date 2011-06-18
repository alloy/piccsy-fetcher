# Fetch images from piccsy.com

There is [no API][api] yet, so until that arrives this script simply scrapes
the overview pages of images you’ve picked.

Note that the script fetches the low-res versions. For now this serves my
purpose just fine, but let me know if you make it fetch the full versions
without hammering the piccsy.com server too much.


## Using the script

Get the code:

    git clone git://github.com/alloy/piccsy-fetcher.git
    cd piccsy-fetcher
    cp config.rb.sample config.rb

Now enter your username in `config.rb`.

From then on you can run the following command, which will keep scraping until
it comes across a file that already exists:

    ruby fetch.rb


## Use images with the Apple TV 2 screensaver

Connect to your Apple TV 2 with ssh and issue the following commands:

    cd /System/Library/PrivateFrameworks/AppleTV.framework
    mv DefaultFlowerPhotos DefaultFlowerPhotos-backup
    mkdir DefaultFlowerPhotos

Then run the script which is by default configured to place the images in the
`DefaultFlowerPhotos`, but you can change that to `DefaultAnimalPhotos` if you
prefer.

Now when you use the `Flowers` screensaver it will show the piccsy.com images
instead.

Note that it might well be the case that updating your Apple TV 2 removes this
directory and replaces it with the actual default set again, but I haven’t done
that yet. In case you want to protect yourself from this it might be a good
idea to create a backup copy of the directory somewhere. I tried creating a
symbolic link to the images directory outside of the system directory, but the
screensaver did not pickup the images.

Finally, I had to install an older Ruby 1.9 build than the one that comes with
`apt-get`. Install it like so:

    curl -L -O http://apt.saurik.com/cydia-3.7/debs/ruby_1.9.1-p429-6_iphoneos-arm.deb
    dpkg -i ruby_1.9.1-p429-6_iphoneos-arm.deb


[api]:http://piccsy.com/api
