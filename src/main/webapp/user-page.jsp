<!--
Copyright 2019 Google Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<% BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
String uploadUrl = blobstoreService.createUploadUrl("/messages"); %>

<!DOCTYPE html>
<html>
<head>
  <title>User Page</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="/css/main.css">
  <link rel="stylesheet" href="/css/user-page.css">
  <script src="/js/user-page-loader.js"></script>
  <script src="https://cdn.ckeditor.com/ckeditor5/11.2.0/classic/ckeditor.js"></script>
</head>
<body onload="buildUI();">
<nav>
  <ul id="navigation">
    <li><a href="/">Home</a></li>
    <li><a href="/aboutus.html">About Our Team</a></li>
  </ul>
</nav>
<h1 id="page-title">User Page</h1>

<div id="about-me-container">Loading...</div>
<div id="about-me-form" class="hidden">
  <form action="/about" method="POST">
    <textarea name="about-me" placeholder="about me" rows=4 required></textarea>
    <br/>
    <input type="submit" value="Submit">
  </form>
</div>
<br/><br/><br/><br/><br/>

<form id="message-form" action="<%= uploadUrl %>" method="POST" class="hidden" enctype="multipart/form-data">
  Enter a new message:
  <br/>
  <textarea name="text" id="message-input" placeholder="text here"></textarea>
  <br/>
  <br/>Upload an image:<br/>
  <br/>
  <input type="file" name="image" />
  <br/><br/>
  <input type="submit" value="Submit">
  <br/>
  <script>
    const config = {removePlugins: [ 'Heading', 'List', 'ImageUpload']};
    ClassicEditor.create(document.getElementById('message-input'), config)
  </script>
</form>
<hr/>

<div id="message-container">Loading...</div>
</body>
</html>
