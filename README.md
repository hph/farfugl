Farfugl
=======

Migrating an old database with old migrations can be a pain because the
migrations often rely on code that doesn't exist in the latest version of the
application. The only solution is to checkout to the commit where the migration
was introduced, but this can be tedious. **Farfugl** will do this for you.

Please note that **Farfugl** is still under development and is not completely
ready for use.

### Install

    gem install farfugl

Or add `gem 'farfugl'` to your Rails application and run `bundle`.

### Usage

    rake farfugl
