# bundler_issue_6154

https://github.com/bundler/bundler/issues/6154

`./install.sh` does not fail, so it appears to be Docker-specific.

### Bundler 1.15.3

Build the docker container:
```bash
docker build .
```
Run the `run_some_gems.sh` scripts on the docker container:

```bash
docker run -it --rm CONTAINER_ID bash
root@CONTAINER:/tmp# ./run_some_gems.sh
```

Output (it works!):
```
root@CONTAINER_ID:/tmp# ./run_some_gems.sh
+ bundle --version
Bundler version 1.15.3
+ bundle config
Settings are listed in order of priority. The top value will be used.
path
Set for the current user (/root/.bundle/config): "/tmp/bundle"

bin
Set for the current user (/root/.bundle/config): "/tmp/bundle/bin"

app_config
Set via BUNDLE_APP_CONFIG: "/tmp/bundle"

+ pushd directory_one
/tmp/directory_one /tmp
+ echo hello
+ bundle exec lolcat
hello
+ popd
/tmp
```
