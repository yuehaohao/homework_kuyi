
### Problem

- 用户入驻分店需要签署租金合同，分店管理员会录入这个用户合同的开始结束日期，每月租金金额；用户可

以选择不同的交租周期，比如一个月，三个月，半年等，我们需要根据用户选择的交租周期给合同创建对应交

租阶段。

- 需求：根据输入的合同开始日期，合同结束日期，每月租金，交租周期，生成交租阶段，交租阶段需要包括

信息：每一阶段的开始，结束日期，每月租金，交租阶段总租金，每个交租阶段的交租日期。



- 交租阶段按照自然月分割，比如合同开始结束日期为`2020-11-16`到`2021-03-16`号，如果用户每两

个交租，那么得到的交租阶段日期分割结果应该是：`2020-11-16 ～ 2020-12-31`，

`2021-01-01 ～ 2021-02-28`，`2021-03-01 ～ 2021-03-16`。

- 交租日期的规则是：默认15号为交租日期，那么在创建交租阶段时，交租日期应为这个交租阶段开始日期

的前一个月对应的这一天，如果交租日期在`“合同开始/结束日期”`之外，则取合同开始日和结束月的第一天

作为默认日期。

### Quick Start

`ruby leasing_management.rb "start_date, end_date, rent, payment_period`
it will output all the payment periods with rend and payment date
eg.
`ruby leasing_management.rb "20200101, 20201231, 1000, 4"`
will output
```
leasing periods:
1.
range: 2020-01-01 ~ 2020-04-30
rent: 4000
payment_date: 2020-01-01
2.
range: 2020-05-01 ~ 2020-08-31
rent: 4000
payment_date: 2020-04-15
3.
range: 2020-09-01 ~ 2020-12-31
rent: 4000
payment_date: 2020-08-15
```

### Run Tests
`rspec` for tests
`rubocop` for styling
