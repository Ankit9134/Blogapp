# Blogapp
Blog App 
<h4>Flutter project for a blog app where users can create and read articles they've written within the app. Here’s an overview of how you might structure and implement this project: </h4>

<p align="center">
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg" width="50"/>   
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" width="50" />
<img alt="Static Badge" src="https://img.shields.io/badge/status-em_desenvolvimento-yellow?style=for-the-badge&color=E3B505">
<img alt="Static Badge" src="https://img.shields.io/badge/plataforma-android-yellow?style=for-the-badge&color=68D89B">     
</p>
<h2>Project Structure</h2>
<h3>Login and Registration Screen:</h3>

Allow users to register and log in to access their accounts.
Use Firebase Authentication to manage user authentication.
<h3>Article List Screen:</h3>

Display a list of articles created by users.
Use a ListView to show the articles.
Connect to Firebase Firestore to fetch and display the articles.

<h3>Article Creation and Editing Screen:</h3>
Allow users to create and edit their own articles.
Use TextField for text input and ImagePicker to add images to articles.
Save articles to Firebase Firestore.

<h3>Article Viewing Screen:</h3>
Allow users to read full articles.
Display the article's title, content, and images.

<h3>User Profile:</h3>
Allow users to view and edit their profile information.

<h2>Technologies and Packages</h2>

<h3>Firebase:</h3> Use Firebase Authentication, Firestore, and Storage for authentication, data storage, and image storage.
<h3>Provider or Riverpod:</h3> Manage state.
<h3>Image Picker: Allow users to choose images for their articles.
Flutter Markdown: </h3>Render article content in markdown format.

<h2>Step-by-Step Implementation</h2>
<h3>Firebase Setup:</h3>
Set up Firebase in your Flutter project.
Enable Firebase Authentication, Firestore, and Storage.
<h3>User Interface (UI) Creation:</h3>

Create the main screens (Login, Registration, Article List, Article Creation/Editing, Article Viewing, Profile).
Use widgets like ListView, TextField, Image, RaisedButton, etc.
<h3>State Management:</h3>

Choose a state management solution (Provider or Riverpod) to maintain user and article state.
<h3>Firebase Integration:</h3>

Implement authentication logic with Firebase Authentication.
Save and fetch data from Firestore.
Upload images to Firebase Storage.
<h3>Testing and Debugging:</h3>

Test the app on different devices and screen resolutions.
Fix bugs and improve UI/UX as needed.
<h2>Project Description</h2>
AppBlog is an app that allows users to read and publish articles. Users can search for articles, authors, and other users, as well as save their favorite articles. The search feature includes filters by topic (e.g., Sports, Technology, Science, Lifestyle, Politics). In the future, the app will include an algorithm to recommend articles based on user interests.

<h3>Key Features</h3>
<h4>Create Articles:</h4> Users can write and publish their own articles.
<h4>Save Articles:</h4> Users can save articles they are interested in.
<h4>Notifications:</h4> Users receive notifications about new articles and updates.
<h4>Follow and Be Followed:</h4> Users can follow other users and be followed.
<h4>Search with Filters:</h4> Users can search for articles, users, and topics with filtering options.

<h2>Technologies and Techniques</h2>
<h4>Flutter 3.19.0</h4>
<h4>Dart 3.3.0</h4>
<h>MVVM Design Pattern</h>
<h4>Object-Oriented Programming</h4>
<h4>MOBX for State Management</h4>
