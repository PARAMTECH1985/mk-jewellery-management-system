<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Old Item Exchange / Buyback</title>

<style>
body {
    font-family: "Segoe UI", Arial, sans-serif;
    background: #eef1f6;
}

.container {
    width: 88%;
    margin: 25px auto;
    background: #ffffff;
    padding: 22px 28px;
    border-radius: 8px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.08);
}

h2 {
    margin-bottom: 18px;
    color: #2c2c2c;
    border-bottom: 2px solid #e0e0e0;
    padding-bottom: 10px;
}

/* section cards */
.card {
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 15px 18px;
    margin-bottom: 20px;
}

.card.old {
    background: #f7f7f7;
}

.card.new {
    background: #fdfefe;
    border-left: 4px solid #4CAF50;
}

.card-title {
    font-weight: 600;
    margin-bottom: 12px;
    color: #333;
    font-size: 15px;
}

.form-row {
    display: flex;
    flex-wrap: wrap;
}

.form-group {
    width: 20%;
    min-width: 180px;
    margin-right: 15px;
    margin-bottom: 12px;
}

.form-group label {
    display: block;
    font-size: 12px;
    font-weight: 600;
    margin-bottom: 4px;
    color: #444;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 7px;
    font-size: 13px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

input[readonly] {
    background: #ececec;
    color: #555;
}

button {
    margin-top: 10px;
    padding: 10px 26px;
    background: linear-gradient(135deg,#43a047,#2e7d32);
    border: none;
    color: #fff;
    font-size: 14px;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background: linear-gradient(135deg,#2e7d32,#1b5e20);
}
</style>

<script>
function toggleNewItem() {
    var type = document.getElementById("exchangeType").value;
    var newItem = document.getElementById("newItemSection");

    if (type === "BUYBACK") {
        newItem.style.display = "none";
        document.getElementsByName("newDescription")[0].value = "";
        document.getElementsByName("newWeight")[0].value = "";
        document.getElementsByName("newRate")[0].value = "";
        document.getElementsByName("newValue")[0].value = "";
    } else {
        newItem.style.display = "block";
    }
}
window.onload = toggleNewItem;
</script>

</head>
<body>

<div class="container">

<h2>Old Item Exchange / Buyback</h2>

<form action="${pageContext.request.contextPath}/saveExchange" method="post">

<input type="hidden" name="billId" value="${exchange.billId}"/>

<div class="form-row">
    <div class="form-group">
        <label>Date</label>
        <input type="date" name="exchangeDate"
               value="${exchange.exchangeDate}" readonly>
    </div>

    <div class="form-group">
        <label>Transaction Type</label>
        <select name="exchangeType" id="exchangeType" onchange="toggleNewItem()">
            <option value="EXCHANGE"
                ${exchange.exchangeType == 'EXCHANGE' ? 'selected' : ''}>
                Exchange
            </option>
            <option value="BUYBACK"
                ${exchange.exchangeType == 'BUYBACK' ? 'selected' : ''}>
                Buyback
            </option>
        </select>
    </div>
</div>

<!-- OLD ITEM -->
<div class="card old">
    <div class="card-title">Old Item (Given by Customer)</div>

    <div class="form-row">
        <div class="form-group">
            <label>Description</label>
            <input type="text" name="oldDescription"
                   value="${exchange.oldDescription}" readonly>
        </div>

        <div class="form-group">
            <label>Weight (gm)</label>
            <input type="number" step="0.001" name="oldWeight"
                   value="${exchange.oldWeight}" readonly>
        </div>

        <div class="form-group">
            <label>Purity</label>
            <input type="text" name="oldPurity"
                   value="${exchange.oldPurity}" readonly>
        </div>

        <div class="form-group">
            <label>Rate</label>
            <input type="number" step="0.01" name="oldRate"
                   value="${exchange.oldRate}" readonly>
        </div>

        <div class="form-group">
            <label>Value</label>
            <input type="number" step="0.01" name="oldValue"
                   value="${exchange.oldValue}" readonly>
        </div>
    </div>
</div>

<!-- NEW ITEM -->
<div id="newItemSection" class="card new">
    <div class="card-title">New Item (Given to Customer)</div>

    <div class="form-row">
        <div class="form-group">
            <label>Description</label>
            <input type="text" name="newDescription">
        </div>

        <div class="form-group">
            <label>Weight (gm)</label>
            <input type="number" step="0.001" name="newWeight">
        </div>

        <div class="form-group">
            <label>Rate</label>
            <input type="number" step="0.01" name="newRate">
        </div>

        <div class="form-group">
            <label>Value</label>
            <input type="number" step="0.01" name="newValue">
        </div>
    </div>
</div>

<button type="submit">Save Exchange</button>

</form>
</div>

</body>
</html>
