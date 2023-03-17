# parking_lot_ver1
駐車場

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## create a new project
flutter create parkign_lot_ver1

## create a new repository on the command line
1. 新しいリポジトリを作る（read meは作らない）
    https://github.com/hiramatsuYoshiaki/ride_activity.git
2. git init
3. git add -A
4. git commit -m "first commit"
5. git branch -M main
6. git remote add origin https://hiramatsuYoshiaki:ghp_xxxxx@github.com/hiramatsuYoshiaki/ride_activity.git
7. git push -u origin main

  
# github アクセストークン設定方法
yoshiakiHiramatsu token  
```
$ git remote set-url origin https://<githubのユーザー名>:<トークン>@github.com/リポジトリ.git  
$ git remote set-url origin https://hiramatsuYoshiaki:ghp_xxxxxxxxxxxxxxxxxxx@github.com/hiramatsuYoshiaki/react-start.git  
  
  
git remote -v   
origin  https://hiramatsuYoshiaki:ghp_xxxxxxxxxxxxxxxxxxx@github.com/hiramatsuYoshiaki/react-start.git (fetch)  
origin  https://hiramatsuYoshiaki:ghp_xxxxxxxxxxxxxxxxxxx@github.com/hiramatsuYoshiaki/react-start.git (push)  
```

github トークンの有効期限確認  
https://github.com/settings/tokens 

#Flutter channelの確認方法と切り替え方法   
https://zuma-lab.com/posts/flutter-channel-command  


# FlutterのFirebaseを知る (チュートリアル)
https://firebase.google.com/codelabs/firebase-get-to-know-flutter?hl=en#0


1. 始める前に  
2. サンプルコードを取得します  
    `git clone https://github.com/flutter/codelabs.git flutter-codelabs`
3. Firebaseプロジェクトを作成して設定します  
    3-1 Firebaseプロジェクトを作成する。今回は以下のプロジェクトを使用。  
        project name : ride-activity  
        project id : ride-activity  
    3-2 Firebase認証のメールログインを有効にする  
    3-3 CloudFirestoreを有効にする  
4. Firebaseの構成 
    (flutterfire CLI tool)
    4-1 依存関係を構成する  
    4-1-1 firebase_coreは、FirebaseFlutterプラグインに必要な共通のコードです。  
        `$ flutter pub add firebase_core `  
    4-1-2 firebase_auth、Firebaseの認証機能との統合を可能にします。  
        `$ flutter pub add firebase_auth`  
    4-1-3 cloud_firestore、CloudFirestoreデータストレージへのアクセスを有効にします。  
        `$ flutter pub add cloud_firestore`  
    4-1-4 必要なパッケージを追加すると同時に、Firebaseを適切に利用するようにiOS、Android、macOS、およびWebランナープロジェクトを構成する必要があります。providerまた、ビジネスロジックを表示ロジックから分離できるようにするパッケージを使用しています。  
        `$ flutter pub add provider`  
    4-2 アプリの構成  
        `$ flutterfire configure`  
        プロセスをガイドを選択  
        4-2-1 Firebaseプロジェクトの選択  
        4-2-2 構成するプラットフォーム（Android、iOS、macOS、Webなど）を入力します。  
        4-2-3 選択したプラットフォームのどのFirebaseアプリケーションを使用して構成を抽出する必要があるかを特定します。デフォルトでは、CLIは現在のプロジェクト構成に基づいてFirebaseアプリを自動的に照合しようとします。  
        4-2-4 プロジェクトでfirebase_options.dartファイルを生成します。  
    
    ```
    flutterfire configure

    i Found 22 Firebase projects.
    ? Select a Firebase project to configure your Flutter application with ›
        ✔ Select a Firebase project to configure your Flutter application with · ride-activity (ride-activity)
    ? Which platforms should your configuration support (use arrow keys & space to select)? 
    ✔ Which platforms should your configuration support (use arrow keys & space to select)? 
    · android, ios, web
    i Firebase android app com.example.ride_activity is not registered on Firebase project ride-activity.
    i Registered a new Firebase android app on Firebase project ride-activity.
    ? Which ios bundle id do you want to use for this configuration, e.g. 'com.example.app'?✔ Which ios bundle id do you want to use for this configuration, e.g. 'com.example.app'? · bundle id
    i Firebase ios app bundle id is not registered on Firebase project ride-activity.       
    i Registered a new Firebase ios app on Firebase project ride-activity.
    FirebaseCommandException: An error occured on the Firebase CLI when attempting to run a 
    command.
    COMMAND: firebase apps:create ios ride_activity (ios) --bundle-id=bundle id --json --project=ride-activity
    ERROR: Failed to create iOS app for project ride-activity. See firebase-debug.log for more info.


    ```
#firebase hosthin 
https://www.flutter-study.dev/host-web-app/hosting
1. ウェブアプリのルート ディレクトリでGoogle へのログインする.
    `$ firebase login`
2. プロジェクトの開始
    `$ firebase init`
3. 選択する。　
    「Use an existing project」を選択しEnter　
    使用するプロジェクトを選択しEnter　
    「? What do you want to use as your public directory?」に 「build/web」 を入力　
    「? Configure as a single-page app (rewrite all urls to /index.html)?」に 「N」 を入力　

