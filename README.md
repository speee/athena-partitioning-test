## Create sample partition data

```bash
$ bundle install
$ ./console.rb
irb(main):001:0> data = SamplePartitionData.new('bucket_name')
irb(main):002:0> data.create # create a partition
irb(main):003:0> data.bulk_create(1000) # create 1000 partitions
```

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
