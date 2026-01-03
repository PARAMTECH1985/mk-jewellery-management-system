<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Bill</title>
<style>
body{width:600px;margin:auto;font-family:Arial}
table{width:100%;border-collapse:collapse}
td{padding:8px}
input{width:100%;padding:6px}
button{padding:10px 20px;background:#4CAF50;color:#fff;border:none}
</style>
</head>

<body>

<h2>Edit Bill</h2>

<form action="${pageContext.request.contextPath}/saveBill" method="post">

<!-- 🔴 MOST IMPORTANT -->
<input type="hidden" name="id" value="${bill.id}"/>

<table>

<tr>
<td>Customer Name</td>
<td>
<input type="text" name="customerName" value="${bill.customerName}" required>
</td>
</tr>

<tr>
<td>Date</td>
<td>
<input type="date" name="date"
value="<fmt:formatDate value='${bill.date}' pattern='yyyy-MM-dd'/>">
</td>
</tr>

<tr>
<td>Bill No</td>
<td>
<input type="text" name="billNo" value="${bill.billNo}" readonly>
</td>
</tr>

<tr>
<td>HSN Code</td>
<td>
<input type="text" name="hsncode" value="${bill.hsncode}">
</td>
</tr>

<tr>
<td>HUID</td>
<td>
<input type="text" name="huid" value="${bill.huid}">
</td>
</tr>

<tr>
<td>CGST</td>
<td>
<input type="text" name="cgst" value="${bill.cgst}" readonly>
</td>
</tr>

<tr>
<td>SGST</td>
<td>
<input type="text" name="sgst" value="${bill.sgst}" readonly>
</td>
</tr>

<tr>
<td>Total Amount</td>
<td>
<input type="text" name="totalAmount" value="${bill.totalAmount}" readonly>
</td>
</tr>

<tr>
<td>Round Off</td>
<td>
<input type="text" name="roundOff" value="${bill.roundOff}">
</td>
</tr>

<tr>
<td>Final Amount</td>
<td>
<input type="text" name="finalAmount" value="${bill.finalAmount}" readonly>
</td>
</tr>

<tr>
<td>Payment Mode</td>
<td>
<input type="text" name="paymentMode" value="${bill.paymentMode}">
</td>
</tr>

</table>

<br>

<button type="submit">Update Bill</button>

</form>

<br>
<a href="${pageContext.request.contextPath}/bill-list">⬅ Back to List</a>

</body>
</html>
