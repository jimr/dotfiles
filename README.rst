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


.Xmodmap
========

The ``.Xmodmap`` file included is for use with a UK Apple USB keyboard. Mostly,
it just puts things back where you would expect them to be (apart from ``Ins``
which I can't fix).


.oh-my-zsh
==========

First, clone the upstream repo into ``$HOME``::

    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

then just symlink everything from ``.oh-my-zsh/custom`` into
``~/.oh-my-zsh/custom``::

    cd /path/to/dotfiles/checkout
    ln -s $(pwd)/.oh-my-zsh/custom/* ~/.oh-my-zsh/custom

