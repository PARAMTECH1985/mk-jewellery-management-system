<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<title>Old Item Exchange & Buyback</title>
<style>
table {
  width: 100%;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #555;
  padding: 6px;
  text-align: center;
}
th {
  background: #f2f2f2;
}
</style>
</head>

<body>

<h2 style="text-align:center;">
Old Item Exchange & Buyback (Bill ID: ${billId})
</h2>

<table border="1" width="100%" style="border-collapse:collapse">
    <thead>
        <tr>
            <th>Bill ID</th>
            <th>Date</th>
            <th>Type</th>
            <th>Old Item</th>
            <th>Weight</th>
            <th>Purity</th>
            <th>Rate</th>
            <th>Old Value</th>
            <th>New Item</th>
            <th>New Value</th>
            <th>Balance</th>
        </tr>
    </thead>

    <tbody>
        <c:forEach var="ex" items="${exchanges}">
            <tr>
                <td>${ex.billId}</td>
                <td>${ex.exchangeDate}</td>
                <td>
                    <b style="color:${ex.exchangeType == 'BUYBACK' ? 'red' : 'green'}">
                        ${ex.exchangeType}
                    </b>
                </td>
                <td>${ex.oldDescription}</td>
                <td>${ex.oldWeight}</td>
                <td>${ex.oldPurity}</td>
                <td>${ex.oldRate}</td>
                <td>${ex.oldValue}</td>
                <td>${ex.newDescription}</td>
                <td>${ex.newValue}</td>
                <td><b>${ex.balanceAmount}</b></td>
            </tr>
        </c:forEach>

        <c:if test="${empty exchanges}">
            <tr>
                <td colspan="11" style="text-align:center;color:red;">
                    No Exchange / Buyback Data Found
                </td>
            </tr>
        </c:if>
    </tbody>
</table>


</body>
</html>
