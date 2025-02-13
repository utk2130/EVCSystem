<!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Electric Vehicle Slot Booking</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
    
            form {
                max-width: 400px;
                margin: 0 auto;
            }
    
            label {
                display: block;
                margin-bottom: 8px;
            }
    
            input, select {
                width: 100%;
                padding: 8px;
                margin-bottom: 16px;
                box-sizing: border-box;
            }
    
            button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
    
            button:hover {
                background-color: #45a049;
            }
        </style>
        </head>
        <body>
                    
        <h2 style="text-align: center;">Electric Vehicle Slot Booking</h2>
                    
        <form action="book1.jsp" method="post">
            <div>
                <label for="vname">Vehicle Name:</label>
                <input type="text" name="vname" placeholder="Please Enter Vehicle Name" required>
                <label for="vnum">Vehicle Number:</label>
                <input type="text" name="vnum" placeholder="Please Enter Vehicle Number" required>
            </div>
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
                    
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
                    
            <label for="phone">Phone Number:</label>
            <input type="tel" id="phone" name="phone" required>
                    
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" required>
                    
            <label for="time">Time Slot:</label>
            <select id="time" name="time" required>
                <option value="morning">Morning (9:00 AM - 12:00 PM)</option>
                <option value="afternoon">Afternoon (12:00 PM - 3:00 PM)</option>
                <option value="evening">Evening (3:00 PM - 6:00 PM)</option>
            </select>
            <!-- <label for="slot">Select the Slot:</label>
            <button name="slot" value="Slot1" onclick="slot()">Slot1</button>
            <button name="slot" value="Slot2" onclick="slot()">Slot2</button>
            <button name="slot" value="Slot3" onclick="slot()">Slot3</button>
            <button name="slot" value="Slot4" onclick="slot()">Slot4</button><br><br> -->
            <select id="slot" name="slot" required>
                <option value="Slot1">Slot1</option>
                <option value="Slot2">Slot2</option>
                <option value="Slot3">Slot3</option>
                <option value="Slot4">Slot4</option>
            </select>       
            <button type="submit" style=";">Book Slot</button>
        </form>
                    
    </body>
</html>

