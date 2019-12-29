<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
  String selectedLanguage = "en";
  // Read Seam locale cookie
  String localeCookieName = "org.jboss.seam.core.Locale";
  Cookie localeCookie = null;
  Cookie cookies[] = request.getCookies();
  if (cookies != null) {
    for (Cookie cooky : cookies) {
      if (localeCookieName.equals(cooky.getName())) {
        localeCookie = cooky;
        break;
      }
    }
  }
  if (localeCookie != null) {
    selectedLanguage = localeCookie.getValue();
  }
%>
<html>
<fmt:setLocale value="<%= selectedLanguage %>"/>
<fmt:setBundle basename="messages" var="messages"/>
<head>
  <title>Nuxeo Spreadsheet</title>
  <link rel="stylesheet" href="styles/vendor.css">
  <link rel="stylesheet" href="styles/style.css">
  <script src="scripts/vendor.js"></script>
</head>
<body>
  <div id="header">
    <fmt:message bundle="${messages}" key="title.spreadsheet" />
  </div>

  <div id="queryArea" style="display:none">
    <input id="query" type="text" placeholder="SELECT * FROM Document" />
    <button id="execute" class="button"><fmt:message bundle="${messages}" key="command.execute" /></button>
  </div>

  <div id="grid"></div>

  <div class="buttonsGadget">
    <label><input type="checkbox" name="autosave" autocomplete="off"><fmt:message bundle="${messages}" key="label.spreadsheet.autoSave" /></label>
    <div style="display:inline-block;width:16px">
        <img id="loading" style="display:none" src="images/ajax-loader.gif">
    </div>
    <button id="save"><fmt:message bundle="${messages}" key="command.save" /></button>
    <button id="close" style="display:none"><fmt:message bundle="${messages}" key="command.close" /></button>
    <div id="console" class="console"></div>
  </div>
  <script>register(System);</script>
  <script src="scripts/app.js"></script>
  <script>
    var nuxeo = nuxeo || {};
    nuxeo.spreadsheet = {
      language: '<%= selectedLanguage %>',
      labels: {
        "saving": "<fmt:message bundle="${messages}" key="message.spreadsheet.saving" />",
        "failedSave": "<fmt:message bundle="${messages}" key="message.spreadsheet.failedSave" />",
        "upToDate": "<fmt:message bundle="${messages}" key="message.spreadsheet.upToDate" />",
        "rowsSaved": "<fmt:message bundle="${messages}" key="message.spreadsheet.rowsSaved" />",
        "autoSave": "<fmt:message bundle="${messages}" key="message.spreadsheet.autoSave" />"
      }
    };
    var contextPath = '<%= request.getContextPath() %>';
    System.import('app')
      .then(function(app) { return app.run(contextPath); })
      .then(function() { window.nuxeoSpreadsheetReady = true; })
      .catch(console.error.bind(console));
  </script>
</body>
</html>
