#!/usr/bin/env bash
# shellcheck disable=SC1091,2154

set -e

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  cp -rp src/insider/* vscode/
else
  cp -rp src/stable/* vscode/
fi

cp -f LICENSE vscode/LICENSE.txt

cd vscode || { echo "'vscode' dir not found"; exit 1; }

# rm -rf extensions/copilot

{ set +x; } 2>/dev/null

# {{{ product.json
cp product.json{,.bak}

setpath() {
  local jsonTmp
  { set +x; } 2>/dev/null
  jsonTmp=$( jq --arg 'value' "${3}" "setpath(path(.${2}); \$value)" "${1}.json" )
  echo "${jsonTmp}" > "${1}.json"
  set -x
}

setpath_json() {
  local jsonTmp
  { set +x; } 2>/dev/null
  jsonTmp=$( jq --argjson 'value' "${3}" "setpath(path(.${2}); \$value)" "${1}.json" )
  echo "${jsonTmp}" > "${1}.json"
  set -x
}

setpath "product" "checksumFailMoreInfoUrl" "https://go.microsoft.com/fwlink/?LinkId=828886"
setpath "product" "documentationUrl" "https://go.microsoft.com/fwlink/?LinkID=533484#vscode"
setpath_json "product" "extensionsGallery" '{"serviceUrl": "https://open-vsx.org/vscode/gallery", "itemUrl": "https://open-vsx.org/vscode/item", "latestUrlTemplate": "https://open-vsx.org/vscode/gallery/{publisher}/{name}/latest", "controlUrl": "https://raw.githubusercontent.com/EclipseFdn/publish-extensions/refs/heads/master/extension-control/extensions.json"}'

setpath "product" "introductoryVideosUrl" "https://go.microsoft.com/fwlink/?linkid=832146"
setpath "product" "keyboardShortcutsUrlLinux" "https://go.microsoft.com/fwlink/?linkid=832144"
setpath "product" "keyboardShortcutsUrlMac" "https://go.microsoft.com/fwlink/?linkid=832143"
setpath "product" "keyboardShortcutsUrlWin" "https://go.microsoft.com/fwlink/?linkid=832145"
setpath "product" "licenseUrl" "https://github.com/loophole-ai/loophole-ide/blob/master/LICENSE"
setpath_json "product" "linkProtectionTrustedDomains" '["https://open-vsx.org"]'
setpath "product" "releaseNotesUrl" "https://go.microsoft.com/fwlink/?LinkID=533483#vscode"
setpath "product" "reportIssueUrl" "https://github.com/loophole-ai/loophole-ide/issues/new"
setpath "product" "requestFeatureUrl" "https://github.com/loophole-ai/loophole-ide/issues/new"

if [[ "${DISABLE_UPDATE}" != "yes" ]]; then
  setpath "product" "updateUrl" "https://raw.githubusercontent.com/loophole-ai/versions/refs/heads/master"

  if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
    setpath "product" "downloadUrl" "https://github.com/loophole-ai/loophole-insiders/releases"
  else
    setpath "product" "downloadUrl" "https://github.com/loophole-ai/loophole-ide/releases"
  fi

  # if [[ "${OS_NAME}" == "windows" ]]; then
  #   setpath_json "product" "win32VersionedUpdate" "true"
  # fi
fi

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  setpath "product" "nameShort" "Loophole - Insiders"
  setpath "product" "nameLong" "Loophole Editor - Insiders"
  setpath "product" "applicationName" "loophole-insiders"
  setpath "product" "dataFolderName" ".loophole-insiders"
  setpath "product" "linuxIconName" "loophole-insiders"
  setpath "product" "quality" "insider"
  setpath "product" "urlProtocol" "loophole-insiders"
  setpath "product" "serverApplicationName" "loophole-server-insiders"
  setpath "product" "serverDataFolderName" ".loophole-server-insiders"
  setpath "product" "darwinBundleIdentifier" "ai.loophole.LoopholeInsiders"
  setpath "product" "win32AppUserModelId" "Loophole.LoopholeInsiders"
  setpath "product" "win32DirName" "Loophole Insiders"
  setpath "product" "win32MutexName" "loopholeinsiders"
  setpath "product" "win32NameVersion" "Loophole Insiders"
  setpath "product" "win32RegValueName" "LoopholeInsiders"
  setpath "product" "win32ShellNameShort" "Loophole Insiders"
  setpath "product" "win32AppId" "{{eeb57920-3500-47ec-a435-dd45b1322ed8}"
  setpath "product" "win32x64AppId" "{{ca0e43b5-34a2-44d7-8dfd-94598d9a42e5}"
  setpath "product" "win32arm64AppId" "{{3bbe84d9-0cab-481b-bc96-ced44fc5fa2f}"
  setpath "product" "win32UserAppId" "{{8212eba9-ced1-4fdd-a280-99342688fd34}"
  setpath "product" "win32x64UserAppId" "{{f52a2bd4-8131-4292-a145-53e0e046e36a}"
  setpath "product" "win32arm64UserAppId" "{{515e1359-ba44-4821-b8da-95adc0d03bf2}"
  setpath "product" "tunnelApplicationName" "loophole-insiders-tunnel"
  setpath "product" "win32TunnelServiceMutex" "loopholeinsiders-tunnelservice"
  setpath "product" "win32TunnelMutex" "loopholeinsiders-tunnel"
  setpath "product" "win32ContextMenu.x64.clsid" "3e33ed42-ff8d-436c-bea7-0a89cdf53e51"
  setpath "product" "win32ContextMenu.arm64.clsid" "34ac3c70-b71c-41ba-ae17-4295828e75f3"
else
  setpath "product" "nameShort" "Loophole"
  setpath "product" "nameLong" "Loophole Editor"
  setpath "product" "applicationName" "loophole"
  setpath "product" "linuxIconName" "loophole"
  setpath "product" "quality" "stable"
  setpath "product" "urlProtocol" "loophole"
  setpath "product" "serverApplicationName" "loophole-server"
  setpath "product" "serverDataFolderName" ".loophole-server"
  setpath "product" "darwinBundleIdentifier" "ai.loophole.Loophole"
  setpath "product" "win32AppUserModelId" "Loophole.Loophole"
  setpath "product" "win32DirName" "Loophole"
  setpath "product" "win32MutexName" "loophole"
  setpath "product" "win32NameVersion" "Loophole"
  setpath "product" "win32RegValueName" "Loophole"
  setpath "product" "win32ShellNameShort" "Loophole"
  setpath "product" "win32AppId" "{{c277782f-5478-4aef-95e8-4a7bc7ddbd9c}"
  setpath "product" "win32x64AppId" "{{b3cfdc17-62ba-457b-9a0c-04efce37dd21}"
  setpath "product" "win32arm64AppId" "{{eea54ed4-b5c5-4b6f-a99e-9b9c466fa9fc}"
  setpath "product" "win32UserAppId" "{{ae123319-9891-46ad-a797-d26250b00519}"
  setpath "product" "win32x64UserAppId" "{{c2b84dfd-7ed7-498c-b9b0-d8da0ee004a8}"
  setpath "product" "win32arm64UserAppId" "{{994b0a62-b548-4559-b44c-5d42c776dd08}"
  setpath "product" "tunnelApplicationName" "loophole-tunnel"
  setpath "product" "win32TunnelServiceMutex" "loophole-tunnelservice"
  setpath "product" "win32TunnelMutex" "loophole-tunnel"
  setpath "product" "win32ContextMenu.x64.clsid" "31068ba5-8dab-4a31-8cc4-ea437ea89185"
  setpath "product" "win32ContextMenu.arm64.clsid" "a811c90b-75c3-4bf6-96ac-714e717a77d0"
fi

setpath_json "product" "tunnelApplicationConfig" '{}'

jsonTmp=$( jq -s '.[0] * .[1]' product.json ../product.json )
echo "${jsonTmp}" > product.json && unset jsonTmp

cat product.json
# }}}

# include common functions
. ../utils.sh

# {{{ apply patches

echo "APP_NAME=\"${APP_NAME}\""
echo "APP_NAME_LC=\"${APP_NAME_LC}\""
echo "ASSETS_REPOSITORY=\"${ASSETS_REPOSITORY}\""
echo "BINARY_NAME=\"${BINARY_NAME}\""
echo "GH_REPO_PATH=\"${GH_REPO_PATH}\""
echo "GLOBAL_DIRNAME=\"${GLOBAL_DIRNAME}\""
echo "ORG_NAME=\"${ORG_NAME}\""
echo "TUNNEL_APP_NAME=\"${TUNNEL_APP_NAME}\""

if [[ "${DISABLE_UPDATE}" == "yes" ]]; then
  mv ../patches/00-update-disable.patch.yet ../patches/00-update-disable.patch
fi

for file in ../patches/*.json; do
  if [[ -f "${file}" ]]; then
    apply_actions "${file}"
  fi
done

for file in ../patches/*.patch; do
  if [[ -f "${file}" ]]; then
    apply_patch "${file}"
  fi
done

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  for file in ../patches/insider/*.patch; do
    if [[ -f "${file}" ]]; then
      apply_patch "${file}"
    fi
  done
fi

if [[ -d "../patches/${OS_NAME}/" ]]; then
  for file in "../patches/${OS_NAME}/"*.patch; do
    if [[ -f "${file}" ]]; then
      apply_patch "${file}"
    fi
  done
fi

for file in ../patches/user/*.patch; do
  if [[ -f "${file}" ]]; then
    apply_patch "${file}"
  fi
done
# }}}

set -x

# {{{ install dependencies
export ELECTRON_SKIP_BINARY_DOWNLOAD=1
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1

if [[ "${OS_NAME}" == "linux" ]]; then
  export VSCODE_SKIP_NODE_VERSION_CHECK=1

   if [[ "${npm_config_arch}" == "arm" ]]; then
    export npm_config_arm_version=7
  fi
elif [[ "${OS_NAME}" == "windows" ]]; then
  if [[ "${npm_config_arch}" == "arm" ]]; then
    export npm_config_arm_version=7
  fi
else
  if [[ "${CI_BUILD}" != "no" ]]; then
    clang++ --version
  fi
fi

node build/npm/preinstall.ts

mv .npmrc .npmrc.bak
cp ../npmrc .npmrc

for i in {1..5}; do # try 5 times
  if [[ "${CI_BUILD}" != "no" && "${OS_NAME}" == "osx" ]]; then
    CXX=clang++ npm ci && break
  else
    npm ci && break
  fi

  if [[ $i == 5 ]]; then
    echo "Npm install failed too many times" >&2
    exit 1
  fi
  echo "Npm install failed $i, trying again..."

  sleep $(( 15 * (i + 1)))
done

mv .npmrc.bak .npmrc
# }}}

# package.json
cp package.json{,.bak}

setpath "package" "version" "${RELEASE_VERSION%-insider}"

replace 's|Microsoft Corporation|Loophole AI|' package.json

# Add Void/Loophole AI dependencies
jsonTmp=$( jq '.dependencies += {
  "@anthropic-ai/sdk": "^0.40.0",
  "@google/genai": "^0.13.0",
  "@mistralai/mistralai": "^1.6.0",
  "@modelcontextprotocol/sdk": "^1.11.2",
  "groq-sdk": "^0.20.1",
  "ollama": "^0.5.15",
  "openai": "^4.96.0",
  "posthog-node": "^4.14.0",
  "zod": "^3.25.76"
}' package.json )
echo "${jsonTmp}" > package.json

# Add buildreact scripts
jsonTmp=$( jq '.scripts += {
  "buildreact": "cd ./src/vs/workbench/contrib/void/browser/react/ && node build.js && cd ../../../../../../../",
  "watchreact": "cd ./src/vs/workbench/contrib/void/browser/react/ && node build.js --watch && cd ../../../../../../../",
  "watchreactd": "deemon npm run watchreact"
}' package.json )
echo "${jsonTmp}" > package.json

cp resources/server/manifest.json{,.bak}

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  setpath "resources/server/manifest" "name" "Loophole - Insiders"
  setpath "resources/server/manifest" "short_name" "Loophole - Insiders"
else
  setpath "resources/server/manifest" "name" "Loophole"
  setpath "resources/server/manifest" "short_name" "Loophole"
fi

# announcements
replace "s|\\[\\/\\* BUILTIN_ANNOUNCEMENTS \\*\\/\\]|$( tr -d '\n' < ../announcements-builtin.json )|" src/vs/workbench/contrib/welcomeGettingStarted/browser/gettingStarted.ts

../undo_telemetry.sh

replace 's|Microsoft Corporation|Loophole AI|' build/lib/electron.ts
replace 's|([0-9]) Microsoft|\1 Loophole AI|' build/lib/electron.ts


if [[ "${OS_NAME}" == "linux" ]]; then
  # microsoft adds their apt repo to sources
  # unless the app name is code-oss
  # as we are renaming the application to vscodium
  # we need to edit a line in the post install template
  if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
    sed -i "s/code-oss/loophole-insiders/" resources/linux/debian/postinst.template
  else
    sed -i "s/code-oss/loophole/" resources/linux/debian/postinst.template
  fi

  # fix the packages metadata
  # code.appdata.xml
  sed -i 's|Visual Studio Code|Loophole|g' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/loophole-ai/loophole-ide#download-install|' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com/home/home-screenshot-linux-lg.png|https://loophole-ai.github.io/loophole-web/img/loophole.png|' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com|https://loophole-ai.github.io/loophole-web|' resources/linux/code.appdata.xml

  # control.template
  sed -i 's|Microsoft Corporation <vscode-linux@microsoft.com>|Loophole AI Team https://github.com/loophole-ai/loophole-ide/graphs/contributors|' resources/linux/debian/control.template
  sed -i 's|Visual Studio Code|Loophole|g' resources/linux/debian/control.template
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/loophole-ai/loophole-ide#download-install|' resources/linux/debian/control.template
  sed -i 's|https://code.visualstudio.com|https://loophole-ai.github.io/loophole-web|' resources/linux/debian/control.template

  # code.spec.template
  sed -i 's|Microsoft Corporation|Loophole AI Team|' resources/linux/rpm/code.spec.template
  sed -i 's|Visual Studio Code Team <vscode-linux@microsoft.com>|Loophole AI Team https://github.com/loophole-ai/loophole-ide/graphs/contributors|' resources/linux/rpm/code.spec.template
  sed -i 's|Visual Studio Code|Loophole|' resources/linux/rpm/code.spec.template
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/loophole-ai/loophole-ide#download-install|' resources/linux/rpm/code.spec.template
  sed -i 's|https://code.visualstudio.com|https://loophole-ai.github.io/loophole-web|' resources/linux/rpm/code.spec.template

  # snapcraft.yaml
  sed -i 's|Visual Studio Code|Loophole|' resources/linux/rpm/code.spec.template
elif [[ "${OS_NAME}" == "windows" ]]; then
  # code.iss
  sed -i 's|https://code.visualstudio.com|https://loophole-ai.github.io/loophole-web|' build/win32/code.iss
  sed -i 's|Microsoft Corporation|Loophole AI|' build/win32/code.iss
fi

cd ..
