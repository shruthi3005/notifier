App.web_notifications = App.cable.subscriptions.create "WebNotificationsChannel",
  connected: ->
    console.log("connected to server for channel web_notifications")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    showNotification(data)
