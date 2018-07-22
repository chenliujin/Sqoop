# tinyint 类型会变成 boolean 类型

```
jdbc:mysql://localhost/test?tinyInt1isBit=false
```

# 日期 null

```
jdbc:mysql://localhost/test?zeroDateTimeBehavior=CONVERT_TO_NULL
```

