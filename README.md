# Data Engineering

Medium Article: [Data Engineering: From Web Scraping, APIs and Local Databases to Automated Data Pipelines in the Cloud](https://medium.com/@abigailflynn/data-engineering-from-web-scraping-apis-and-local-databases-to-automated-data-pipelines-in-the-d6acad858788)

## 1. Project Objectives & Overview

### 1.1. Business Problem

Gans is a startup developing an e-scooter-sharing system. It aspires to operate in the most populous cities all around the world. In each city, the company will have hundreds of e-scooters parked in the streets and allow users to rent them by the minute.

Through their marketing, focusing on the eco-friendly narrative, Gans has managed to acquire new users and gained good press. However, they have seen that its operational success simply depends on having the scooters parked in the right places.

Ideally, scooters get rearranged organically by having certain users moving from point A to point B, and then an even number of users moving from point B to point A. However, some elements create asymmetries. Here are some of them:

- In hilly cities, users tend to use scooters to go uphill and then walk downhill.
- In the morning, there is a general movement from residential neighbourhoods towards the city centre.
- Whenever it starts raining, e-scooter usage decreases drastically.
- Whenever planes with backpack young tourists land, a lot of scooters are needed close to the airport or close to the train stations that connect the Airport with the city centre.

Working as a Data Engineer for Gans my role was to collect data from external sources that can potentially help Gans predict e-scooter movement. Since data is needed every day, in real-time and accessible by everyone in the company, the challenge is going to be to assemble and automate a data pipeline in the cloud.

## 2. Data Collection 

### 2.1. Data Collection: Web Scraping

Web scrapping was used to collect the data on cities, the company suggested using Wikipedia. Using the library Beautiful Soup I was able to scrape the HTML pulling the data into python, from which dataframes can then be created. I used the prettify method to turn the Beautiful Soup parse tree into a nicely formatted unicode string, separated by line for each tag and string.I accessed the data by reading the HTML using tags, names and attributes and combine this with methods like find_all() and find_next().

After scraping the HTML to access the data I was able to take advantage of wikipedia urls being all the same besides the city name and create a function to run through multiple city pages. The function adds the data to a dictionary which can be easily converted to a dataframe. There are a few other hurdles with Wikipedia due to its unstructured HTML. For example, population is not at the same point on each wikipedia page, an if clause was used to ensure the code didn’t stop at this hurdle.

<img width="679" alt="Screenshot 2023-04-20 at 17 23 43" src="https://user-images.githubusercontent.com/120720780/233428275-4f720c59-2def-4993-b48b-ad4dcd493514.png">

### 2.2. Data Collection: APIs

**2.2.1. API: Weather Forecast**

I used OpenWeather an API that provides free weather forecasts. OpenWeather has a few different APIs but for this project I used the 5 Day Forecast. After requesting the data and formatting it into JSON. I was able to use python dictionary methods, such as .keys() to access the data. From reviewing the data it was clear the dictionary for each day and time followed the same format. Due to this I was able to create a function to access the data needed from different cities and create a data frame.

**2.2.2. API: Flight Arrival Data**

Rapid API is a marketplace for APIs and it takes care of writing the code to request APIs for you. I used the AeroDataBox API to access the flight arrivals data I needed. 

The process for then accessing the data in python is the same as the above approach using python dictionary methods. I again created a function to access the data in a dataframe format.The function uses today and tomorrow variables to automatically access the data for tomorrow because Gans wants the flight arrival times for the next day so they can plan ahead.

## 3. Data Storage

### 3.1. Data Storage: Locally with MySQL

After collecting the data and creating three data frames for cities, weather and flights it was time to store the data in a database where it can be easily analysed. I used My SQL Workbench to do this locally on my device.

**The Schema** 
<img width="674" alt="Screenshot 2023-04-20 at 17 29 19" src="https://user-images.githubusercontent.com/120720780/233429741-93bd7893-26fc-45fd-8ebe-f78f3ded5adc.png">

## 4. AWS: Pipelines on the Cloud

To use AWS you need to create an account which come with some free services for the first 12 months. AWS offers over 200 fully-featured services; for this project I used AWS RDS, AWS Lambda, AWS IAM, AWS EventBridge and AWS CloudWatch.

### 4.1. AWS RDS 

Amazon Relational Database Service is a service that makes setting up relational databases, such as MySQL, in the cloud really easy. After Amazon RDS instance is set up you need to connect it to your MySQL Workbench. Once the connection is set up between MySQL and Amazon RDS you can create a database with all of the tables to store the information for your project. 

### 4.2. AWS Lambda / AWS IAM

AWS Lambda is an event-driven, server-less computing platform that runs code in response to events and automatically manages the computing resources for you. Without worrying whether your computer has the power to run code.

To give the AWS Lambda access to the RDS service I first need to create a new Role in the AWS IAM which stands for Identity and Access Management.

Now, I can copy across my python code functions to my AWS Lambda. I can then create a lambda_handler function which will access all my python functions so they are all inside one code, as only the code inside lambda_handler() gets triggered. Within the lambda _handler function you also need to ensure you are including the code that connects to the RDS instance.

<img width="679" alt="Screenshot 2023-04-20 at 17 33 10" src="https://user-images.githubusercontent.com/120720780/233430602-8a51c780-4b4e-4605-9cfe-55d33d31ed90.png">

In some cases you need to add in layers to the AWS Lambda so they can access certain libraries that might be used within your python code. I used AWSDataWrangler-Python39 layer and a custom layer to import SQLAlchemy.

<img width="682" alt="Screenshot 2023-04-20 at 17 33 42" src="https://user-images.githubusercontent.com/120720780/233430712-38dbbe74-4f00-4ee0-8b95-552f8c261d8b.png">

### 4.3. AWS EventBridge

Amazon EventBridge is a amazon service that can be used to schedule events to trigger automatically at certain times, meaning you don’t have to push the button or create any kind of trigger to run your Lambda function. 

I was able to schedule an event to run at 8am every day. Therefore Gans would have the information about the upcoming weather forecast and flight arrivals ready to access.

### 4.4. AWS CloudWatch

AWS CloudWatch can be used to verify that the Lambda function was invoked with the EventBridge rule. If you see the Lambda event in the CloudWatch logs, you’ve successfully scheduled the event.

## 5. Project Summary

At the end of this project I now have my code running in the cloud every day at 08:00am collecting data from the Internet and saving it to a database in the cloud. Through implementing this, I have gained a strong understanding of the Data Engineering role from web scraping, APIs, local databases and automated data pipelines in the cloud. Below is a summary of what was covered in this project.

- **Data Collection:** Collecting required data from the internet using Web Scraping method with the library Beautiful Soup and APIs.
- **Data Storage:** Creating a Database in MySQL Workbench to store the data collected.
- **AWS: Pipelines on the Cloud:** Using Amazon Web Services (AWS) to move the pipeline to the cloud.
- **AWS: Pipeline Automation:** Automating the whole data collection and storage process to run at a set time daily.