```
        ? Are you ready to proceed? Yes
        ? Which Firebase features do you want to set up for this directory? Press Space to select features, then Enter to confirm your choices. Firestore: Configure security rules and indexes files for Firestore, Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys, Storage: Configure a security rules file for Cloud Storage

        === Project Setup

        First, let's associate this project directory with a Firebase project.
        You can create multiple project aliases by running firebase use --add, 
        but for now we'll just set up a default project.

        ? Please select an option: Use an existing project
        ? Select a default Firebase project for this directory: ride-activity (ride-activity)
        i  Using project ride-activity (ride-activity)

        === Firestore Setup

        Firestore Security Rules allow you to define how and when to allow
        requests. You can keep these rules in your project directory      
        and publish them with firebase deploy.

        ? What file should be used for Firestore Rules? firestore.rules

        Firestore indexes allow you to perform complex queries while
        maintaining performance that scales with the size of the result
        set. You can keep index definitions in your project directory
        and publish them with firebase deploy.

        ? What file should be used for Firestore indexes? firestore.indexes.json

        === Hosting Setup

        Your public directory is the folder (relative to your project directory) that
        will contain Hosting assets to be uploaded with firebase deploy. If you
        have a build process for your assets, use your build's output directory.

        ? What do you want to use as your public directory? build/web
        ? Configure as a single-page app (rewrite all urls to /index.html)? No
        ? Set up automatic builds and deploys with GitHub? No
        +  Wrote build/web/404.html
        +  Wrote build/web/index.html

        === Storage Setup

        Firebase Storage Security Rules allow you to define how and when to allow
        uploads and downloads. You can keep these rules in your project directory
        and publish them with firebase deploy.

        ? What file should be used for Storage Rules? storage.rules
        +  Wrote storage.rules

        i  Writing configuration info to firebase.json...
        i  Writing project information to .firebaserc...

        +  Firebase initialization complete!
```

4. Webアプリをビルドする 
    `$ flutter build web` 
5. Webアプリをアップロードする 
    `$ firebase deploy` 
    Project Console: https://console.firebase.google.com/project/ride-activity/overview  
    Hosting URL: https://ride-activity.web.app  


# Cloud Firestore にデータを追加する
 `https://firebase.google.com/docs/firestore/manage-data/add-data#dart_1` 
 1. ドキュメントを設定する 
 ```
void addData_setADocument() {
    final city = <String, String>{
      "name": "Los Angeles",
      "state": "CA",
      "country": "USA"
    };

    db.collection("cities")
        .doc("LA")
        .set(city)
        .onError((e, _) => print("Error writing document: $e"));
  }
 ```
 単一のドキュメントを作成または上書きするには、set() メソッドを使用します。  
 ドキュメントが存在しない場合は、ドキュメントが新規に作成されます。  
 ドキュメントが存在する場合 、 
 次のように既存のドキュメントにデータを統合するように指定しない限り、  
 新しく提供されたデータでコンテンツが上書きされます。  
 ```
    final data = {"capital": true};

    db.collection("cities").doc("BJ").set(data, SetOptions(merge: true));
 ```

 2. データ型 ＊ネスト構造を持ったデータの例
 ```
 void addData_dataTypes() {
    final docData = {
      "stringExample": "Hello world!",
      "booleanExample": true,
      "numberExample": 3.14159265,
      "dateExample": Timestamp.now(),
      "listExample": [1, 2, 3],
      "nullExample": null
    };

    final nestedData = {
      "a": 5,
      "b": true,
    };

    docData["objectExample"] = nestedData;

    db
        .collection("data")
        .doc("one")
        .set(docData)
        .onError((e, _) => print("Error writing document: $e"));
  }
 ```
 Cloud Firestore では、文字列、ブール値、日付、NULL、ネストされた配列、オブジェクトなど、さまざまなデータ型をドキュメントに書き込むことができます。Cloud Firestore は、コードで使用する数字の種類に関係なく、数値を必ず double 型として保存します。
    
 3. カスタム オブジェクト
 ```
import 'package:cloud_firestore/cloud_firestore.dart';

// [START add_data_custom_objects]
class City {
  final String? name;
  final String? state;
  final String? country;
  final bool? capital;
  final int? population;
  final List<String>? regions;

  City({
    this.name,
    this.state,
    this.country,
    this.capital,
    this.population,
    this.regions,
  });

  factory City.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return City(
      name: data?['name'],
      state: data?['state'],
      country: data?['country'],
      capital: data?['capital'],
      population: data?['population'],
      regions:
          data?['regions'] is Iterable ? List.from(data?['regions']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (capital != null) "capital": capital,
      if (population != null) "population": population,
      if (regions != null) "regions": regions,
    };
  }
}
 ```
 ```
void addData_customObjects2() async {
    // [START add_data_custom_objects2]
    final city = City(
      name: "Los Angeles",
      state: "CA",
      country: "USA",
      capital: false,
      population: 5000000,
      regions: ["west_coast", "socal"],
    );
    final docRef = db
        .collection("cities")
        .withConverter(
          fromFirestore: City.fromFirestore,
          toFirestore: (City city, options) => city.toFirestore(),
        )
        .doc("LA");
    await docRef.set(city);
    // [END add_data_custom_objects2]
  }

 ```
 Map または Dictionary オブジェクトを使うとドキュメントを表しにくいことが多いため、  
 Cloud Firestore では、カスタムクラスを使ったドキュメント作成をサポートしています。  
 Cloud Firestore は、オブジェクトをサポートされているデータ型に変換します。
  
