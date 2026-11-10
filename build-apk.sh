#!/usr/bin/env bash
# بناء APK بمعمارية arm64-v8a فقط، موقّع وجاهز للتثبيت
set -e
cd "$(dirname "$0")"
npm install
npx cap sync android
[ -f study-release.jks ] || keytool -genkeypair -keystore study-release.jks -alias study -keyalg RSA -keysize 2048 -validity 10000 -storepass studyapp123 -keypass studyapp123 -dname "CN=Study Planner"
(cd android && ./gradlew assembleRelease)
mkdir -p dist && cp android/app/build/outputs/apk/release/app-release.apk dist/study-planner-arm64.apk
echo "تم: dist/study-planner-arm64.apk"
