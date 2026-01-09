<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Bill</title>

<style>
/* ===== Background ===== */
body{
    margin:0;
    font-family: "Segoe UI", Arial, sans-serif;
    background: radial-gradient(circle at top,#2c3e50,#0f2027);
    overflow-x:hidden;
    overflow-y:hidden;
}

/* ===== Main Card ===== */
.container{
    max-width:820px;
    margin:45px auto;
    background:#fbfbfb;
    padding:38px 42px;
    border-radius:18px;
    box-shadow:
        0 20px 40px rgba(0,0,0,0.35),
        inset 0 1px 0 rgba(255,255,255,0.6);
    border-top:6px solid #c9a24d; /* gold accent */
}

/* ===== Heading ===== */
h2{
    text-align:center;
    font-size:26px;
    font-weight:700;
    color:#1f2a44;
    letter-spacing:.3px;
    margin-bottom:32px;
}
h2:after{
    content:"";
    width:110px;
    height:4px;
    background:linear-gradient(90deg,#c9a24d,#f4d03f);
    display:block;
    margin:12px auto 0;
    border-radius:3px;
}

/* ===== Form Grid ===== */
.form-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:22px 28px;
}

/* ===== Form Group ===== */
.form-group{
    display:flex;
    flex-direction:column;
}

.form-group label{
    font-size:13px;
    font-weight:600;
    color:#3e4a59;
    margin-bottom:6px;
}

.form-group input{
    padding:11px 12px;
    font-size:14px;
    border-radius:8px;
    border:1px solid #d6dbe3;
    background:#ffffff;
    transition:.25s;
}

.form-group input:focus{
    border-color:#c9a24d;
    box-shadow:0 0 0 2px rgba(201,162,77,0.25);
    outline:none;
}

/* ===== Readonly Premium Look ===== */
.form-group input[readonly]{
    background:linear-gradient(180deg,#f9fafb,#eef2f6);
    color:#2c3e50;
    font-weight:600;
}

/* ===== Full Width ===== */
.full{
    grid-column:1/3;
}

/* ===== Button ===== */
.actions{
    margin-top:40px;
    text-align:center;
}

button{
    padding:14px 55px;
    border:none;
    border-radius:40px;
    font-size:15px;
    font-weight:700;
    letter-spacing:.4px;
    color:#fff;
    cursor:pointer;
    background:linear-gradient(135deg,#1abc9c,#1f4fd8);
    box-shadow:
        0 10px 25px rgba(26,188,156,0.45),
        inset 0 1px 0 rgba(255,255,255,0.3);
    transition:.3s;
}

button:hover{
    transform:translateY(-3px);
    box-shadow:
        0 16px 35px rgba(26,188,156,0.6);
}

/* ===== Back Link ===== */
.back-link{
    display:block;
    margin-top:24px;
    text-align:center;
    font-size:14px;
    font-weight:600;
    color:#1f4fd8;
    text-decoration:none;
}
.back-link:hover{
    text-decoration:underline;
}
</style>
</head>

<body>

<div class="container">

<h2>Edit Bill Details</h2>

<form action="${pageContext.request.contextPath}/saveBill" method="post">

<!-- IMPORTANT -->
<input type="hidden" name="id" value="${bill.id}"/>

<div class="form-grid">

<div class="form-group">
<label>Customer Name</label>
<input type="text" name="customerName" value="${bill.customerName}" required>
</div>

<div class="form-group">
<label>Date</label>
<input type="date" name="date"
value="<fmt:formatDate value='${bill.date}' pattern='yyyy-MM-dd'/>">
</div>

<div class="form-group">
<label>Bill No</label>
<input type="text" name="billNo" value="${bill.billNo}" readonly>
</div>

<div class="form-group">
<label>HSN Code</label>
<input type="text" name="hsncode" value="${bill.hsncode}">
</div>

<div class="form-group">
<label>HUID</label>
<input type="text" name="huid" value="${bill.huid}">
</div>

<div class="form-group">
<label>CGST</label>
<input type="text" name="cgst" value="${bill.cgst}" readonly>
</div>

<div class="form-group">
<label>SGST</label>
<input type="text" name="sgst" value="${bill.sgst}" readonly>
</div>

<div class="form-group">
<label>Total Amount</label>
<input type="text" name="totalAmount" value="${bill.totalAmount}" readonly>
</div>

<div class="form-group">
<label>Round Off</label>
<input type="text" name="roundOff" value="${bill.roundOff}">
</div>

<div class="form-group">
<label>Final Amount</label>
<input type="text" name="finalAmount" value="${bill.finalAmount}" readonly>
</div>

<div class="form-group full">
<label>Payment Mode</label>
<input type="text" name="paymentMode" value="${bill.paymentMode}">
</div>

</div>

<div class="actions">
<button type="submit">Update Bill</button>
</div>

</form>

<a class="back-link" href="${pageContext.request.contextPath}/bill-list">
⬅ Back to List
</a>

</div>

</body>
</html>
