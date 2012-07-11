Vim
===

To get started post-clone, you'll need to ``git submodule init`` followed by a
``git submodule update`` to pull in Vundle (required for bundle management).
Once that's done, just open up vim and call ``:BundleInstall`` which will
install all the configured bundles.


Mutt
====

The included settings for mutt don't actually reference any specific accounts,
so you'll need to define, e.g.: ``folder``, ``spoolfile``, ``smtp_url`` and any
other mailbox settings in a new configuration file under ``~/.mutt`` and source
it from your ``.muttrc``.

