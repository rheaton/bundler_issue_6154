# bundler_issue_6154

https://github.com/bundler/bundler/issues/6154

`./install.sh` does not fail, so it appears to be Docker-specific.

### Bundler 1.16.1

Build the docker container:
```bash
docker build .
```
Run the `run_some_gems.sh` scripts on the docker container:

```bash
docker run -it --rm CONTAINER_ID bash
root@CONTAINER:/tmp# ./run_some_gems.sh
```

Output:
```
+ bundle --version
Bundler version 1.16.1
+ bundle config
Settings are listed in order of priority. The top value will be used.
path
Set for the current user (/root/.bundle/config): "/tmp/bundle"

bin
Set for the current user (/root/.bundle/config): "/tmp/bundle/bin"

app_config
Set via BUNDLE_APP_CONFIG: "/tmp/bundle"

gemfile
Set via BUNDLE_GEMFILE: "/tmp/directory_two/Gemfile"

+ pushd directory_one
/tmp/directory_one /tmp
+ bundle exec lolcat
+ echo hello
bundler: failed to load command: lolcat (/tmp/bundle/bin/lolcat)
Gem::Exception: can't find executable lolcat for gem lolcat. lolcat is not currently included in the bundle, perhaps you meant to add it to your Gemfile?
  /tmp/bundle/gems/bundler-1.16.1/lib/bundler/rubygems_integration.rb:458:in `block in replace_bin_path'
  /tmp/bundle/gems/bundler-1.16.1/lib/bundler/rubygems_integration.rb:489:in `block in replace_bin_path'
  /tmp/bundle/bin/lolcat:29:in `<top (required)>'
+ popd
/tmp
```
