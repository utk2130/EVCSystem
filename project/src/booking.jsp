<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<% 
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging","root","");

String getSql="SELECT * FROM bookings";
PreparedStatement ps=conn.prepareStatement(getSql);
ResultSet rs=ps.executeQuery();

// int amount=(int)session.getAttribute("price");
if(rs.next() || rs != null){
    String id = rs.getString("id");
    String vname = rs.getString("v_name");
    String vno = rs.getString("v_no");
    String name = rs.getString("name");
    String email = rs.getString("email");
    String date = rs.getString("booking_date");
    String time = rs.getString("f_time")+" To "+rs.getString("t_time");
    String mob_no = rs.getString("phone");
    String slot = rs.getString("selected_slot");
    String amount = rs.getString("amount");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Razorpay Payment</title>
</head>
<body>
  <h1>Razorpay Payment Gateway Integration</h1>
  <form id="payment-form">
    <label for="vname">Vehicle Name:</label>
    <input type="text" id="vname" name="vname" value="<%= vname %>" hidden>
    <input type="text" id="vno" name="vno" value="<%= vno %>" hidden>
    <input type="text" id="name" name="name" value="<%= name %>" hidden>
    <input type="text" id="email" name="email" value="<%= email %>" hidden>
    <input type="text" id="date" name="date" value="<%= date %>" hidden>
    <input type="text" id="time" name="time" value="<%= time %>" hidden>
    <input type="text" id="mob_no" name="mob_no" value="<%= mob_no %>" hidden>
    <input type="text" id="slot" name="slot" value="<%= slot %>" hidden>
    <label for="amount">Amount:</label>
    <input type="number" id="amount" name="amount" value="<%= amount %>" hidden>
    <button type="button" onclick="payNow()">Pay Now</button>
  </form>

  <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
  <script>
    async function payNow() {
      const amount = document.getElementById('amount').value;

      // Create order by calling the server endpoint
      const response = await fetch('/create-order', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ amount, currency: 'INR', receipt: 'receipt#1', notes: {} })
      });

      const order = await response.json();

      // Open Razorpay Checkout
      const options = {
        key: 'rzp_test_RqYqtM7HPhW5jY', // Replace with your Razorpay key_id
        amount: amount, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
        currency: 'INR',
        name: 'Acme Corp',
        description: 'Test Transaction',
        order_id: 'order_IluGWxBm9U8zJ8', // This is the order_id created in the backend
        callback_url: 'http://localhost:8080/paymentSuccess.jsp', // Your success URL
        prefill: {
          name: 'Gaurav Kumar',
          email: 'gaurav.kumar@example.com',
          contact: '9999999999'
        },
        theme: {
          color: '#F37254'
        },
      };

      const rzp = new Razorpay(options);
      rzp.open();
    }
  </script>
</body>
</html>