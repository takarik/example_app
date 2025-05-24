require "takarik"

class SessionController < Takarik::BaseController
  actions :login, :logout, :dashboard, :login_form

  def login_form
    render content_type: "text/html", plain: <<-HTML
    <!DOCTYPE html>
    <html>
    <head>
      <title>Login</title>
      <style>
        body { font-family: Arial, sans-serif; max-width: 400px; margin: 50px auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        button { background: #007cba; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }
        .flash { padding: 10px; margin-bottom: 15px; border-radius: 4px; }
        .flash.notice { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .flash.alert { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
      </style>
    </head>
    <body>
      <h1>Login</h1>
      #{flash_messages}
      <form method="POST" action="/login">
        <div class="form-group">
          <label for="username">Username:</label>
          <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
          <label for="password">Password:</label>
          <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Login</button>
      </form>
      <p><a href="/dashboard">Go to Dashboard</a></p>
    </body>
    </html>
    HTML
  end

  def login
    username = params["username"]?.try(&.as_s?) || ""
    password = params["password"]?.try(&.as_s?) || ""

    # Simple authentication (in real app, check against database)
    if username == "admin" && password == "secret"
      session["user_id"] = "1"
      session["username"] = username
      session["logged_in_at"] = Time.utc.to_s

      flash.notice = "Successfully logged in!"
      response.status = :found
      response.headers["Location"] = "/dashboard"
    else
      flash.alert = "Invalid username or password"
      response.status = :found
      response.headers["Location"] = "/login"
    end
  end

  def logout
    session.destroy
    flash.notice = "Successfully logged out!"
    response.status = :found
    response.headers["Location"] = "/login"
  end

  def dashboard
    unless session["user_id"]
      flash.alert = "Please log in to access the dashboard"
      response.status = :found
      response.headers["Location"] = "/login"
      return
    end

    username = session["username"].try(&.as_s?) || "Unknown"
    logged_in_at = session["logged_in_at"].try(&.as_s?) || "Unknown"

    render content_type: "text/html", plain: <<-HTML
    <!DOCTYPE html>
    <html>
    <head>
      <title>Dashboard</title>
      <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }
        .user-info { background: #f8f9fa; padding: 15px; border-radius: 4px; margin-bottom: 20px; }
        .flash { padding: 10px; margin-bottom: 15px; border-radius: 4px; }
        .flash.notice { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .flash.alert { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .actions { margin-top: 20px; }
        .actions a { display: inline-block; margin-right: 10px; padding: 8px 16px; background: #007cba; color: white; text-decoration: none; border-radius: 4px; }
      </style>
    </head>
    <body>
      <h1>Dashboard</h1>
      #{flash_messages}
      <div class="user-info">
        <h3>User Information</h3>
        <p><strong>Username:</strong> #{username}</p>
        <p><strong>Logged in at:</strong> #{logged_in_at}</p>
        <p><strong>Session ID:</strong> #{session.id[0..8]}...</p>
      </div>

      <h3>Session Data</h3>
      <ul>
      #{session.keys.map { |key| "<li><strong>#{key}:</strong> #{session[key]}</li>" }.join("\n")}
      </ul>

      <div class="actions">
        <a href="/logout">Logout</a>
        <a href="/login">Login Page</a>
      </div>
    </body>
    </html>
    HTML
  end

  private def flash_messages
    messages = [] of String

    if notice = flash.notice
      messages << %(<div class="flash notice">#{notice}</div>)
    end

    if alert = flash.alert
      messages << %(<div class="flash alert">#{alert}</div>)
    end

    if error = flash.error
      messages << %(<div class="flash alert">#{error}</div>)
    end

    messages.join("\n")
  end
end