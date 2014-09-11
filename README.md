# Trophy Store

## Notes

Following instructions [here](https://github.com/ossreleasefeed/Sandstone#for-sites-based-on-playdoh) 
I've installed volo and node-less and run
```
cd trophystore/trophystore
volo add ossreleasefeed/Sandstone/master#volofile
volo install_sandstone project=certmanager
```

I'm not yet sure how to indicate that this Django app now depends on `node-less` which provides `lessc`

### bcrypt

Playdoh requires py-bcrypt but doesn't install it
https://github.com/fwenzel/django-sha2/issues/14

I ran this in Ubuntu
```
sudo apt-get install python-bcrypt
```

### boto

We depend on `boto`. I need to add this to dependency lists/requirements files.
With 2.24.0 and newer, we can take advantage of credential profiles : http://stackoverflow.com/a/21345540/168874

`pip install boto`


### pyOpenSSL

pyopenssl is missing a function to export a private key in PKCS#1 format

As the binary distributed pyOpenSSL that you get when doing a `sudo apt-get install python-openssl` doesn't 
include the private modules we need to build and install it ourselves

pyopenssl depends on `libffi-dev` : `sudo apt-get install libffi-dev`

`pip install pyOpenSSL`

### yaml

Depends on python-yaml which requires libyaml-dev

`sudo apt-get install libyaml-dev`

`pip install PyYAML`
