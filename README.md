# en_FI

An `en_FI.UTF-8` locale for glibc: English language, Finnish formats.

- Dates `16.10.2026`, 24-hour time `14.05.00`
- Weeks start on Monday, ISO week numbers
- Decimal comma, euro, A4, metric
- Finnish sort order

Day and month names, messages and yes/no answers are English (`en_US`); most other categories are copied from `fi_FI`.

## Install

```sh
git clone https://github.com/ConnySjoblom/en_FI.git
./en_FI/apply.sh
```

Supports Debian, Ubuntu, Fedora and Arch. On Debian and Ubuntu the locale is added to `/etc/locale.gen` and built by `locale-gen`, so glibc upgrades rebuild it.

## Use it

For the whole machine, on Debian and Ubuntu:

```sh
sudo update-locale LANG=en_FI.UTF-8
```

On Fedora and Arch:

```sh
sudo localectl set-locale LANG=en_FI.UTF-8
```

Log in again, then `locale` should show `en_FI.UTF-8`.

For one user only, add `export LANG=en_FI.UTF-8` to `~/.profile`.

## Remove

```sh
sudo rm -rf /usr/lib/locale/en_FI.UTF-8 /usr/lib/locale/en_FI.utf8
sudo localedef --delete-from-archive en_FI.utf8
sudo rm -f /usr/share/i18n/locales/en_FI
sudo sed -i '/^en_FI\.UTF-8 UTF-8$/d' /etc/locale.gen
```

Switch `LANG` back first, or sessions warn that they can't set the locale.