4. ドキュメントの追加
    4-1. set() を使用してドキュメントを作成する場合、作成するドキュメントの ID を指定する必要があります 
    ```
    void addData_addADocument() {
    db.collection("cities").doc("new-city-id").set({"name": "Chicago"});
    }
    ``` 
    4-2. ドキュメントに有効な ID がなく、Cloud Firestore が ID を自動的に生成するように設定したほうが都合のよい場合もあります。この設定を行うには、add() を呼び出します。
    ```
    void addData_addADocument2() {
    // Add a new document with a generated id.
    final data = {"name": "Tokyo", "country": "Japan"};

    db.collection("cities").add(data).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }
    ```
5. ドキュメントを更新する
```
void addData_updateADocument() {
    // [START add_data_update_a_document]
    final washingtonRef = db.collection("cites").doc("DC");
    washingtonRef.update({"capital": true}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
    // [END add_data_update_a_document]
  }
```
ドキュメント全体を上書きせずにドキュメントの一部のフィールドを更新するには、update() メソッドを使用します。 

6. サーバーのタイムスタンプ 
```
void addData_serverTimestamp() {
    // [START add_data_server_timestamp]
    final docRef = db.collection("objects").doc("some-id");
    final updates = <String, dynamic>{
      "timestamp": FieldValue.serverTimestamp(),
    };

    docRef.update(updates).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
    //
```
ドキュメントのフィールドに、サーバーが更新を受信した時刻を追跡する、  
サーバーのタイムスタンプを設定できます。
 
6. ネストされたオブジェクトのフィールドを更新する
    6-1. ネストされたオブジェクトがドキュメントに含まれている場合は、update() を呼び出すときにドット表記を使用してドキュメント内のネストされたフィールドを参照できます。
```
    void addData_updateFieldsInNestedObjects() {
        // [START add_data_update_fields_in_nested_objects]
        // Assume the document contains:
        // {
        //   name: "Frank",
        //   favorites: { food: "Pizza", color: "Blue", subject: "recess" }
        //   age: 12
        // }
        db
            .collection("users")
            .doc("frank")
            .update({"age": 13, "favorites.color": "Red"});
        // [END add_data_update_fields_in_nested_objects]
    }
``` 
    6-2. ドット表記を使用すると、1 個のネストされたフィールドを更新する際、他のネストされたフィールドを上書きせず済みます。ドット表記を使用せずにネストされたフィールドを更新すると、マップ フィールド全体が上書きされます。以下にその例を示します。
```
    // Create our initial doc
    db.collection("users").doc("frank").set({
    name: "Frank",
    favorites: {
        food: "Pizza",
        color: "Blue",
        subject: "Recess"
    },
    age: 12
    }).then(function() {
    console.log("Frank created");
    });

    // Update the doc without using dot notation.
    // Notice the map value for favorites.
    db.collection("users").doc("frank").update({
    favorites: {
        food: "Ice Cream"
    }
    }).then(function() {
    console.log("Frank food updated");
    });

    /*
    Ending State, favorite.color and favorite.subject are no longer present:
    /users
        /frank
            {
                name: "Frank",
                favorites: {
                    food: "Ice Cream",
                },
                age: 12
            }
    */
```
  
7. 配列内の要素を更新する
```
void addData_updateElementsInArray() {
    final washingtonRef = db.collection("cities").doc("DC");

    // Atomically add a new region to the "regions" array field.
    washingtonRef.update({
      "regions": FieldValue.arrayUnion(["greater_virginia"]),
    });

    // Atomically remove a region from the "regions" array field.
    washingtonRef.update({
      "regions": FieldValue.arrayRemove(["east_coast"]), 
    });
  }
```
ドキュメントに配列フィールドがある場合は、arrayUnion() と arrayRemove() を使用して要素を追加および削除できます。arrayUnion() は要素を配列に追加しますが、追加されるのはまだ存在しない要素のみです。arrayRemove() は、指定した各要素のインスタンスすべてを削除します。
  
8. 数値を増やす 
```
void addData_incrementANumericValue() {
    var washingtonRef = db.collection('cities').doc('DC');

    // Atomically increment the population of the city by 50.
    washingtonRef.update(
      {"population": FieldValue.increment(50)},
    );
  }
```

     

# Cloud Firestore で単純なクエリと複合クエリを実行する 
`https://firebase.google.com/docs/firestore/query-data/queries`


# Firestoreにネストされたカスタムオブジェクトを追加する
Cloud Firestore にデータを追加する カスタム 
https://firebase.google.com/docs/firestore/manage-data/add-data#dart_1
参考：cloud_firestoreのwithConverterと仲良くなる  　
https://zenn.dev/tsuruo/articles/23894990188653　　　  
  
