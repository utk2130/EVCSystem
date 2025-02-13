<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EV Charging Bunker Near You</title>
    <link rel="stylesheet" href="homepage.css">
</head>

<body >
    <div class="nav">
        <nav class="navbar" style="background-color: bisque;
    text-align: end;
    height: 40px;
    width: auto;
    position: relative;">
         <ul class="items" style="display: inline-flex;
    top:10px;
    margin-left:20px; ">
                
            <li style="margin-right: 20px; list-style-type: none;">
                <a href="userlogin.jsp" style="text-decoration: none">Login</a>
            </li>
             <li style="margin-right: 20px;    list-style-type: none;">
                <a href="adminlogin.jsp" style="text-decoration: none">Admin</a>
            </li>
            <li style="margin-right: 20px;    list-style-type: none;">
                <a href="userlogout.jsp" style="text-decoration: none">Logout</a>
            </li>
         </ul>
        </nav>
    </div>
    <div class="image">
    <header style="margin-left: 350px;">
        <h1>Welcome to the EV Charging Bunker</h1>
        <p style="padding-left: 150PX;">Your One-Stop Charging Solution</p>
    </header>
    
   

    <main class="background">
        
        <section id="charging-stations">
            <h1 style="font-size: 100px;">Find the Nearest Charging Station</h1>
            
            
            <form action="result.jsp" method="post" id="location-form" class="searchbar">
                <p style="color:rgb(230, 232, 250) ;font-size: 40px;">Enter your location or select from recent locations:</p>
                <input type="text" id="location-input" class="search" name="search" placeholder="Enter your location">
                <button type="submit" class="sbutton">Search</button>
            </form>

            <div id="charging-results">
                <!-- Charging station search results will be displayed here -->
            </div>
        </section>
    
    </main>


    <!-- -->
</div>
</body>
</html>





