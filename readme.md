# Spending Tracker

*A spending tracker which offers insights into spending to allow users to better control their finances. First solo @CodeClan project - planned and built over 7 days in weeks 4 and 5. Ruby/Sinatra backend with a PostreSQL database, HTML5 and CSS3 used for frontend.*

![Profile Screenshot](/screenshots/profile.png)

## Features

* Dynamic insights into the users’ spending patterns to allow better money management

* Add and manage transactions, merchants and categories

* Users can "round up" transactions and add this to a savings pot

* Goal image updates based on user input

* Profile or dashboard view allowing users an overview of their spending on one page


## Screenshots

#### View all transactions
![All transactions](/screenshots/all_transactions.png)


#### View single transactions
![Transaction page](/screenshots/transaction_page.png)

#### New transaction
![New transaction](/screenshots/new_transaction.png)

#### Confirmation of savings made
![Savings Made](/screenshots/savings_made.png)

#### Category overview
![Category Overview](/screenshots/category_view.png)

#### Merchant overview
![Merchant Overview](/screenshots/merchant_view.png)


### Prerequisites

Prior to installation you will need the following installed on your machine -

* [Sinatra](http://sinatrarb.com/)
* [Sinatra::Contrib](http://sinatrarb.com/contrib/)
* [Ruby](https://www.ruby-lang.org/en/)
* [PostreSQL](https://www.postgresql.org/)
* [Pry](https://rubygems.org/gems/pry/versions/0.10.3)


### Installation

Here's how you can get the Spending Tracker running locally once you download the repository. This will need to be done from the local folder.

Create the database

```
createdb spending_tracker
```

Run database schema

```
psql -d spending_tracker -f db/spending_tracker.sql
```

Run seed file for creation of initial transactions, merchants and categories

```
ruby db/seeds.rb
```

Launch app

```
ruby app.rb
```

Finally, visit http://localhost:4567/ in your browser.
