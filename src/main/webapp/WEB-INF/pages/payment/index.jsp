<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PayPal Checkout</title>
    <!-- Nhúng JavaScript SDK của PayPal -->
    <script src="https://www.paypal.com/sdk/js?client-id=AQm-4AZCDD31KiQ_HucLlV-eMHA0JTDO2vT3sYUNkCV8v7hytcSoxXlHH9czhM8kXoga8Tj0nM2k7ZKB&currency=USD"></script>
</head>
<body>


<!-- Input để nhập số tiền -->
<label for="amount">Nhập số tiền cần thanh toán:</label>
<input class="form-control" type="number" id="amount" placeholder="Nhập số tiền" style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; margin-bottom: 10px;">


    <!-- Nút thanh toán PayPal sẽ được render tại đây -->
    <div id="paypal-button-container"></div>

    <script>
        paypal.Buttons({
            createOrder: function(data, actions) {
                var amount = document.getElementById('amount').value;
                return actions.order.create({
                    purchase_units: [{
                        amount: {
                            value: amount,
                            currency_code: 'USD'
                        }
                    }]
                });
            },
            onApprove: function(data, actions) {
                return actions.order.capture().then(function(details) {
                    var fullResponse = {
                        orderID: data.orderID,
                        payerID: data.payerID,
                        details: details
                    };
                    window.location.href = "success.html?response=" + encodeURIComponent(JSON.stringify(fullResponse));
                });
            },
            onError: function(err) {
                // Nếu có lỗi, chuyển hướng sang trang error.html
                window.location.href = "error.html";
            }
        }).render('#paypal-button-container');
    </script>

</body>
</html>
