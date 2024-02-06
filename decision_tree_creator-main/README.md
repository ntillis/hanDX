# decision_tree_creator

A small decision tree creator flutter web app. This was created using the AU 2021 team's code and transforming it into a separate web application. It consists of a login page (which only allows admins to access to "create" button), and a page with a "create" button to populate the "decisionTree" collection in Firestore with hard-coded decision trees with sample data. It is only to be used if the "decisionTree" collection needs to be reset, and it is not recommended to use this unless strictly neccessary since there may be some chages we made to are not reflected in the hard-coded script.

## Setup

1. Open the Firebase console and select the project.
2. Create an account in the authentication tab and copy the `uid`.
3. Open the project's Cloud Firestore, and in the "ADMINS" collection, add your `uid` (**not** your email) as a document.
4. In the project directory, run `flutter pub get`.
5. In the project directory, run `flutterfire configure` and select the HandyApp project.
6. In VSCode, open `main.dart`.
7. Select the browser as the target device in VSCode.
8. Run "Start debugging".