1. カスタム オブジェクトをwithConverterで追加する。
`model`
```
import 'package:cloud_firestore/cloud_firestore.dart';

class Activities {
  final RiderActivities plan;
  final ActualRide actual;
  final Menber menber;

  final bool shared;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updateAt;
  final String status; 
  Activities({
    required this.plan,
    required this.actual,
    required this.menber,
    required this.shared,
    required this.tags,
    required this.createdAt,
    required this.updateAt,
    required this.status,
  });
  factory Activities.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Activities(
      plan: data?['plan'],
      actual: data?['actual'],
      menber: data?['menber'],
      shared: data?['shared'],
      tags: data?['tags'],
      createdAt: data?['createdAt'],
      updateAt: data?['updateAt'],
      status: data?['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      // 'plan': plan,
      'plan': {
        'uid': plan.uid,
        'activityTitle': plan.activityTitle,
        'date': plan.date,
        'distance': plan.distance,
        'done': plan.done,
        'couseURL': plan.couseURL,
        'startPoint': plan.startPoint,
        'wayPoint': plan.wayPoint,
        'finishPoint': plan.finishPoint,
        'prefacture': plan.prefacture,
        'rideType': plan.rideType,
      },
      // 'actual': actual,
      'actual': {
        'rideURL': actual.rideURL,
        'ridePhotos': actual.ridePhotos,
      },
      // 'menber': menber,
      'menber': {
        'rider': menber.rider,
      },
      'shared': shared,
      'tags': tags,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'status': status,
    };
  }
}

class RiderActivities {
  final String uid;
  final String activityTitle;
  final DateTime date;
  final int distance;
  final bool done;
  final String couseURL;
  final String startPoint;
  final String wayPoint;
  final String finishPoint;

  final List<String> prefacture;
  final String rideType;
  RiderActivities({
    required this.uid,
    required this.activityTitle,
    required this.date,
    required this.distance,
    required this.done,
    required this.couseURL,
    required this.startPoint,
    required this.wayPoint,
    required this.finishPoint,
    required this.prefacture,
    required this.rideType,
  });
}

class ActualRide {
  final String rideURL;
  final List<String> ridePhotos;
  ActualRide({
    required this.rideURL,
    required this.ridePhotos,
  });
}

class Menber {
  final List<String> rider;
  Menber({
    required this.rider,
  });
}

```　
`add withConverter`
```
Future<void> addActivityFiresore(Activities activity) {
  Activities docData = Activities(
      plan: RiderActivities(
        uid: _riderInfo.uid,
        activityTitle: activity.plan.activityTitle,
        date: activity.plan.date,
        distance: activity.plan.distance,
        done: activity.plan.done,
        startPoint: activity.plan.startPoint,
        wayPoint: activity.plan.wayPoint,
        finishPoint: activity.plan.finishPoint,
        couseURL: activity.plan.couseURL,
        prefacture: activity.plan.prefacture,
        rideType: activity.plan.rideType,
      ),
      actual: ActualRide(
        rideURL: activity.actual.rideURL,
        ridePhotos: activity.actual.ridePhotos,
      ),
      menber: Menber(rider: activity.menber.rider),
      shared: activity.shared,
      tags: activity.tags,
      createdAt: activity.createdAt,
      updateAt: activity.updateAt,
      status: activity.status,
    );
    print(docData);
    return FirebaseFirestore.instance
        .collection("activities")
        .withConverter(
          fromFirestore: Activities.fromFirestore,
          toFirestore: (Activities docData, options) => docData.toFirestore(),
        )
        .add(docData)
        .then((value) => debugPrint("Activities Added"))
        .catchError((error) => debugPrint("Failed to add Activities: $error"));
  }
```


2. カスタム オブジェクトを通常の方法で追加。　
```
import 'package:cloud_firestore/cloud_firestore.dart';

class Activities {
  final RiderActivities plan;
  final ActualRide actual;
  final Menber menber;

  final bool shared;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updateAt;
  final String status; 
  Activities({
    required this.plan,
    required this.actual,
    required this.menber,
    required this.shared,
    required this.tags,
    required this.createdAt,
    required this.updateAt,
    required this.status,
  });
}

class RiderActivities {
  final String uid;
  final String activityTitle;
  final DateTime date;
  final int distance;
  final bool done;
  final String couseURL;
  final String startPoint;
  final String wayPoint;
  final String finishPoint;

  final List<String> prefacture;
  final String rideType;
  RiderActivities({
    required this.uid,
    required this.activityTitle,
    required this.date,
    required this.distance,
    required this.done,
    required this.couseURL,
    required this.startPoint,
    required this.wayPoint,
    required this.finishPoint,
    required this.prefacture,
    required this.rideType,
  });
}

class ActualRide {
  final String rideURL;
  final List<String> ridePhotos;
  ActualRide({
    required this.rideURL,
    required this.ridePhotos,
  });
}

class Menber {
  final List<String> rider;
  Menber({
    required this.rider,
  });
}

```　
```
Future<void> addActivityFiresore(Activities activity) {
     final docData = {
       "shared": true,
       "tags": activity.tags,
       "createdAt": Timestamp.now(),
       "updateAt": Timestamp.now(),
       "status": "active"
     };
     final plan = {
       "uid": _riderInfo.uid,
       "activityTitle": activity.plan.activityTitle,
       "date": activity.plan.date, 
       "distance": activity.plan.distance,
       "done": false,
       "startPoint": activity.plan.startPoint,
       "wayPoint": activity.plan.wayPoint,
       "finishPoint": activity.plan.finishPoint,
       "couseURL": activity.plan.couseURL,
       "prefacture": activity.plan.prefacture,
       "rideType": activity.plan.rideType,
     };
     final actual = {
       "rideURL": activity.actual.rideURL,
       "ridePhotos": activity.actual.ridePhotos,
     };
     final menber = {
       "rider": activity.menber.rider,
     };
     docData["plan"] = plan;
     docData["actual"] = actual;
     docData["member"] = menber;
     print(docData);
    print(docData);
     return FirebaseFirestore.instance
         .collection('activities')
         .add(docData)
         .then((value) => debugPrint("Activities Added"))
         .catchError((error) => debugPrint("Failed to add Activities: $error"));
  }
```
   
