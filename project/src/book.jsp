<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electric Vehicle Slot Booking</title>
    <link href="./SCSS/book1.css" rel="stylesheet">
    <script>
        function sendTime() {
            let timeValue1 = document.getElementById("fTime").value;
            let timeValue2 = document.getElementById("tTime").value;

            if (!timeValue1 || !timeValue2 || timeValue1==null || timeValue2==null) {
                alert("Please select a valid time.");
                return;
            }

            let [h1, m1] = timeValue1.split(":").map(Number);
            let [h2, m2] = timeValue2.split(":").map(Number);

            let totalMinutes = (h2 * 60 + m2) - (h1 * 60 + m1);

            if (totalMinutes <= 0) {
                alert("Invalid time range. Please ensure 'UpTo' time is later than 'From' time.");
                return;
            }
    
            window.location.href = "book1.jsp?time=" + encodeURIComponent(totalMinutes);
        }       

    </script>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <h2>Electric Vehicle Slot Booking</h2>
    <form  action="book1.jsp" method="post">
        <label for="vname">Vehicle Name:</label>
        <input type="text" name="vname" placeholder="Please Enter Vehicle Name" required>
        
        <label for="vnum">Vehicle Number:</label>
        <input type="text" name="vnum" placeholder="Please Enter Vehicle Number" required>
        
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        
        <label for="phone">Phone Number:</label>
        <input type="tel" id="phone" name="phone" required>
        
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required>
        
        <label for="time">Time Slot:</label>
        <label for="time">From:</label>
        <input type="time" name="fTime" id="fTime" placeholder="Select the time" required>
        <label for="time">UpTo:</label>
        <input type="time" name="tTime" id="tTime" placeholder="Select the time" required>

        <label for="slot">Select Slot:</label>
        <select id="slot" name="slot" required>
            <option value="Slot1">Slot1</option>
            <option value="Slot2">Slot2</option>
            <option value="Slot3">Slot3</option>
            <option value="Slot4">Slot4</option>
        </select>

        <button type="submit " Class="button" onclick="sendTime()">Book Slot</button>
    </form>
</body>
</html>
