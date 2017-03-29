#!/usr/bin/env ruby

require 'aws-sdk'

PARTITION_COUNTS = 10000.freeze
BUCKET = 'bucket_name'.freeze

class SamplePartitionData
  def initialize
    @partition = 1
  end

  def bulk_create(partition_counts)
    raise ArgumentError, 'partition_counts must be Integer' unless limit.is_a?(Integer)

    limit.times do
      create
    end
  end

  def create
    s3.put_object(bucket: BUCKET, key: key, body: body)
    @partition += 1
  end

  private

  def key
    "partition_id=#{@partition}/hogehoge.csv"
  end

  def body
    <<~CSV
      this,is,sample,data
      this,is,sample,data
      this,is,sample,data
      this,is,sample,data
    CSV
  end

  def s3
    @s3 ||= Aws::S3::Client.new
  end
end

data = SamplePartitionData.new
data.bulk_create(PARTITION_COUNTS)
