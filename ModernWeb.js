(function(window, document) {
  var Cookie, ModernWeb;
  Cookie = (function() {
    function Cookie(name, value, life) {
      if (name != null) {
        this.cookieName = name;
      }
      if (value != null) {
        this.cookieValue = value;
      }
      if (life != null) {
        this.cookieLife = life;
      }
    }

    Cookie.prototype.setCookie = function() {
      var cookie;
      cookie = "" + this.cookieName + "=" + this.cookieValue + ";expires=" + this.cookieLife + ";path=/";
      return document.cookie = cookie;
    };

    Cookie.prototype.hasCookie = function() {
      var cookies;
      cookies = document.cookie;
      if ((cookies.indexOf("" + this.cookieName)) >= 0) {
        return true;
      }
      return false;
    };

    return Cookie;

  })();
  ModernWeb = (function() {
    var buildBanner, cookieClass, getLocale, locales,
      _this = this;

    cookieClass = new Cookie("Modern-Web-Banner", "", new Date(new Date().getTime() + 864000000).toGMTString());

    ModernWeb.USER_LANGUAGE = window.navigator.language || window.navigator.systemLanguage || 'en';

    ModernWeb.CHROME_ICON = "https://s3-sa-east-1.amazonaws.com/modernweb/icons/chrome_icon.jpg";

    ModernWeb.FIREFOX_ICON = "https://s3-sa-east-1.amazonaws.com/modernweb/icons/firefox_icon.jpg";

    ModernWeb.SAFARI_ICON = "https://s3-sa-east-1.amazonaws.com/modernweb/icons/safari_icon.jpg";

    ModernWeb.OPERA_ICON = "https://s3-sa-east-1.amazonaws.com/modernweb/icons/opera_icon.jpg";

    ModernWeb.CHROME_DOWNLOAD = "https://google.com/chrome";

    ModernWeb.FIREFOX_DOWNLOAD = "https://mozilla.com/firefox";

    ModernWeb.SAFARI_DOWNLOAD = "https://www.apple.com/safari";

    ModernWeb.OPERA_DOWNLOAD = "https://bit.ly/4iRJjb";

    ModernWeb.IE_DOWNLOAD = "https://bit.ly/XsKM6H";

    locales = {
      "pt": {
        "title": "Seu navegador está desatualizado",
        "text": "Seu navegador está desatualizado, para visualizar melhor " + "atualize o seu navegador, aconselhamos as seguintes opções:",
        "ietext": "Se você apenas deseja atualizar o Internet Explorer " + "clique aqui",
        "close": "Fechar"
      },
      "en": {
        "title": "Your browser is outdated",
        "text": "Your browser is outdated, to improve your experience in " + "the web please update your browser, we suggest these great options:",
        "ietext": "If you just want to update Internet Explorer click here",
        "close": "Dismiss"
      },
      "fr": {
        "title": "Votre navigateur est obsolète",
        "text": "Votre navigateur est obsolète, pour améliorer votre " + "navigation sur le web mettez-le à jour. Nous recommandons ces " + "alternatives :",
        "ietext": "Si vous voulez juste mettre à jour Internet Explorer " + "cliquez ici",
        "close": "Masquer ce message"
      },
      "es": {
        "title": "Su navegador no está actualizado",
        "text": "Su navegador no está actualizado, para mejorar su " + "experiencia en la web, por favor actualice su navegador, " + "le sugerimos estas grandes opciones:",
        "ietext": "Si lo que desea es actualizar Internet Explorer, " + " haga clic aquí",
        "close": "Cerrar"
      },
      "de": {
        "title": "Ihr Browser ist veraltet",
        "text": "Ihr Browser ist veraltet. Sie könnten das Web noch besser " + "erleben, wenn Sie einen dieser modernen Browser installieren würden:",
        "ietext": "Hier klicken, wenn Sie nur Ihren Internet Explorer" + " aktualisieren wollen",
        "close": "Schließen"
      },
      "it": {
        "title": "Il tuo browser non è aggiornato",
        "text": "Il tuo browser non è aggiornato, per migliorare la tua " + "esperienza sul web per favore aggiornalo, " + "ti suggeriamo queste ottime opzioni:",
        "ietext": "Se vuoi solamente aggiornare Internet Explorer clicca qui",
        "close": "Chiudi"
      }
    };

    ModernWeb.instantiated = false;

    function ModernWeb() {
      if (!this.html5Compatible() && !cookieClass.hasCookie()) {
        this.displayBanner();
      }
    }

    ModernWeb.prototype.html5Compatible = function() {
      var supportHtml5;
      supportHtml5 = !!document.createElement('canvas').getContext;
      if (supportHtml5) {
        return true;
      }
      return false;
    };

    getLocale = function() {
      var key, localeStrings, value;
      localeStrings = null;
      for (key in locales) {
        value = locales[key];
        if ((ModernWeb.USER_LANGUAGE.indexOf(key)) >= 0) {
          localeStrings = value;
        }
      }
      return localeStrings;
    };

    buildBanner = function() {
      var cssStyle, html, htmlTag, localeStrings, styleTag;
      localeStrings = getLocale();
      if (localeStrings == null) {
        localeStrings = locales.en;
      }
      cssStyle = "#ModernWeb-wrapper{width:100%;" + "display:none;position:absolute;top:0;left:0;z-index:999999;" + "font-family:'Verdana','Helvetica','sans-serif';background-color:#FFF;" + "border-bottom:2px solid #0066FF;}" + ".ModernWeb-link{text-decoration:underline;color:#0066FF;}" + "#ModernWeb-h1{margin:20px;font-size:1.2em;color:#333;}" + "#ModernWeb-p{margin:20px;font-size:1em;color:#333;}" + "#ModernWeb-browsers{width:632px;margin:25px auto;}" + ".ModernWeb-noborder{border:0;}" + "#ModernWeb-ietext{margin:15px 0;font-size:1em;text-align:center;}" + "#ModernWeb-close{position:absolute;top:20px;right:20px;}" + ".ModernWeb-browser-option{display:inline;}";
      styleTag = document.createElement('style');
      styleTag.type = "text/css";
      if (styleTag.styleSheet) {
        styleTag.styleSheet.cssText = cssStyle;
      } else {
        styleTag.appendChild(document.createTextNode(cssStyle));
      }
      document.getElementsByTagName('head')[0].appendChild(styleTag);
      html = ("<h1 id='ModernWeb-h1'>" + localeStrings.title + "</h1>") + ("<p id='ModernWeb-p'>" + localeStrings.text + "</p>") + "<div id='ModernWeb-browsers'>" + ("<a href='" + ModernWeb.CHROME_DOWNLOAD + "'><img class='ModernWeb-browser-option ") + ("ModernWeb-noborder' src='" + ModernWeb.CHROME_ICON + "' /></a>") + ("<a href='" + ModernWeb.FIREFOX_DOWNLOAD + "'><img class='ModernWeb-browser-option ") + ("ModernWeb-noborder' src='" + ModernWeb.FIREFOX_ICON + "' /></a>") + ("<a href='" + ModernWeb.SAFARI_DOWNLOAD + "'><img class='ModernWeb-browser-option ") + ("ModernWeb-noborder' src='" + ModernWeb.SAFARI_ICON + "' /></a>") + ("<a href='" + ModernWeb.OPERA_DOWNLOAD + "'><img class='ModernWeb-browser-option ") + ("ModernWeb-noborder' src='" + ModernWeb.OPERA_ICON + "' /></a>") + "</div>" + ("<a class='ModernWeb-link' href='" + ModernWeb.IE_DOWNLOAD + "'>") + ("<p id='ModernWeb-ietext'>" + localeStrings.ietext + "</p></a>") + "<a id='ModernWeb-close' class='ModernWeb-link' href='#'>" + ("" + localeStrings.close + "</a>");
      htmlTag = document.createElement('div');
      htmlTag.id = "ModernWeb-wrapper";
      htmlTag.innerHTML = html;
      document.body.insertBefore(htmlTag, document.body.firstChild);
      return document.getElementById('ModernWeb-close').onclick = function() {
        cookieClass.setCookie();
        return document.getElementById('ModernWeb-wrapper').style.display = 'none';
      };
    };

    ModernWeb.prototype.displayBanner = function() {
      if (!this.instantiated) {
        buildBanner();
      }
      document.getElementById('ModernWeb-wrapper').style.display = 'block';
      return this.instantiated = true;
    };

    return ModernWeb;

  }).call(this);
  return window.ModernWeb = new ModernWeb();
})(window, document);
