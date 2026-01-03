<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Bill List</title>

<style>
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 6px;
        text-align: center;
    }
    th {
        background: #f2f2f2;
    }
    .edit {
        background: #4CAF50;
        color: white;
        padding: 4px 8px;
        text-decoration: none;
        border-radius: 4px;
    }
    .delete {
        background: #f44336;
        color: white;
        padding: 4px 8px;
        text-decoration: none;
        border-radius: 4px;
    }
</style>
</head>

<body>

<h2>Bill List (Full Data)</h2>

<c:if test="${not empty msg}">
    <p style="color: green">${msg}</p>
</c:if>

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
        <th>Round Off</th>
        <th>Final Amount</th>
        <th>Payment Mode</th>
        <th>Action</th>
    </tr>

    <c:forEach var="b" items="${bills}">
        <tr>
            <td>${b.id}</td>
            <td>${b.billNo}</td>
            <td>${b.customerName}</td>

            <td>
                <fmt:formatDate value="${b.date}" pattern="dd-MM-yyyy"/>
            </td>

            <td>${b.description}</td>
            <td>${b.type}</td>
            <td>${b.hsncode}</td>
            <td>${b.huid}</td>

            <!-- Lists ko direct print kar rahe -->
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

            <td>
                <a class="edit"
                   href="${pageContext.request.contextPath}/editBill/${b.id}">
                   Edit
                </a>
                |
                <a class="delete"
                   href="${pageContext.request.contextPath}/deleteBill/${b.id}"
                   onclick="return confirm('Are you sure?')">
                   Delete
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="${pageContext.request.contextPath}/">➕ Add New Bill</a>

</body>
</html>
