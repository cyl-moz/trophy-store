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
