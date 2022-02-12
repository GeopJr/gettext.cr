<h1 align="center">gettext.cr</h1>
<h4 align="center">Crystal bindings for the GNU & Musl gettext library.</h4>

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     gettext:
       github: GeopJr/gettext.cr
   ```

2. Run `shards install`

## Usage

[Docs](https://geopjr.github.io/gettext.cr/) include examples, but here's a generic one:

```crystal
require "gettext"

Gettext.setlocale(Gettext::LC::ALL, "el_GR.UTF-8")
Gettext.dgettext("gedit", "Text Editor") # => "Επεξεργαστής κειμένου"
Gettext.ngettext("Crystal", "Crystals", rand(5)) # => "Crystals" or "Crystal"
```

## Contributing

1. Read the [Code of Conduct](https://github.com/GeopJr/gettext.cr/blob/main/CODE_OF_CONDUCT.md)
2. Fork it (<https://github.com/GeopJr/gettext.cr/fork>)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
