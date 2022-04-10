# Frontpage

Display New York Times frontpage on Raspberry Pi (Raspbian)


## Dependencies

### feh

`sudo apt-get install feh`

### ImageMagick

`sudo apt-get install imagemagick`

## Run

`sh frontpage.sh`

## Schedule

`crontab -e`

Add the following lines (times are Eastern Time)

```
10,25,40 1,2 * * * /bin/sh $PATH_TO_DIR/frontpage.sh
```