# FirestoreからネストされたカスタムオブジェクトをwithConbaerterで取得する
- Cloud Firestore https://firebase.flutter.dev/docs/firestore/usage/
- Cloud Firestore でデータを取得する https://firebase.google.com/docs/firestore/query-data/get-data
- withConverter<R> method https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/Query/withConverter.html
- 

`model`
```
import 'package:cloud_firestore/cloud_firestore.dart';

class Activities {
  final RiderActivities plan;
  final ActualRide actual;
  final Menber menber;

  final bool shared;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updateAt;
  final String status; 
  Activities({
    required this.plan,
    required this.actual,
    required this.menber,
    required this.shared,
    required this.tags,
    required this.createdAt,
    required this.updateAt,
    required this.status,
  });
  factory Activities.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Activities(
      plan: data?['plan'],
      actual: data?['actual'],
      menber: data?['menber'],
      shared: data?['shared'],
      tags: data?['tags'],
      createdAt: data?['createdAt'],
      updateAt: data?['updateAt'],
      status: data?['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      // 'plan': plan,
      'plan': {
        'uid': plan.uid,
        'activityTitle': plan.activityTitle,
        'date': plan.date,
        'distance': plan.distance,
        'done': plan.done,
        'couseURL': plan.couseURL,
        'startPoint': plan.startPoint,
        'wayPoint': plan.wayPoint,
        'finishPoint': plan.finishPoint,
        'prefacture': plan.prefacture,
        'rideType': plan.rideType,
      },
      // 'actual': actual,
      'actual': {
        'rideURL': actual.rideURL,
        'ridePhotos': actual.ridePhotos,
      },
      // 'menber': menber,
      'menber': {
        'rider': menber.rider,
      },
      'shared': shared,
      'tags': tags,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'status': status,
    };
  }
}

class RiderActivities {
  final String uid;
  final String activityTitle;
  final DateTime date;
  final int distance;
  final bool done;
  final String couseURL;
  final String startPoint;
  final String wayPoint;
  final String finishPoint;

  final List<String> prefacture;
  final String rideType;
  RiderActivities({
    required this.uid,
    required this.activityTitle,
    required this.date,
    required this.distance,
    required this.done,
    required this.couseURL,
    required this.startPoint,
    required this.wayPoint,
    required this.finishPoint,
    required this.prefacture,
    required this.rideType,
  });
}

class ActualRide {
  final String rideURL;
  final List<String> ridePhotos;
  ActualRide({
    required this.rideURL,
    required this.ridePhotos,
  });
}

class Menber {
  final List<String> rider;
  Menber({
    required this.rider,
  });
}

```　
`get withConverter`
```
final ref = FirebaseFirestore.instance
          .collection("activities")
          .orderBy('plan.date', descending: false)
          .withConverter<Activities>(
            fromFirestore: Activities.fromFirestore,
            toFirestore: (Activities selectedActivity, _) =>
                selectedActivity.toFirestore(),
          );
await ref
          .get()
          .then((QuerySnapshot querySnapshot) => {
                // debugPrint("Activities Geted docSnap: $querySnapshot")

                querySnapshot.docs.forEach((doc) {
                 Activities _selectedActivity = Activities(
                    plan: RiderActivities(
                      uid: doc["plan.uid"],
                      activityTitle: doc["plan.activityTitle"],
                      date: doc["plan.date"].toDate(),
                      distance: doc["plan.distance"],
                      done: doc["plan.done"],
                      startPoint: doc["plan.startPoint"],
                      wayPoint: doc["plan.wayPoint"],
                      finishPoint: doc["plan.finishPoint"],
                      couseURL: doc["plan.couseURL"],
                      prefacture: List<String>.from(doc['plan.prefacture']),
                      //FirestoreはList<String>（フラッター）の代わりにList<dynamic>を返します
                      //型変換を処理する
                      // imageUrls: List<String>.from(map['imageUrls']),
                      // (map['imageUrls'] as List)?.map((item) => item as String)?.toList();
                      //imageUrls: <String>[...map['imageUrls']],
                      rideType: doc["plan.rideType"],
                    ),
                    actual: ActualRide(
                      rideURL: doc["actual.rideURL"],
                      ridePhotos: List<String>.from(doc['actual.ridePhotos']),
                    ),
                    menber: Menber(
                      rider: List<String>.from(doc['menber.rider']),
                    ),
                    shared: doc["shared"],
                    tags: List<String>.from(doc['tags']),
                    createdAt: doc["createdAt"].toDate(),
                    updateAt: doc["updateAt"].toDate(),
                    status: doc["status"],
                  );
                  _activities.add(_selectedActivity);
                })
              })
          .catchError(
              (error) => debugPrint("Failed to add Activities: $error"));
```

# FirestoreはList<String>（フラッター）の代わりにList<dynamic>を返します 
https://stackoverflow.com/questions/67990075/firestore-returns-listdynamic-instead-of-liststring-flutter
型変換を処理するには、次のいずれかの方法を試すことができます。
1. `imageUrls: List<String>.from(map['imageUrls']),`  
2. `imageUrls: (map['imageUrls'] as List).map((element) => element as String).toList(),`  
3. `imageUrls: <String>[...map['imageUrls']],`  
  
