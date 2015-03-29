The eponymously named shell script (`remove_translation_packages.sh`)
follows directions outlined in a [medoix.com blog post](https://medoix.com/2012/01/22/disable-translation-packages-in-ubuntu/):

1. Append `Acquire::Languages "none";` to
 `/etc/apt/apt.conf.d/99translations` (making the file if it doesn't
already exist).
2. Wiping  `/var/lib/apt/lists` clean, and repopulating with
 `sudo apt-get update`

Instead of following the second step, I decided to be a bit more
surgical and remove only the sources in the `lists/` directory
which match the REGEX `*_Translation*`:
```Bash
find /var/lib/apt/lists -type f -name "*_Translation*" | \
  sudo xargs rm
```

Finally, due to permission issues with the `/etc/` directory,
I found that the following will fail:
```Bash
sudo echo "# comment" >> /etc/apt/apt.conf.d/99translations
```

My current work around is to modify a temporary copy of the
`99translations` file and then use `sudo mv` to overwrite
`99translations` with the copy.
 
