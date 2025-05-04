# Investments Management App
Mobile application using Flutter and Serverpod to manage his investments.

## Class diagram
```mermaid
classDiagram
%% Relationships
Userinfo "1" *-- "n" WithdrawalRule
Userinfo "1" *-- "n" Transfer
Transfer "n" o-- "1" Stock


%% Classes
class Userinfo {
    int id
    String mail
}

class Transfer {
    int id
    double quantity
    double amount
}

class Stock {
    int id
    String symbol
    String name
    double value
    String currency
}

class WithdrawalRule {
    int id
    double fixed
    double percent
    double minimum
}

```