# FirestoreへのFlutterWebアップロード
https://stackoverflow.com/questions/60719724/flutter-web-upload-to-firestore  
```
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ImagePickerDemo extends StatefulWidget {
  const ImagePickerDemo({Key? key}) : super(key: key);

  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}
class _ImagePickerDemoState extends State<ImagePickerDemo> {
  MediaInfo? _imageInfo;

  Future<void> _pickImage() async {
    var fileInfo = await ImagePickerWeb.getImageInfo; //get image
    if (fileInfo.data == null) return; // user did not choose image.
    setState(() {
      _imageInfo = fileInfo; // save image
    });
  }
  Future<void> _uploadImage() async {
    if (_imageInfo == null) return;
    final firebaseStorageLocation =
        FirebaseStorage.instance.ref().child('product_images');
    final imageInfo = _imageInfo as MediaInfo;
    _imageInfo as MediaInfo;
    final firebasefileLocation = firebaseStorageLocation
        .child('${DateTime.now()}_${imageInfo.fileName!}');

    //await firebasefileLocation.putData(imageInfo.data!);
    //ここ修正
    await firebasefileLocation.putData(
        imageInfo.data!,
        SettableMetadata(
          contentType: "image/jpeg", 
        ));
    final urlToUseLater = await firebasefileLocation.getDownloadURL();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: _pickImage, child: Text('Choose Image')),
        ElevatedButton(
            onPressed: _imageInfo == null ? null : _uploadImage,
            child: Text('Upload Image')),
        //Image.memory(
        //  _imageInfo!.data!,
        //  width: 180,
        //)
        //ここ修正
        Container(
          child: _imageInfo != null
              ? Image.memory(
                  _imageInfo!.data!,
                  width: 180,
                )
              : const Text('画像が選択されていません'),
        ),
      ],
    );
  }
}
```
# List.forEachでasync, awaitしたいならFuture.forEachを使おう
https://patorash.hatenablog.com/entry/2017/12/15/024453 
```
main() { // 上の関数にasync必要なし！
  // foosを作る処理は省略
  Future.forEach(foos, (foo) async { // こちらにasyncをつける。
    await new Future.delayed(new Duration(seconds: 1));
    foo.bar();
  });
}
```
# Firestoreでidのわからないdocumentを取得したいときはどうすればいいのか 
https://qiita.com/KOBA-RYOTA/items/eaa1c7d78cf6f2375256  

`doc.idで取得できる。`
```
final ref = FirebaseFirestore.instance
          .collection("activities")
          .orderBy('plan.date', descending: false)
          .withConverter<Activities>(
            fromFirestore: Activities.fromFirestore,
            toFirestore: (Activities selectedActivity, _) =>
                selectedActivity.toFirestore(),
          );
      await ref
          .get()
          .then((QuerySnapshot querySnapshot) => {
                // debugPrint("Activities Geted docSnap: $querySnapshot")

                querySnapshot.docs.forEach((doc) {
                  print(
                      "get -++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+");
                  print(doc.id);
                  // print(doc["plan.uid"]);
                  // print(doc["plan.activityTitle"]);
                  // print(doc["plan.date"]);
                  // print(doc["plan.distance"]);
                  // print(doc["plan.done"]);
                  // print(doc["plan.startPoint"]);
                  // print(doc["plan.wayPoint"]);
                  // print(doc["plan.finishPoint"]);
                  // print(doc["plan.couseURL"]);
                  // print(doc["plan.prefacture"]);
                  // print(doc["plan.rideType"]);
                  // print(doc["actual.rideURL"]);
                  // print(doc["actual.ridePhotos"]);
                  // print(doc["menber.rider"]);
                  // print(doc["shared"]);
                  // print(doc["tags"]);
                  // print(doc["createdAt"]);
                  // print(doc["createdAt"]);
                  // print(doc["status"]);
                  // List<QueryDocumentSnapshot<Activities>> selectedActivity1 =
                  //     querySnapshot.docs.toList();
                  // List<Activities> selectedActivity1 =
                  //     querySnapshot.docs.toList();

                  Activities _selectedActivity = Activities(
                    plan: RiderActivities(
                      uid: doc["plan.uid"],
                      activityTitle: doc["plan.activityTitle"],
                      date: doc["plan.date"].toDate(),
                      distance: doc["plan.distance"],
                      done: doc["plan.done"],
                      startPoint: doc["plan.startPoint"],
                      wayPoint: doc["plan.wayPoint"],
                      finishPoint: doc["plan.finishPoint"],
                      couseURL: doc["plan.couseURL"],
                      prefacture: List<String>.from(doc['plan.prefacture']),
                      //FirestoreはList<String>（フラッター）の代わりにList<dynamic>を返します
                      //型変換を処理する
                      // imageUrls: List<String>.from(map['imageUrls']),
                      // (map['imageUrls'] as List)?.map((item) => item as String)?.toList();
                      //imageUrls: <String>[...map['imageUrls']],
                      rideType: doc["plan.rideType"],
                    ),
                    actual: ActualRide(
                      rideURL: doc["actual.rideURL"],
                      ridePhotos: List<String>.from(doc['actual.ridePhotos']),
                    ),
                    menber: Menber(
                      rider: List<String>.from(doc['menber.rider']),
                    ),
                    shared: doc["shared"],
                    tags: List<String>.from(doc['tags']),
                    createdAt: doc["createdAt"].toDate(),
                    updateAt: doc["updateAt"].toDate(),
                    status: doc["status"],
                  );

                  // print(
                  //     '_selectedActivity----add: ${doc["plan.activityTitle"]}');
                  // print(_selectedActivity);
                  _activities.add(_selectedActivity);
                  // print(_activities);
                })
                // _activities = docSnap;
                // for (var doc in value.docs) {
                // debugPrint("firestore get activities ${doc.id} => ${doc.data()}");
                //   }
              })
          .catchError(
              (error) => debugPrint("Failed to add Activities: $error"));
```







