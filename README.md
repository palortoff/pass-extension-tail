# pass tail

An extension for the [password store](https://www.passwordstore.org/) that allows to display and edit password meta data without displaying the password itself to bystanders.

[password store](https://www.passwordstore.org/) proposes a format to store meta data in the password file. The password is stored in the first line followed by  data like the URL, username and other meta data in the following lines. A common password file would like this:
```
Yw|ZSNH!}z"6{ym9pI
URL: *.amazon.com/*
Username: AmazonianChicken@example.com
```

A common use case is to copy the first line, the password using `pass show -c <password file>`.

The meta data usually cannot be copied but needs to be displayed as it contains type and value.

## pass tail

`pass tail <password file>` displays the whole password file except for the first line. This allows to inspect the meta data on the console without displaying the password in plain text:

```
URL: *.amazon.com/*
Username: AmazonianChicken@example.com
```

## pass tailedit

`pass tailedit <password file>` opens the password file in the editor omitting the first line. When saving the first line is prepended.

## Installation

- Enable password-store extensions by setting ``PASSWORD_STORE_ENABLE_EXTENSIONS=true``
- Add this repo as a submodule to your password store and create a symlink to `tail.bash` and `tailedit.bash` in `~/password-store/.extensions`

## Contribution

Contributions are always welcome.
