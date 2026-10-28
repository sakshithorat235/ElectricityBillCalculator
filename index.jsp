<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String input = request.getParameter("units");
    double units = 0;
    double bill = 0;
    boolean calculated = false;
    String error = "";

    if (input != null) {
        try {
            units = Double.parseDouble(input);

            if (units < 0) {
                error = "Units cannot be negative.";
            } else {
                double remaining = units;

                if (remaining > 250) {
                    bill += (remaining - 250) * 6.50;
                    remaining = 250;
                }

                if (remaining > 150) {
                    bill += (remaining - 150) * 5.20;
                    remaining = 150;
                }

                if (remaining > 50) {
                    bill += (remaining - 50) * 4.00;
                    remaining = 50;
                }

                bill += remaining * 3.50;
                calculated = true;
            }
        } catch (NumberFormatException e) {
            error = "Please enter valid units.";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Electricity Bill Calculator</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eaf2ff;
            margin: 0;
            padding: 30px 15px;
        }

        .container {
            max-width: 650px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px #ccd5e0;
        }

        h1 {
            text-align: center;
            color: #1d4ed8;
        }

        p {
            line-height: 1.6;
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: bold;
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            margin-top: 10px;
            border: 1px solid #bbb;
            border-radius: 7px;
            font-size: 16px;
        }

        button {
            width: 100%;
            padding: 13px;
            margin-top: 20px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 7px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #1e40af;
        }

        .result {
            margin-top: 25px;
            padding: 20px;
            background: #dcfce7;
            border-radius: 8px;
        }

        .error {
            margin-top: 20px;
            padding: 15px;
            color: #b91c1c;
            background: #fee2e2;
            border-radius: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #2563eb;
            color: white;
        }

        @media (max-width: 480px) {
            .container {
                padding: 18px;
            }

            h1 {
                font-size: 25px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Electricity Bill Calculator</h1>

    <p>Enter your electricity consumption to calculate your bill.</p>

    <form action="index.jsp" method="post">

        <label for="units">Electricity Units Consumed:</label>

        <input
            type="number"
            id="units"
            name="units"
            min="0"
            step="any"
            placeholder="Enter units"
            value="<%= input == null ? "" : input %>"
            required>

        <button type="submit">Calculate Bill</button>

    </form>

    <% if (!error.isEmpty()) { %>

        <div class="error">
            <%= error %>
        </div>

    <% } %>

    <% if (calculated) { %>

        <div class="result">

            <h2>Bill Calculation Result</h2>

            <p>Units Consumed: <strong><%= units %></strong></p>

            <p>Total Electricity Bill:
                <strong>₹<%= String.format("%.2f", bill) %></strong>
            </p>

        </div>

    <% } %>

    <h2>Electricity Tariff Rates</h2>

    <table>
        <tr>
            <th>Units</th>
            <th>Rate per Unit</th>
        </tr>

        <tr>
            <td>First 50 units</td>
            <td>₹3.50</td>
        </tr>

        <tr>
            <td>Next 100 units (51–150)</td>
            <td>₹4.00</td>
        </tr>

        <tr>
            <td>Next 100 units (151–250)</td>
            <td>₹5.20</td>
        </tr>

        <tr>
            <td>Above 250 units</td>
            <td>₹6.50</td>
        </tr>
    </table>

</div>

</body>
</html>