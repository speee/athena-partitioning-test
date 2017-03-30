#!/usr/bin/env ruby

require 'aws-sdk'
require 'irb'

class SamplePartitionData
  def initialize(bucket, start_partition_id = 1)
    @bucket = bucket
    @partition_id = start_partition_id
  end

  def bulk_create(partition_counts)
    raise ArgumentError, 'partition_counts must be Integer' unless limit.is_a?(Integer)

    limit.times do
      create
    end
  end

  def create
    s3.put_object(bucket: @bucket, key: key, body: body)
    @partition_id += 1
  end

  private

  def key
    "partition_id=#{@partition_id}/hogehoge.csv"
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

IRB.start
