<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DefaultError.aspx.cs" Inherits="RestoExpense.DefaultError" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 25px;
            background-color: #f9f9f9;
            color: #333;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 40px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #d9534f;
            text-align: center;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            line-height: 1.6;
        }

        .copy-container {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: monospace;
            font-size: 14px;
            color: #555;
            position: relative;
        }

        .copy-btn {
            background: none;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            position: relative;
            margin-left:95px;
        }

        .copy-btn img {
            width: 20px;
            height: 20px;
        }

        .copied-message {
            display: none;
            font-size: 12px;
            color: #141414;
            animation: fadeOut 2s forwards;
            font-size: larger;
            position: absolute;
            top: 48px;
            left: 90%;
            transform: translateX(-50%);
        }

        /* Fade-out animation */
        @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
        }
    </style>
    <script>
        function copyToClipboard() {
            const text = document.getElementById("link-text").innerText;

            const textarea = document.createElement("textarea");
            textarea.value = text;
            document.body.appendChild(textarea);
            textarea.select();
            document.execCommand("copy");
            document.body.removeChild(textarea);
            showCopiedMessage();

            function showCopiedMessage() {
                const copiedMessage = document.getElementById("copied-message");
                copiedMessage.style.display = "block";
                setTimeout(() => {
                    copiedMessage.style.display = "none";
                }, 2000);
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Oops! Page Not Found</h1>
        <p>The page you are looking for does not exist. Below is the correct URL</p>
        <asp:Label ID="lblMessage" runat="server" />
        <div class="copy-container">
            <span id="link-text">http://expenses.saffronvatika.com:8099/expenses</span>
            <button class="copy-btn" onclick="copyToClipboard()">
                <img src="/Images/copy.png" alt="Copy Icon">
                <span style="font-size: small; padding-left:5px;">  Copy Code</span>
            </button>
            <div id="copied-message" class="copied-message">Copied!</div>
        </div>
    </div>
</body>
</html>
