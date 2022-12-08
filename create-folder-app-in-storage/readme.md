<h2>Cara membuat folder ataupun file di internal storage Android menggunakan Flutter.</h2>

<h4>- Package list:</h4>
1. path_provider: https://pub.dev/packages/path_provider <br>
2. permission_handler: https://pub.dev/packages/permission_handler <br>
3. screenshot: https://pub.dev/packages/screenshot

<h4>- Additional info </h4>
Jika SDK target >= 29, tambahkan script berikut di file AndroidManifest.xml di dalam tag Application sebelum tag activity
android:requestLegacyExternalStorage="true"
<br> <br>
<img src="https://github.com/idekorslet/Belajar-Flutter/blob/main/create-folder-app-in-storage/sdk-target-higher-than-equal29.jpg"/>

<h4>- Tutorial di Youtube:</h4>
https://youtu.be/kgz1CWhasps

<h4> - Hasil/result:</h4>

<video src='https://user-images.githubusercontent.com/80518183/204736418-eede8dfd-63cf-4ba4-965f-bc0e6f941a15.mov' width=180/>
