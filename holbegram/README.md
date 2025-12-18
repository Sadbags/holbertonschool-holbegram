
# Holbegram

* Novice
* By: Youssef Belhadj
* Weight: 7
* Your score will be updated as you progress.
* **Manual QA review must be done** (request it when you are done with the project)
* [Description](https://intranet.hbtn.io/projects/2918#description)

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/421e4b86bd6b7ae8b3491b4a80b5ce55d194093e.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=c86511f615aec2c9838d6bf8fd14effee3ab9eeaa80bd9355fb64a7638691adb)

Hello Holbies welcome to the final Flutter Project. It’s going to be special and I hope that you have fun doing it.

In general, developing a mobile application is a complex and challenging task. There are many frameworks available to develop a mobile application. Android provides a native framework based on Java language and iOS provides a native framework based on Objective-C / Shift language. However, to develop an application supporting both the OS’s, we need to code in two different languages using two different frameworks. To solve this problem there is Flutter – a simple and high-performance framework based on Dart language that provides high performance by rendering the UI directly in the operating system’s canvas rather than through the native framework.

To lighten up your mood get you ready for this amazing project you can start by clicking on this [LINK](https://intranet.hbtn.io/rltoken/1BdEBUOyOctbctpoIFfp9A "LINK")

I know it might be very challenging to do such a project with limited knowledge in flutter but we are Holberton students and WE CAN DO ANYTHING. I believe in you guys

Let’s begin the Journey.

## Resources

 **Read or watch** :

* [Dart - Cheatsheet](https://intranet.hbtn.io/rltoken/vNcJwx9uH1oO97J3weOg2Q "Dart - Cheatsheet")
* [FlutterFire Overview](https://intranet.hbtn.io/rltoken/2pqfv23C5fIPlhQuc8-lzw "FlutterFire Overview")
* [Getting started with Firebase on Flutter](https://intranet.hbtn.io/rltoken/HT04HWjRJGP6J-TRB6USKA "Getting started with Firebase on Flutter")
* [Get Started with Firebase Authentication on Flutter](https://intranet.hbtn.io/rltoken/RPOfxJurI2FTxqvM3_Rz7g "Get Started with Firebase Authentication on Flutter")
* [Cloud Storage on Flutter](https://intranet.hbtn.io/rltoken/P6NOA7DAhr4Nj51tnZxaFQ "Cloud Storage on Flutter")
* [Layouts in Flutter](https://intranet.hbtn.io/rltoken/w2ZjcQ9A0uJy4l1z2sehcQ "Layouts in Flutter")
* [Introduction to widgets](https://intranet.hbtn.io/rltoken/bnUF2_6TmceGXZgRMpyW_A "Introduction to widgets")
* [Cloudinary Storage Images uploading | Flutter](https://intranet.hbtn.io/rltoken/MemgVBz8hW7Rh5Ty_qtpbA "Cloudinary Storage Images uploading | Flutter")

**Every Flutter Widgets**

* [Every Flutter Widget Explained](https://intranet.hbtn.io/rltoken/pUuGD0ZBuuTUsLAsubY2hA "Every Flutter Widget Explained")

## Dependencies

* [Firebase Database Plugin for Flutter](https://intranet.hbtn.io/rltoken/XxBGYPjJR_VnypLH1WKkDw "Firebase Database Plugin for Flutter")
* [Firebase Auth for Flutter](https://intranet.hbtn.io/rltoken/PCtSeP6u5iTMeYF2GCkuQg "Firebase Auth for Flutter")
* [Cupertino Icons](https://intranet.hbtn.io/rltoken/Tcw5xQE-I82BKJXtqGlHfQ "Cupertino Icons")
* [Image Picker plugin for Flutter](https://intranet.hbtn.io/rltoken/Vfe2qOIdL0RopYOAYTk3pg "Image Picker plugin for Flutter")
* [BottomNavyBar](https://intranet.hbtn.io/rltoken/nQ4YnR5B2dJLE_3MMrbhCQ "BottomNavyBar")
* [provider](https://intranet.hbtn.io/rltoken/Csmd0Q5cp4RNN7Sy5sDxgg "provider")
* [Uuid](https://intranet.hbtn.io/rltoken/yUJfdeEq9PDuDC6DEI2u2A "Uuid")
* [Cached network image](https://intranet.hbtn.io/rltoken/y2P1OdJfXQ9kToqVXLdLNw "Flutter&lt;em&gt;staggered&lt;/em&gt;grid_view network image&quot; target=“_blank”&gt;Flutter&lt;em&gt;staggered&lt;/em&gt;grid_view network image&lt;/a&gt;&lt;/li&gt;
  &lt;li&gt;&lt;a href=")
* [Flutter Pull To Refresh](https://intranet.hbtn.io/rltoken/lWP8nNM9OzPRFC0A5Kk-3w "Flutter Pull To Refresh")

## Requirements

**Create your project :**

Open you’re command-line tool

* `flutter create holbegram`
* `cd holbegram`
* `flutter run`

**Step up your Firebase**

For the backend, we are going to use Firebase(Firebase is a Backend-as-a-Service (BaaS) app development platform that provides hosted backend services such as (`a real-time database`, `cloud storage`, `authentication`, `crash reporting`, `machine learning`, `remote configuration`) and hosting for your static files. However, for storing and managing images, we will use Cloudinary, which is a cloud service that provides an easy-to-use solution for managing images and videos, including features for storing, transforming, and delivering media content. Cloudinary will handle the storage and retrieval of image files, while Firebase will handle the authentication and database functionalities.

Let’s start…

go to `https://firebase.google.com/` and create an account then Let’s create a new project in firebase.

Go to Firebase Console and click Add Project and then you have to go through some steps.

 **First** , we are going to build a fire_base app called `holbegram`:

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/effcaadc5053cd0f13321f3da0ca7af485e48499.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=fa3b1af87b25a467f5344e7cae33fbd078bfdbae70ee6a955fffca25ee4a5438)

**Second** Disable Google Analytics for this project:

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/75475181f194def86264d0898b5ccde396c21725.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=602e51d83a2ed329fa7785361a8082b19b7f8f989ae799abc202674d97808eb1)

**Authentication**

Click on Enable the Authentication: Enable the Email/Password

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/b25d3fd7c4d0bd2ffb3dd8308ecaf22f00794548.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=28302a8faf8e9eaccd446af34d594920a6f2efd6a6651586e13c32cbd741fa4a)

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/7f78a5264c27e64db051eeec0edd2ed872c9beba.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=890a8cfda0c2b5cf7a0388f9410a31a7357f471a0eb6ff9df792933eb54d1bb8)

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/60f7d7c2e8b28345beb62365d71a737182693ff2.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=30a332bfe936b625328736be9c94e611d1310f3ea1a53de032420a9d4c5805b7)

**Database**

Well done! Now you are going to move to the next task which is creating a database.

To do that follow the following steps:

1- Go to Firestore Database then click on Create Database.

2- Choose “start in test mode”

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/fcb8a7236705b8a58455fa12972d20c66712cf64.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=c454d3ef5fe04dfacbbbc805f3138aff2f57f53be159f4341418b4c5d219249d)

3- choose the location that is close to you.

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/2cccf7ed30807a79d66640d0c862b62b41e28750.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=a18d0d3e56accbfe0714b06e890f1c01772736ded4068867537b4954ae61c78b)

4- Go to rules:

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/ee6587e9101eb092270dbe1582bfc85bfc951c95.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=35d1dcc3432a95d8690ba81a6e7dc9523cf1563721e815b2abdd601715de5a73)

Finally, press Publish

**Adding Firebase to our App**

**So now let’s add Firebase to our app:**

**If you want to use Android Follow the Android Support**

**If you want to work with iOS follow the iOS Support**

# **Adding Android support**

Registering the App

In order to add Android support to our Flutter application, select the Android logo from the dashboard. This brings us to the following screen:

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/79c7e4222312d48e0c162322f2d138f476e2d0c0.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=d971f6cad4a6a3f2fb39dc989492efb6a5f36cd43215968f86805eadf2f7f5ab)

The most important thing here is to match up the Android package name that you choose here with the one inside of our application.

The structure consists of at least two segments. A common pattern is to use a domain name, a company name, and the application name:

`com.example.holbegram`

Once you’ve decided on a name, open `android/app/build.gradle` in your code editor and update the applicationId to match the `Android package name`:

Example of File `android/app/build.gradle`

```
...
defaultConfig {
    // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
    applicationId 'com.example.holbegram'
    ...
}
...
```

You can skip the app nickname and debug signing keys at this stage. Select Register app to continue.

**Downloading the Config File**

The next step is to add the `Firebase configuration` file into our Flutter project. This is important as it contains the API keys and other critical information for Firebase to use.

Select Download `google-services.json` from this page:

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/29220467a87b78d62f287d431dc5c308470c01b9.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=8718d40ea6978f6a0f320849c5eeb6da556ddbe023afc69f1ed986d6456d3947)

Next, move the `google-services.json` file to the `android/app` directory within the Flutter project.

**Adding the Firebase SDK**

We’ll now need to update our Gradle configuration to include the Google Services plugin.

Open `android/build.gradle` in your code editor and modify it to include the following:

Example of File `android/build.gradle`

```
buildscript {
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
  }
  dependencies {
    ...
    // Add this line
    classpath 'com.google.gms:google-services:4.3.13'
  }
}

allprojects {
  ...
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
    ...
  }
}
```

Finally, update the app level file at `android/app/build.gradle` to include the following:

Example of File `android/app/build.gradle`

```
apply plugin: 'com.android.application'
// Add this line
apply plugin: 'com.google.gms.google-services'

dependencies {
  // Import the Firebase BoM
 implementation platform('com.google.firebase:firebase-bom:30.2.0')

  // Add the dependencies for any other desired Firebase products
  // https://firebase.google.com/docs/android/setup#available-libraries
}
```

With this update, we’re essentially applying the Google Services plugin as well as looking at how other Flutter Firebase plugins can be activated such as Analytics.

From here, run your application on an Android device or simulator. If everything has worked correctly, you should get the following message in the dashboard:

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/eca3dbd42b0d5c6af14cb2292bb7ef321b9d6fa3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=e03736020a2b900761f7234b61628d4b9457d19f4eb593ca84844467069f3bb4)

# **Adding iOS support**

In order to add Firebase support for iOS, we have to follow a similar set of instructions.

Head back over to the dashboard and select Add app and then iOS icon to be navigated to the setup process.

**Registering an App**

You Should have **Xcode** installed in your PC:

Once again, we’ll need to add an “iOS Bundle ID”. It is possible to use the “Android package name” for consistency:

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/f45889853f3e6c71ef12e7a13889c9378e89c472.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=1b88791e42db72d002715b15d3c9c34d5ac0f5a733e18a05b89920a93a085e23)

You’ll then need to make sure this matches up by opening the iOS folder up in `Xcode`

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/9d7946cee42b4fe2f94cd07c95c42b3a58f1285f.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=9fc7999bf19d0075869812cd7c5760a00faf20281b0155eabd15091bf813eed5)

* General

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/83c1b8343fb170c1162d3eb0d022aa50fb04ce06.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=f259f79f427b0afd6d8ebaa4c6cb86dde144205ff0e7d35670315604d18809a0)

Now go back to your firebase and add the iOS Bundle ID

after that Download the configuration file

**Downloading the Config File**

Drag and Drop the file `GoogleService-Info.plist` and move this into the root of your Xcode project within `Runner`:

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/b13f1b0452f1145f980d439a4dcda17a2d4d0f5c.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=93c2fb63873a03c5bf46d0443d7a10624b1ae51adfc5a204d94f2be559359350)

![](https://s3.eu-west-3.amazonaws.com/hbtn.intranet/uploads/medias/2022/11/d8d7fb980a6bf8db79fca2b2f029d4f423767b80.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4MYA5JM5DUTZGMZG%2F20251218%2Feu-west-3%2Fs3%2Faws4_request&X-Amz-Date=20251218T002304Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=1d08d1439a23d361b6f59f2d460263f5a412fe191a112894d3cb08b77b6d41de)

Be sure to move this file within Xcode to create the proper file references.
