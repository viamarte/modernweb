#ModernWeb Core
#
#Author: Matheus R. Kautzmann
#
#Contributors:
#Just me so far :) Feel free to contribute and have your name here.
#
#Company: Via Marte
#Creation date: 08/03/2013

# This CoffeeScript file is responsible for the main logic of the widget,
# it detects HTML5 feature and passes the browser if it complies,
# on practice it will pass IE9+ or IE with Google Chrome Frame,
# other browsers should pass too. If IE8- the banner will be shown.
do (window, document) ->

  #Cookie class that will avoid people getting annoyed by
  #the banner each time they access the website.
  class Cookie

    constructor: (name, value, life) ->
      if name? then @cookieName = name
      if value? then @cookieValue = value
      if life? then @cookieLife = life

    setCookie: ->
      cookie = "#{@cookieName}=#{@cookieValue};expires=#{@cookieLife};path=/"
      document.cookie = cookie

    hasCookie: ->
      cookies = document.cookie
      #Cookie exists, return true
      return true if (cookies.indexOf "#{@cookieName}") >= 0
      #Cookie doesn't exists, return false
      return false

  #The ModernWeb class, that holds the banner itself,
  #it will reccomend use of modern browsers to old browser users.
  #Such as IE6, IE7, IE8, old firefox distributions, etc.
  class ModernWeb
    cookieClass = new Cookie "Modern-Web-Banner", "",
    new Date(new Date().getTime()+864000000).toGMTString()

    @USER_LANGUAGE: (window.navigator.language ||
    window.navigator.systemLanguage || 'en')

    #Browser icon URLs
    @CHROME_ICON =
    "https://s3-sa-east-1.amazonaws.com/modernweb/icons/chrome_icon.jpg"

    @FIREFOX_ICON =
    "https://s3-sa-east-1.amazonaws.com/modernweb/icons/firefox_icon.jpg"

    @SAFARI_ICON =
    "https://s3-sa-east-1.amazonaws.com/modernweb/icons/safari_icon.jpg"

    @OPERA_ICON =
    "https://s3-sa-east-1.amazonaws.com/modernweb/icons/opera_icon.jpg"

    #Browser download pages
    @CHROME_DOWNLOAD = "https://www.google.com/intl/pt-BR/chrome/browser/"
    @FIREFOX_DOWNLOAD = "https://www.mozilla.org/pt-BR/firefox/new/"
    @SAFARI_DOWNLOAD = "https://www.apple.com/br/safari/"

    #Shortening here because it lacks HTTPS support, :(
    @OPERA_DOWNLOAD = "https://bit.ly/4iRJjb"
    @IE_DOWNLOAD = "https://bit.ly/XsKM6H"

    #Localization object, here are the project strings in different languages.
    locales =
      "pt":
        "title": "Seu navegador está desatualizado"
        "text": "Seu navegador está desatualizado, para visualizar melhor " +
        "atualize o seu navegador, aconselhamos as seguintes opções:"
        "ietext": "Se você apenas deseja atualizar o Internet Explorer " +
        "clique aqui"
        "close": "Fechar"
      "en":
        "title": "Your browser is outdated"
        "text": "Your browser is outdated, to improve your experience in " +
        "the web please update your browser, we suggest these great options:"
        "ietext": "If you just want to update Internet Explorer click here"
        "close": "Dismiss"
      "es":
        "title": "Su navegador no está actualizado"
        "text": "Su navegador no está actualizado, para mejorar su " +
        "experiencia en la web, por favor actualice su navegador, " +
        "le sugerimos estas grandes opciones:"
        "ietext": "Si lo que desea es actualizar Internet Explorer, " +
        " haga clic aquí"
        "close": "Cerrar"

    #Avoiding multiple instantiations
    @instantiated: false

    constructor: ->
      if !@html5Compatible() and !cookieClass.hasCookie()
        @displayBanner()

    # We use canvas detection here to determine, we use this because it
    # can detects IE8- browsers but will pass in Google Chrome Frame.
    # If you need a focused aproach we recommend the use of Modernizr
    # triggering ModernWeb display widget method.
    html5Compatible: ->
      supportHtml5 = !!document.createElement('canvas').getContext

      return true if supportHtml5

      return false

    getLocale = =>
      localeStrings = null
      for key, value of locales
        if (@USER_LANGUAGE.indexOf key) >= 0
          localeStrings = value
      return localeStrings

    buildBanner = =>

      localeStrings = getLocale()

      if !localeStrings? then localeStrings = locales.en

      #Building CSS inline to reduce HTTP requests and external dependencies
      cssStyle =
      "#ModernWeb-wrapper{width:100%;" +
      "display:none;position:absolute;top:0;left:0;z-index:999999;" +
      "font-family:'Verdana','Helvetica','sans-serif';background-color:#FFF;" +
      "border-bottom:2px solid #0066FF;}" +
      ".ModernWeb-link{text-decoration:underline;color:#0066FF;}" +
      "#ModernWeb-h1{margin:20px;font-size:1.2em;color:#333;}" +
      "#ModernWeb-p{margin:20px;font-size:1em;color:#333;}" +
      "#ModernWeb-browsers{width:632px;margin:25px auto;}" +
      ".ModernWeb-noborder{border:0;}" +
      "#ModernWeb-ietext{margin:15px 0;font-size:1em;text-align:center;}" +
      "#ModernWeb-close{position:absolute;top:20px;right:20px;}"

      styleTag = document.createElement 'style'
      styleTag.type = "text/css"

      #IE odd behavior:
      #http://bit.ly/YXXjhg
      if styleTag.styleSheet #IE
        styleTag.styleSheet.cssText = cssStyle
      else
        styleTag.appendChild document.createTextNode(cssStyle)

      document.getElementsByTagName('head')[0].appendChild styleTag

      html =
      "<h1 id='ModernWeb-h1'>#{localeStrings.title}</h1>" +
      "<p id='ModernWeb-p'>#{localeStrings.text}</p>" +
      "<div id='ModernWeb-browsers'>" +
      "<a href='#{@CHROME_DOWNLOAD}'><img class='ModernWeb-browser-option " +
      "ModernWeb-noborder' src='#{@CHROME_ICON}' /></a>" +
      "<a href='#{@FIREFOX_DOWNLOAD}'><img class='ModernWeb-browser-option " +
      "ModernWeb-noborder' src='#{@FIREFOX_ICON}' /></a>" +
      "<a href='#{@SAFARI_DOWNLOAD}'><img class='ModernWeb-browser-option " +
      "ModernWeb-noborder' src='#{@SAFARI_ICON}' /></a>" +
      "<a href='#{@OPERA_DOWNLOAD}'><img class='ModernWeb-browser-option " +
      "ModernWeb-noborder' src='#{@OPERA_ICON}' /></a>" +
      "</div>" +
      "<a class='ModernWeb-link' href='#{@IE_DOWNLOAD}'>" +
      "<p id='ModernWeb-ietext'>#{localeStrings.ietext}</p></a>" +
      "<a id='ModernWeb-close' class='ModernWeb-link' href='#'>" +
      "#{localeStrings.close}</a>"

      htmlTag = document.createElement 'div'
      htmlTag.id = "ModernWeb-wrapper"
      htmlTag.innerHTML = html

      document.body.insertBefore htmlTag, document.body.firstChild

      #Create link to close banner and set cookie
      document.getElementById('ModernWeb-close').onclick = ->
        cookieClass.setCookie()
        document.getElementById('ModernWeb-wrapper').style.display = 'none'
      
    #This displays the banner and avoid the banner to be displayed twice.
    displayBanner: ->
      if !@instantiated
        buildBanner()
      document.getElementById('ModernWeb-wrapper').style.display = 'block'
      @instantiated = true


  window.ModernWeb = new ModernWeb()