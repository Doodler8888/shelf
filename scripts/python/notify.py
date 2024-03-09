import json
import os
import requests

# Set up the Telegram Bot API token and chat ID
TELEGRAM_BOT_TOKEN = os.environ["TELEGRAM_BOT_TOKEN"]
TELEGRAM_CHAT_ID = os.environ["TELEGRAM_CHAT_ID"]

# Telegram API endpoint for sending messages
TELEGRAM_API_URL = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"


def lambda_handler(event, context):
    # Extract the relevant information from the event
    service_name = event["service"]
    usage_data = event["usage"]

    # Compose the message to be sent to Telegram
    message = (
        f"Service Usage Alert!\n\nService: {service_name}\nUsage Data: {usage_data}"
    )

    # Send the message to Telegram
    payload = {"chat_id": TELEGRAM_CHAT_ID, "text": message}
    response = requests.post(TELEGRAM_API_URL, json=payload)

    # Check if the message was sent successfully
    if response.status_code == 200:
        return {
            "statusCode": 200,
            "body": json.dumps("Message sent to Telegram successfully"),
        }
    else:
        return {
            "statusCode": 500,
            "body": json.dumps("Failed to send message to Telegram"),
        }
