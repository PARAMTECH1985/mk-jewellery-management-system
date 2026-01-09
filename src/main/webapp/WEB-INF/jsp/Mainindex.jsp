<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Jewellery Management System</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f6f2e9;
            color: #333;
        }

        /* ===== HEADER ===== */
        .header {
            background: linear-gradient(to right, #c9a24d, #a07c1f);
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .nav a {
            text-decoration: none;
            color: white;
            font-weight: 600;
            margin-left: 25px;
            font-size: 15px;
        }

        .nav a:hover {
            text-decoration: underline;
        }

        /* ===== HERO SECTION ===== */
        .hero {
            text-align: center;
            padding: 90px 20px;
            background: url('https://images.unsplash.com/photo-1600180758890-6b94519a8ba6') center/cover no-repeat;
            color: white;
        }

        .hero h1 {
            font-size: 42px;
            margin-bottom: 15px;
        }

        .hero p {
            font-size: 18px;
            opacity: 0.95;
        }

        .hero-btn {
            margin-top: 30px;
        }

        .hero-btn a {
            text-decoration: none;
            background: #c9a24d;
            padding: 14px 28px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 6px;
            margin: 10px;
            display: inline-block;
        }

        .hero-btn a:hover {
            background: #a07c1f;
        }

        /* ===== FEATURES ===== */
        .features {
            display: flex;
            justify-content: center;
            gap: 25px;
            padding: 60px 20px;
            background: #fff;
        }

        .feature-box {
            width: 260px;
            padding: 25px;
            text-align: center;
            border-radius: 10px;
            background: #fafafa;
            box-shadow: 0 8px 18px rgba(0,0,0,0.12);
        }

        .feature-box h3 {
            color: #7a5c12;
            margin-bottom: 10px;
        }

        /* ===== FOOTER ===== */
        .footer {
            background: #2c2c2c;
            color: #ccc;
            text-align: center;
            padding: 18px;
            font-size: 13px;
        }
    </style>
</head>

<body>

<!-- ===== HEADER ===== -->
<div class="header">
    <div class="logo">💎 M. K. Jewellers</div>
    <div class="nav">
        <a href="${pageContext.request.contextPath}/">Home</a>
       <a href="${pageContext.request.contextPath}/RemaingAmtAllCustomer">Pending Amount</a>
		<a href="${pageContext.request.contextPath}/bill-download">Download Bill</a>
        <a href="${pageContext.request.contextPath}/exchange-history">Exchange/Buyback Records</a>
    </div>
</div>
<c:if test="${not empty rate}">
    <div style="background:#fff3cd;padding:10px;text-align:center;">
        Gold: ₹ ${rate.goldRate} /gm |
        Silver: ₹ ${rate.silverRate} /gm
    </div>
</c:if>

<!-- ===== HERO ===== -->
<div class="hero">
    <h1>Jewellery Management System</h1>
    <p>Manage customers, billing and records with elegance & accuracy</p>

    <div class="hero-btn">
        <a href="${pageContext.request.contextPath}/index">➕ New Customer</a>
        <a href="${pageContext.request.contextPath}/bill-list">📋 View Customers</a>
    </div>
</div>


<c:if test="${showRatePopup}">
<div id="ratePopup" style="
    position:fixed;
    top:0; left:0;
    width:100%; height:100%;
    background:rgba(0,0,0,0.6);
    display:flex;
    justify-content:center;
    align-items:center;
    z-index:9999;
">
    <form action="${pageContext.request.contextPath}/admin/save-rate"
          method="post"
          style="background:#fff;padding:25px;border-radius:8px;width:320px;">
        
        <h3>Enter Today's Rate</h3>

        Gold (₹/gm):
        <input type="number" step="0.01" name="goldRate" required><br><br>

        Silver (₹/gm):
        <input type="number" step="0.01" name="silverRate" required><br><br>

        <button type="submit">Save Rate</button>
    </form>
</div>
</c:if>




<!-- ===== FEATURES ===== -->
<div class="features">
    <div class="feature-box">
        <h3>Customer Management</h3>
        <p>Register & manage jewellery customers easily.</p>
    </div>

    <div class="feature-box">
        <h3>Billing Control</h3>
        <p>Track total, received & pending amount clearly.</p>
    </div>

    <div class="feature-box">
        <h3>Secure Records</h3>
        <p>All data safely stored & managed in system.</p>
    </div>
</div>

<!-- ===== FOOTER ===== -->
<div class="footer">
    © 2025 M. K. Jewellers | Jewellery Management System<br>
    Designed with ❤️ for professional jewellery shops
</div>

</body>
</html>