# Webレンダラー
https://docs.flutter.dev/development/platform-integration/web/renderers 
Web用のアプリを実行および構築する場合、2つの異なるレンダラーから選択できます。このページでは、両方のレンダラーと、ニーズに最適なレンダラーを選択する方法について説明します。2つのレンダラーは次のとおりです。

HTMLレンダラー
HTML要素、CSS、Canvas要素、およびSVG要素の組み合わせを使用します。このレンダラーのダウンロードサイズは小さくなっています。
CanvasKitレンダラー
このレンダラーは、Flutterモバイルおよびデスクトップと完全に整合性があり、ウィジェット密度が高く、パフォーマンスが高速ですが、ダウンロードサイズが約2MB追加されます。  

1. デフォルトのレンダラーオプション（auto）を使用してChromeで実行します。
`flutter run -d chrome`
2. デフォルトの（自動）オプションを使用して、リリースモードでアプリをビルドします。
`flutter build web --release`
3. CanvasKitレンダラーのみを使用して、リリースモードでアプリをビルドします。
`flutter build web --web-renderer canvaskit --release`
4. HTMLレンダラーを使用して、プロファイルモードでアプリを実行します。 
`flutter run -d chrome --web-renderer html --profile`

# HTMLレンダラーを指定する 
`flutter run -d chrome --web-renderer html`
`flutter build web --release --web-renderer html`

1. FlutterWebは別のドメインからネットワークイメージを読み込めません
https://stackoverflow.com/questions/65653801/flutter-web-cant-load-network-image-from-another-domain  

2. CanvasKitのレンダリング方法だと、読み込み時に日本語が豆腐（□）になることを回避。

# 他のドメインまたはFirebaseStorageの画像をFlutterWebページに表示できるようにするには、CORS用にデータを構成する必要があります。
https://stackoverflow.com/questions/65653801/flutter-web-cant-load-network-image-from-another-domain 
  
# FlutterでFirebase Storageから画像を落として表示するまで 
https://qiita.com/sh-tatsuno/items/6ea1ce0b7e8e4fb36bca  

```
Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 8,
      spacing: 8,
      children: selectedActivity.actual.ridePhotos
          .map((photoUrl) => Image(
              image: CachedNetworkImageProvider(photoUrl.toString())))
          .toList(), 
    ),
```
# CachedNetworkImage
https://pub.dev/packages/cached_network_image
```
children: widget.selectedActivity.actual.ridePhotos
          .map(
            (photoUrl) => CachedNetworkImage(
              imageUrl: photoUrl.toString(),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.image),
            ),
          )
          .toList(),
```
imageUrlは、firebase strageのダウンロードURL 

# flutter_native_splashでスプラッシュ画面(Splash Screen)を実装する
https://qiita.com/kokogento/items/12c44b6350ed8056c97e


1.main.dart編集
`main.dart`
```
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
//splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//--------splash

  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(), child: const MyApp()));
  //
  //splash
  FlutterNativeSplash.remove();
  //--------splash 
}
```
2. pubspec.yaml編集
`pubspec.yaml`
```
flutter_native_splash:
 color: "#42a5f5"
 android_12:
```

3.コマンドを実行
`flutter pub get`
```
Running "flutter pub get" in parking_lot_ver1...                    3.3s
```
`flutter pub run flutter_native_splash:create`
```
[Android] Updating launch background(s) with splash image path...
[Android]  - android/app/src/main/res/drawable/launch_background.xml
[Android]  - android/app/src/main/res/drawable-v21/launch_background.xml
[Android] Updating styles...
[Android]  - android/app/src/main/res/values/styles.xml
[iOS] Updating ios/Runner/Info.plist for status bar hidden/visible
[Web] Creating background images
[Web] Creating CSS
[Web] Updating index.html
╔════════════════════════════════════════════════════════════════════════════╗
║                                 WHAT IS NEW:                               ║
║ You can now keep the splash screen up while your app initializes!          ║
║ No need for a secondary splash screen anymore. Just use the remove()       ║
║ method to remove the splash screen after your initialization is complete.  ║
║ Check the docs for more info.                                              ║
╚════════════════════════════════════════════════════════════════════════════╝

✅ Native splash complete.
Now go finish building something awesome! 💪 You rock! 🤘🤩
Like the package? Please give it a 👍 here: https://pub.dev/packages/flutter_native_splash

```





# Flutter Web にスプラッシュ スクリーンを追加する 
https://medium.com/flutter-community/adding-a-splash-screen-to-flutter-web-7930e5e44bd  
`web/img/h-logo.svg`
`web/index.html`
```
<!DOCTYPE html>
<html>
<head>
 <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
  <img src="img/h-logo.svg" width="100" height="100" class="center" />
  <script>
  </script>
</body>
</html>
```
`web/styles.css`
```
body{
    margin:0;
    padding:0;
    width:100%;
    height:100%;
    overflow: hidden;
    background-color: #e8f5e9;
}
/* .center{
    margin:0;
    position:absolute;
    top: 50%;
    left:50%;
    margin-right: -50%;
    transform:translate(-50%, -50%); 
} */
.center{
    position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        margin: auto;
        width: 150px;
        height: 150px;
}

```
# Columnの中でListView.builderを表示する方法
https://rayt-log.com/%E3%80%90flutter%E3%80%91column%E3%81%AE%E4%B8%AD%E3%81%A7listview-builder%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95/  

