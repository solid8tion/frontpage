# Frontpage

Display New York Times frontpage on Raspberry Pi (Raspbian)


## Dependencies

### feh

`sudo apt-get install feh`

### ImageMagick

`sudo apt-get install imagemagick`

## Setup

### Change Path Name

`nano frontpage.sh`

And change the `pathname` variable to the path that contains this project


## Run

`sh frontpage.sh`

## Schedule

`crontab -e`

Add the following lines (times are Eastern Time)

```
10,25,40 1,2 * * * /bin/sh $PATH_TO_DIR/frontpage.sh
```
