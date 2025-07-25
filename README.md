# Investments Management App
Mobile application using Flutter and Serverpod to manage his investments.

## Class diagram
```mermaid
classDiagram
%% Relationships
Userinfo "1" *-- "n" WithdrawalRule
WithdrawalRule "1" *-- "n" WithdrawalFee
Userinfo "1" *-- "n" Investment
Investment "1" *-- "n" Transfer
Investment "n" o-- "1" WithdrawalRule
Investment "n" o-- "1" Stock


%% Classes
class Userinfo {
    int id
    String mail
}

class Investment {
    int id
    String name
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
    String name
    double currencyChangeFeePercentage
}

class WithdrawalFee {
    int id
    double fixed
    double percent
    double minimum
}

```