import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import os
from remove_csv_and_xlsx_files import *

def send_email_without_results(to_addresses, subject, body):
    # Set up the email server and login credentials
    smtp_server = 'smtp.gmail.com'
    smtp_port = 587
    email_address = "omarkamalabuassaf1@gmail.com"
    email_password = os.getenv('EMAIL_PASSWORD')

    # Create the email
    msg = MIMEMultipart()
    msg['From'] = email_address
    msg['To'] = ", ".join(to_addresses)  
    msg['Subject'] = subject

    # Attach the body of the email
    msg.attach(MIMEText(body, 'plain'))

    # Connect to Gmail server and send the email
    server = smtplib.SMTP(smtp_server, smtp_port)
    server.starttls()
    server.login(email_address, email_password)
    text = msg.as_string()
    server.sendmail(email_address, to_addresses, text)

    server.quit()

    print('Email sent successfully!')
    remove_csv_and_xlsx_files()




# import aiosmtplib
# from email.mime.multipart import MIMEMultipart
# from email.mime.text import MIMEText
# import os
# from dotenv import load_dotenv
# from remove_csv_and_xlsx_files import remove_csv_and_xlsx_files

# load_dotenv()

# async def send_email_without_results(to_addresses, subject, body):
#     # Set up the email server and login credentials
#     smtp_server = 'smtp.gmail.com'
#     smtp_port = 587
#     email_address = "omarkamalabuassaf1@gmail.com"
#     email_password = os.getenv('EMAIL_PASSWORD')

#     if email_password is None:
#         print("Error: EMAIL_PASSWORD environment variable is not set.")
#         return

#     # Create the email
#     msg = MIMEMultipart()
#     msg['From'] = email_address
#     msg['To'] = ", ".join(to_addresses)
#     msg['Subject'] = subject

#     # Attach the body of the email if it's not empty
#     if body:
#         msg.attach(MIMEText(body, 'plain'))
#     else:
#         print("Warning: Email body is empty. No content will be sent.")

#     try:
#         # Connect to Gmail server and send the email asynchronously
#         await aiosmtplib.send(
#             message=msg,
#             hostname=smtp_server,
#             port=smtp_port,
#             username=email_address,
#             password=email_password,
#             start_tls=True
#         )
#         print('Email sent successfully!')
#     except Exception as e:
#         print(f"Failed to send email: {e}")
#     finally:
#         remove_csv_and_xlsx_files()
