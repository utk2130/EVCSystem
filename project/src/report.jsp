<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String paymentId = request.getParameter("payment_id");
    String vId = request.getParameter("id");

    String username = "", status = "", vno = "", vname = "";
    int amount = 0;
    String issueDate = "", dueDate = "14 days"; // Hardcoded due date

    if (paymentId != null && vId != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

            String sql = "SELECT payments.*, booking_history.v_no, booking_history.v_name, booking_history.booking_date " +
                         "FROM payments " +
                         "LEFT JOIN booking_history ON payments.v_id = booking_history.id " +
                         "WHERE payments.payment_id = ? AND payments.v_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, paymentId);
            stmt.setString(2, vId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                username = rs.getString("uname");
                amount = rs.getInt("amount");
                status = rs.getString("status");
                vno = rs.getString("v_no");
                vname = rs.getString("v_name");
                java.sql.Date bookingDate = rs.getDate("booking_date");
                if (bookingDate != null) {
                    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                    issueDate = formatter.format(bookingDate);
                } else {
                    issueDate = "N/A"; // or use current date, or leave empty
                }

            } else {
                out.println("<script>alert('Invoice not found.');</script>");
                return;
            }

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } else {
        out.println("<script>alert('Missing payment_id or v_id!');</script>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Invoice - Book My Slot</title>
</head>
<body>
<link href="./SCSS/report.css" rel="stylesheet">
<%@ include file="navbar.jsp" %>

<div class="invoice-box">
    <div class="header">
        <h2>New Invoice for <%= uname %></h2>
        <button class="btn">Recurring Invoice</button>
    </div>

    <div class="row"><strong>Invoice number:</strong> <span><%= vId %></span></div>
    <div class="row"><strong>Client:</strong> <span><%= uname %></span></div>
    <div class="row"><strong>PO number:</strong> <span>111122223333</span></div>
    <div class="row"><strong>Tax number:</strong> <span>1234567890</span></div>
    <div class="row"><strong>Issue date:</strong> <span><%= issueDate %></span></div>
    <div class="row"><strong>Status:</strong> <span><%= status %></span></div>
    <div class="row"><strong>Currency:</strong> <span>INR - ₹</span></div>
    <div class="row"><strong>Subject:</strong> <span>Book My Slot Payment</span></div>

    <table class="table">
        <tr>
            <th>Type</th>
            <th>Description</th>
            <th>Qty.</th>
            <th>Unit</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>Service</td>
            <td>EV Charging for <%= vname != null ? vname : "vehicle" %> (No: <%= vno %>)</td>
            <td>1</td>
            <td>₹<%= amount %></td>
            <td>₹<%= amount %></td>
        </tr>
    </table>

    <h3 style="text-align: right; padding-top: 20px;">Total: ₹<%= amount %></h3>
    <button class="btn" onclick="downloadPDF()">Download PDF</button>
</div> <!-- End of invoice-box -->

<!-- Include html2pdf.js from CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>

<script>
    function downloadPDF() {
        const invoice = document.querySelector('.invoice-box');
        const opt = {
            margin:       0.5,
            filename:     'Invoice_<%= vId %>.pdf',
            image:        { type: 'jpeg', quality: 0.98 },
            html2canvas:  { scale: 2 },
            jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' }
        };
        html2pdf().set(opt).from(invoice).save();
    }
</script>
</body>
</html>

