Farfugl
=======

[![Gem Version](https://badge.fury.io/rb/farfugl.png)](http://badge.fury.io/rb/farfugl)

Migrating an old database with old migrations can be a pain because the
migrations often depend on code that doesn't exist in the latest version of the
application. The simplest solution is to checkout to the commit where each
migration was introduced (or last modified) and run each migration from there,
but this can be time-consuming and tedious. **Farfugl** automates this process.

Please note that **Farfugl** is still under development and is not completely
stable; always create backups your database before using it.

### Install

You can install **Farfugl** on your system like any other gem:

    gem install farfugl

You can also add `gem 'farfugl'` to your Rails application's Gemfile and run
`bundle`.

### Usage

    rake farfugl
