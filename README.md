# pass tail

An extension for the [password store](https://www.passwordstore.org/) that allows to display and edit password meta data without displaying the password itself to bystanders.

[password store](https://www.passwordstore.org/) proposes a format to store meta data in the password file. The password is stored in the first line followed by data like the URL, username and other meta data in the following lines. A common password file would look like this:
```
Yw|ZSNH!}z"6{ym9pI
URL: *.amazon.com/*
Username: AmazonianChicken@example.com
```

A common use case is to copy the first line, the password, using `pass show -c <password file>`.

The meta data usually cannot be copied but needs to be displayed as it contains type and value.

## pass tail

`pass tail <password file>` displays the whole password file except for the first line. This allows to inspect the meta data on the console without displaying the password in plain text:

```
URL: *.amazon.com/*
Username: AmazonianChicken@example.com
```

## pass tailedit

`pass tailedit <password file>` opens the password file in the editor omitting the first line. When saving the first line is prepended.

## pass tailclip

`pass tailclip <password file>` displays the whole password file except for the first line (like `pass tail`), but also copies the first line to the clipboard (like `pass show -c <password file>`).

## Installation

- Enable password-store extensions by setting ``PASSWORD_STORE_ENABLE_EXTENSIONS=true``
- ``make install``
- alternatively add `tail.bash` and `tailedit.bash` to your extension folder (by default at `~/.password-store/.extensions`)

## Completion

This extensions comes with the extension bash completion support added with password-store version 1.7.3

When installed, bash completion is already installed. Alternatively source `completion/pass-tail.bash.completion`

fish and zsh completion are not available, feel free to contribute.

For bash completion prior to password-store 1.7.3 see [old documentation](https://github.com/palortoff/pass-extension-tail/blob/42c6a182fd4c2b68be21af0dc6ed40fda188da12/README.md)

## Contribution

Contributions are always welcome.
