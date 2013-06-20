# jsch-sftp

A simple JRuby wrapper around the Java [JSch](http://www.jcraft.com/jsch/) library.

## Installation

Add this line to your application's Gemfile:

    gem 'jsch-sftp', github: 'modcloth-labs/jsch-sftp'

then execute:

    $ bundle

## Usage

```
require 'jsch'
require 'jsch/sftp'

Jsch::SFTP.start('host', 'user', identity: '/path/to/keyfile') do |sftp|
  sftp.entries('/').each do |entry|
    puts entry.name
  end

  sftp.upload!('/path/to/local', '/path/to/remote')
  sftp.download!('/path/to/remote', '/path/to/local')
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
