<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Book My Slot</title>
    <link
    href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap"
    rel="stylesheet"
    />
    <link rel="stylesheet" href="./SCSS/index1.css">
  </head>
  <body>
  <div class="container">
    <%@ include file="navbar.jsp" %>
      <section class="hero">
        <div class="hero-text">
          <h1>Electric Car Charging</h1>
          <pre>Welcome to the Book My Slot

Your One-Stop Charging Solution

<b>Enter The Location </b>
</pre>
          <form method="post" action="result.jsp">
            <input
              type="text"
              id="location-input"
              class="search"
              name="search"
              placeholder="Enter your location"
            />

            <div class="buttons">
              <button class="button" type="submit">
                Search
              </button>
            </div>
          </form>
        </div>
        <div class="hero-image">
          <img src="./images/logo.png" alt="Electric Car Charging" />
        </div>
      </section>
    </div>
  </body>
</html>
