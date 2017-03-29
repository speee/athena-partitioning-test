## Result

## Query

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS partitioning_test (
  `first` string,
  `second` string,
  `third` string,
  `fourth` string
) PARTITIONED BY (
  partition_id int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = ',',
  'field.delim' = ','
) LOCATION 's3://bucket/';
```

```sql
MSCK REPAIR TABLE  partitioning_test;
```
