# Clark Coding Challenge

This application takes in an input of customers recommendations and acceptance and returns points which are different for each customer and is based on their invitees acceptance to their recommendations.

- Ruby version - `3.0.0`
- Dependencies
  - Rails
  - Byebug
  - RSpec
  - rexml
  - RSpec

## Installation

To run this project, I have created two options

- You need to install ruby, rails on your local machine and then run the rails console

  ```shell
  rails console
  ```

- You can make a post request with the input data to the provided url below

  ```shell
  curl --location --request POST 'https://clark-rewards.herokuapp.com/rewards' --data-raw '{"data": "2018-06-12 09:41 A recommends B \n 2018-06-14 09:41 B accepts \n 2018-06-16 09:41 B recommends C \n 2018-06-17 09:41 C accepts \n 2018-06-19 09:41 C recommends D \n 2018-06-23 09:41 B recommends D \n 2018-06-25 09:41 D accepts"}'
  ```

- 

