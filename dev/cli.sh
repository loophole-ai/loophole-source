export CARGO_NET_GIT_FETCH_WITH_CLI="true"
export VSCODE_CLI_APP_NAME="loophole"
export VSCODE_CLI_BINARY_NAME="loophole-server-insiders"
export VSCODE_CLI_DOWNLOAD_URL="https://github.com/loophole-ai/loophole-insiders/releases"
export VSCODE_CLI_QUALITY="insider"
export VSCODE_CLI_UPDATE_URL="https://raw.githubusercontent.com/loophole-ai/versions/refs/heads/master"

cargo build --release --target aarch64-apple-darwin --bin=code

cp target/aarch64-apple-darwin/release/code "../../VSCode-darwin-arm64/Loophole - Insiders.app/Contents/Resources/app/bin/loophole-insiders-tunnel"

"../../VSCode-darwin-arm64/Loophole - Insiders.app/Contents/Resources/app/bin/loophole-insiders" serve-web