Columnの中でListview,SingleChildScrollViewを使う場合  
1. ListView  
  ExpandedでラップしてshrinkWrap:trueを付ける。  
``
Column(
  childred: Expanded(
    child:ListView(
      shrinkWrap:true,
      children: < Widget >[
        Text('aaa'),
        ...
        Txet('zzz'),
      ]
    )
  )
)
``
2. SingleChildScrollView  
```
Column(
  children: LayoutBuilder(
    builder: (BuildContext context, BoxConstrains viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrannedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('aaa'),
            ...
            Txet('zzz'),
          ]
        )
        )
      )
    }
  )
)
```



# ImageオブジェクトをImageProviderにフラッターします 
https://stackoverflow.com/questions/58870443/flutter-image-object-to-imageprovider
```
Container(
  decoration: BoxDecoration(
    color: Colors.green,
    image: DecorationImage(
      image: img // <-- Expecting ImageProvider
    )
)
```
1. イメージピッカー(image_picker_web.dart)を使って画像をダウンロード
```
final _pickedImages = <Image>[];
  // final _pickedVideos = <dynamic>[];
  String _imageInfo = '';
  Future<void> _pickImage() async {
    final fromPicker = await ImagePickerWeb.getImageAsWidget();
    if (fromPicker != null) {
      setState(() {
        _pickedImages.clear();
        _pickedImages.add(fromPicker);
        print(fromPicker);
      });
    }
  }
```
2. _pickedImagesには、MemoryImageが保存される
`[Image(image: MemoryImage(Uint8List#1c3c8, scale: 1), frameBuilder: null, loadingBuilder: null, alignment: Alignment.center, this.excludeFromSemantics: false, filterQuality: low), Image(image:`
3. 画像をコンテナ(CircleAvater)の背景として配置したいが、backgroundImageはImageProviderのみを受け入れますので、ImageMemoryをImageProviderに変換します。imgをimg.imageに変更します。（ImageProviderを呼び出変換します。）

```
 _pickedImages
    .map(
        (img) => CircleAvatar(
        // backgroundImage: NetworkImage('$img'),
        // backgroundImage: NetworkImage('$img'),
        backgroundImage: img.image,// <-- Expecting ImageProvider
        minRadius: 50,
        maxRadius: 50,
        // child: img,
        ),
    )
    .toList(),
```
4. 参考：画像を指定するさまざまな方法のために、いくつかのコンストラクターが提供されています。 
https://api.flutter.dev/flutter/widgets/Image-class.html 


- Image.new、ImageProviderから画像を取得するため。
- Image.asset 、キーを使用してAssetBundleから画像を取得し ます。
- Image.network、URLから画像を取得します。
- Image.file、ファイルから画像を取得するため。
- Image.memory、Uint8Listから画像を取得します。
次の画像形式がサポートされています：JPEG、PNG、GIF、アニメーションGIF、WebP、アニメーションWebP、BMP、およびWBMP。追加のフォーマットは、基盤となるプラットフォームでサポートされる場合があります。FlutterはプラットフォームAPIを呼び出して認識されない形式をデコードしようとします。プラットフォームAPIが画像のデコードをサポートしている場合、Flutterは画像をレンダリングできます。






# CustomScrollView の SliverToBoxAdapter 内でコンテナーの幅が機能しない
参考にした記事
https://stackoverflow.com/questions/72723801/how-to-set-width-on-flutter-slivergrid
https://stackoverflow.com/questions/74246341/width-of-container-is-not-working-inside-slivertoboxadapter-in-customscrollview

問題点　
1. コンテナに対する最大幅の制約が SliverToBoxAdapter で完全に無視されます。
2. SliverToBoxAdapterのコンテナは、使用可能な画面の全幅まで拡大されます。
3. SliverToBoxAdapterのコンテナは、ConstrainedBox の maxWidth プロパティを無視します。
4. 

対策　
1. SliverToBoxAdapter を SliverPadding でラップし、水平方向の幅を設定します。
```
 return Scaffold(
     
      body: CustomScrollView(
        SliverPadding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width >= 600
                  ? (MediaQuery.of(context).size.width - 600) / 2
                  : 8),
          sliver: SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 16),
              elevation: 8,
              child: ListTile(
                leading: const Icon(
                  Icons.grid_view,
                ),
                title: const Text('レイアウト詳細を表示'),
                trailing: IconButton(
                  tooltip: 'レイアウト詳細を表示',
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/arrangement');
                  },
                ),
              ),
            ),
          ),
        ),
      ));
```
2. SliverToBoxAdapterで、Alignウィジェットでコンテナをラップする必要します。
```
return Scaffold(
     
      body: CustomScrollView(
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width >=
                        600
                    ? (MediaQuery.of(context).size.width - 600) /
                        2
                    : 8),
            child: Align(
              alignment: Alignment.center,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 16),
                elevation: 8,
                child: ListTile(
                  leading: const Icon(
                    // Icons.settings,
                    Icons.person,
                  ),
                  title: const Text('契約者情報を表示'),
                  // trailing: Icon(Icons.arrow_forward),
                  trailing: IconButton(
                    tooltip: 'レイアウト詳細を表示',
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/contractor_list');
                    },
                  ),
                ),
              ),
            )))              
      ));
```