# Headless chromium on alpine linux container

Run the chromium on headless mode in alpine linux container with google fonts.

## Usage

### Build image

1. `$ cd docker/file/path/here`
2. `$ docker build -t headless-chromium-alpine:1.0 .`  
\* If you don't need to install google fonts, comment out the `RUN` instruction in the next line of the `# Install google fonts` from the Dockerfile.

### Run container examples

* Take a screenshot  
`$ docker run -it --rm -v $(pwd):/home/chromium/work --name headless-chromium headless-chromium-alpine:1.0 --screenshot --window-size=1920,1080 --hide-scrollbars https://github.com/`

* Dump DOM  
`docker run -it --rm --name headless-chromium headless-chromium-alpine:1.0 --dump-dom https://github.com/`

* Enable devtools  
`$ docker run --init --rm --rm -d -p 9222:9222 -v $(pwd):/home/chromium/work --name headless-chromium headless-chromium-alpine:1.0 --remote-debugging-port=9222 --remote-debugging-address=0.0.0.0`  
\* It is assumed to operate via WebSocket.  
\* The container will continue to run until it's terminated.

### Access devtools from browser (Require run with enable devtools)

* Headress remote debugging  
<http://localhost:9222/>

* Remote debugging info  
<http://localhost:9222/json>
