# README

## Assumptions

**Environment**
* Has postgres installed
* Ruby version 2.6.3

**Instructions**
* Accounts will have enough money for transfer ammount.
* Assignment said _"Every Branch Account may make transfers as long as the account to be transferred is under the same tree and is not a Parent Account."_, so made assumption that only Branch Accounts may make transfers and not Parent Accounts.
* Balance from Contributions and Deposits come from an infinite source of money. Balance from transfers comes from valid Branch Account.
* Reversing a `TransactionHistory` doesn't create a new `TransactionHistory` record. 


## Installation

**Initialization**
* run `bundle install` then `rails db:create` in root folder.

**Testing**
* run `rspec` in root folder.

