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
<%@ page import="com.google.codeu.data.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.common.flogger.FluentLogger" %>
<% BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    String uploadUrl = blobstoreService.createUploadUrl("/messages");
    List<Message> messages = (List<Message>) request.getAttribute("messages"); %>

<!DOCTYPE html>
<html>
    <head>
        <title><%=request.getAttribute("user")%></title>
        <meta charset="UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/user-page.css" rel="stylesheet">
        <script src="https://cdn.ckeditor.com/ckeditor5/12.2.0/classic/ckeditor.js"></script>
    </head>
    <body>
        <nav>
            <ul id="navigation">
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/aboutus.html">About Our Team</a></li>
                <li><a href="${pageContext.request.contextPath}/stats.html">Stats</a></li>
                <li><a href="${pageContext.request.contextPath}/map.html">Map</a></li>
                <li><a href="${pageContext.request.contextPath}/feed.html">Message Feed</a></li>

                <li class="right"><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                <li class="right"><a href="${pageContext.request.contextPath}/setting.html">Setting</a></li>
                <li class="right"><a href="${pageContext.request.contextPath}/users/<%=request.getAttribute("user")%>">Your Page</a></li>
            </ul>
        </nav>
        <div class="jumbotron text-center">
            <h1 id="page-title"><%=request.getAttribute("displayedName")%></h1>
        </div>
        <div id="about-me-container" class="form-group text-center">
            <%=request.getAttribute("about")%>
        </div>

        <div class="container-fluid">
            <hr/>

            <div class="form-group">
                <form id="about-me-form" action="/about" method="POST">
                    <textarea id="about-me-input" name="about-me" placeholder="Enter new 'About me' text" class="form-control" rows=4
                              required></textarea>
                    <br/>
                    <input type="submit" value="Update" class="btn btn-primary">
                </form>
            </div>

            <hr/>

            <div class="form-group">
                <form id="message-form" action="<%= uploadUrl %>" method="POST" enctype="multipart/form-data">
                    <textarea name="text" id="message-input" class="form-control"></textarea>
                    <br/>
                    Upload meme:
                    <input type="file" name="image" style="margin-left: 15px"/>
                    <br/>
                    <br/>
                    <input type="submit" value="Upload" class="btn btn-primary">
                    <script>
                        const config = {removePlugins: ['ImageUpload'], placeholder: 'Meme title/description'};
                        ClassicEditor.create(document.getElementById('message-input'), config)
                    </script>
                </form>
            </div>

            <hr/>

            <div id="message-container">
                <%
                    if (messages.size() == 0) {
                        %>This user has no posts yet<%
                    } else {
                        for (Message message : messages) {
                        %>
                            <div class="message-div">
                                <div class="message-header"><%=message.getUser()%> - <%= new Date(message.getTimestamp())%>
                                </div>
                                <div class="message-body"><%=message.getText()%>
                                </div>
                            </div>
                            <%
                        }
                    }
                %>
            </div>
        </div>

        <script src="js/jquery-3.4.1.min.js"></script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>
