# NCUT_APP

# 專案介紹
-	Dart語言進行編成，並採用Flutter框架設計
-	使用Firebase中的Realtime Database建立雲端資料庫
-	功能:
    -	閱讀學校、科系、教師的公告
    -	查看學校附近的公車路線(去程及回程路線)

# 內容

執行Pub get：/windows/pubspec.look

firebase：https://firebase.google.com/

NCUT Project/Realtime Database

firebase to android

官方指引：https://firebase.google.com/docs/android/setup?hl=zh-tw#kotlin

模組（應用程式層級） Gradle 檔案（通常<project>/<app-module>/build.gradle.kts或<project>/<app-module>/build.gradle ）中
此專案的build.gradle位置：\ncut_app_firebase_project\android\app\build.gradle

firebase 位置在 main.dart 中，Get json 底下的 Future<Map<String, dynamic>> data() async {} 中
如果出現無資料，是因為使用 firebase 免費只有 30 天期限，但想繼續使用只須重新建置並確認 url 是否正確
