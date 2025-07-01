<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<link href="./SCSS/booking.css" rel="stylesheet">
<% 
try{
String id=request.getParameter("id");
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging","root","");
String getSql="SELECT * FROM bookings WHERE id = ?";
PreparedStatement ps=conn.prepareStatement(getSql);
ps.setString(1,id);
ResultSet rs=ps.executeQuery();

// int amount=(int)session.getAttribute("price");
if(rs.next() || rs != null){
    String vname = rs.getString("v_name");
    String vno = rs.getString("v_no");
    String name = rs.getString("name");
    String email = rs.getString("email");
    String date = rs.getString("booking_date");
    String time = rs.getString("f_time")+" To "+rs.getString("t_time");
    String mob_no = rs.getString("phone");
    String slot = rs.getString("selected_slot");
    int amount = Integer.valueOf(rs.getString("amount"))*100;

%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Razorpay Payment</title>
</head>
<body>
<div class="container">
<%@ include file="navbar.jsp" %>
<div class="card">
<div class="card-body ">
<div class="container mb-5 mt-3">
  <div class="row d-flex align-items-baseline">
    <div class="col-xl-9 mb-2">
      <h1>Razorpay Payment Gateway Integration</h1>
    </div>
    
    <form id="payment-form">
      <label for="vname">Vehicle Name: <%= vname %> </label>
    <input type="text" id="vid" name="vid" value="<%= id %>" hidden>
    <input type="text" id="amount" name="amount" value="<%= amount %>" >
    <button id="rzp-button1">Pay</button>
  </form>
</div>
</div>
</div>
</div>
</div>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
  var options = {
    "key": "Enter_Your_Api_Key",
    "amount": <%= amount %>, // in paise
    "currency": "INR",
    "description": "Book My Slot",
    "image": "example.com/image/rzp.jpg",
    "prefill": {
      "email": "<%= email %>",
      "contact": "<%= mob_no %>"
    },
    config: {
      display: {
        blocks: {
          utib: {
            name: "Pay Using Axis Bank",
            instruments: [
              { method: "card", issuers: ["UTIB"] },
              { method: "netbanking", banks: ["UTIB"] }
            ]
          },
          other: {
            name: "Other Payment Methods",
            instruments: [
              { method: "card", issuers: ["ICIC"] },
              { method: 'netbanking' },
              { method: 'upi' }
            ]
          },
          banks: {
            name: 'All Payment Options',
            instruments: [
              { method: 'upi' },
              { method: 'card' },
              { method: 'wallet' },
              { method: 'netbanking' }
            ]
          },
        },
        sequence: ["block.utib", "block.other", "block.banks"],
        preferences: {
          show_default_blocks: true
        }
      }
    },
    "handler": function (response) {
      alert("Payment successful!");
      window.location.href = "paymentSuccess.jsp?payment_id=" + response.razorpay_payment_id + "&vid=" + "<%= id %>";
    },
    "modal": {
      "ondismiss": function () {
        if (confirm("Are you sure, you want to close the form?")) {
          console.log("Checkout form closed by the user");
        } else {
          console.log("Complete the Payment");
        }
      }
    }
  };

  var rzp1 = new Razorpay(options);
  document.getElementById('rzp-button1').onclick = function (e) {
    rzp1.open();
    e.preventDefault();
  };
</script>

</html>

</body>
</html>
<% } 

}catch(Exception e){
        e.printStackTrace();
        %>
            <script>
                alert("Error: <%= e.getMessage() %>");
            </script>
        <%
  }%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
