<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Bill List</title>

<style>
/* ===== PAGE ===== */
body{
    margin:0;
    font-family:"Segoe UI", Arial, sans-serif;
    background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
}

/* ===== WRAPPER ===== */
.wrapper{
    margin:20px;
    background:rgba(255,255,255,0.96);
    border-radius:14px;
    padding:18px;
    box-shadow:0 20px 40px rgba(0,0,0,.35);
}

/* ===== HEADER ===== */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:14px;
}
.header h2{
    margin:0;
    font-size:22px;
    color:#1f2a44;
}
.header a{
    background:linear-gradient(135deg,#1abc9c,#1f4fd8);
    color:#fff;
    padding:10px 18px;
    border-radius:30px;
    text-decoration:none;
    font-weight:600;
    box-shadow:0 6px 15px rgba(31,79,216,.35);
}

/* ===== MESSAGE ===== */
.msg{
    color:#0a7a2f;
    font-weight:600;
    margin:8px 0 12px;
}

/* ===== TABLE WRAP ===== */
.table-wrap{
    overflow:auto;
    max-height:75vh;
    border-radius:12px;
    border:1px solid #dcdcdc;
}

/* ===== TABLE ===== */
table{
    width:100%;
    border-collapse:collapse;
    font-size:13px;
    white-space:nowrap;
}

th{
    position:sticky;
    top:0;
    background:#1f2a44;
    color:#fff;
    padding:9px;
    font-weight:600;
    border-right:1px solid #2f3b5f;
}

td{
    padding:8px;
    text-align:center;
    border-bottom:1px solid #e6e6e6;
}

tr:nth-child(even){background:#f8fafc}
tr:hover{background:#eef5ff}

/* ===== ACTION COLUMN ===== */
th:last-child,
td:last-child{
    min-width:230px;
    max-width:230px;
}

/* ===== BUTTONS ===== */
.action-btn{
    padding:5px 10px;
    border-radius:5px;
    font-size:12px;
    text-decoration:none;
    font-weight:600;
    margin:2px;
    display:inline-block;
}
.edit{background:#4CAF50;color:#fff}
.delete{background:#f44336;color:#fff}
.exchange{background:#2196F3;color:#fff}
.action-btn:hover{opacity:.85}
</style>
</head>

<body>

<div class="wrapper">

<!-- HEADER -->
<div class="header">
    <h2>📋 Bill List (Full Data)</h2>
    <a href="${pageContext.request.contextPath}/index">➕ Add New Bill</a>
</div>

<c:if test="${not empty msg}">
    <div class="msg">${msg}</div>
</c:if>

<div class="table-wrap">
<table>
<tr>
    <th>ID</th>
    <th>Bill No</th>
    <th>Customer</th>
    <th>Date</th>
    <th>Description</th>
    <th>Type</th>
    <th>HSN</th>
    <th>HUID</th>
    <th>Weight</th>
    <th>Rate</th>
    <th>Value</th>
    <th>Making</th>
    <th>Amount</th>
    <th>CGST</th>
    <th>SGST</th>
    <th>Total</th>
    <th>Round</th>
    <th>Final</th>
    <th>Pay</th>
    <th>Action</th>
</tr>

<c:forEach var="b" items="${bills}">
<tr>
    <td>${b.id}</td>
    <td>${b.billNo}</td>
    <td>${b.customerName}</td>
    <td><fmt:formatDate value="${b.date}" pattern="dd-MM-yyyy"/></td>
    <td>${b.description}</td>
    <td>${b.type}</td>
    <td>${b.hsncode}</td>
    <td>${b.huid}</td>
    <td>${b.weight}</td>
    <td>${b.rate}</td>
    <td>${b.value}</td>
    <td>${b.making}</td>
    <td>${b.amount}</td>
    <td>${b.cgst}</td>
    <td>${b.sgst}</td>
    <td>${b.totalAmount}</td>
    <td>${b.roundOff}</td>
    <td>${b.finalAmount}</td>
    <td>${b.paymentMode}</td>

    <!-- ACTION BUTTONS ONLY -->
    <td>
        <a class="action-btn edit"
           href="${pageContext.request.contextPath}/editBill/${b.id}">
           Edit
        </a>

        <a class="action-btn delete"
           href="${pageContext.request.contextPath}/deleteBill/${b.id}"
           onclick="return confirm('Are you sure?')">
           Delete
        </a>

        <a class="action-btn exchange"
           href="${pageContext.request.contextPath}/exchange/${b.id}">
           Exchange / Buyback
        </a>
    </td>
</tr>
</c:forEach>

</table>
</div>

</div>

</body>
</html>
